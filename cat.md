# SQL Exam Sheet: View vs CTE vs Stored Procedure vs Function

> Examples use **T-SQL (SQL Server)** syntax. Differences for PostgreSQL/MySQL/Oracle are noted at the end.

**Sample tables used in all examples**

```sql
Customers(CustomerID, Name, Country)
Orders(OrderID, CustomerID, OrderDate, Total)
Employees(EmployeeID, Name, Salary, ManagerID, DepartmentID)
```

---

## 0. One-Glance Summary

| | **View** | **CTE** | **Stored Procedure** | **Function** |
|---|---|---|---|---|
| **Mental model** | A reusable way to *see* data | A temporary result I build and use *in this one query* | An *operation* the DB performs for me | A reusable operation that *gives something back* |
| **Stored in DB?** | Yes (permanent object) | **No** (exists only during one statement) | Yes | Yes |
| **Takes parameters?** | **No** | No | **Yes** (IN / OUT) | **Yes** (IN only) |
| **Returns** | A virtual table | A temporary named result set | Nothing, OUT params, return code, and/or result sets | **Must** return a scalar value or a table |
| **Called with** | `SELECT ... FROM view` | `WITH cte AS (...) SELECT ...` | `EXEC proc` | Inside a query: `SELECT fn(x)` or `FROM fn(x)` |
| **Can do INSERT/UPDATE/DELETE?** | Sometimes (simple views only) | Yes, as part of the statement (`WITH ... UPDATE`) | **Yes** | **No** (in most DBs, side-effect free) |
| **Usable inside a SELECT?** | Yes | It *is* part of the SELECT | **No** | **Yes** |
| **Main purpose** | Simplify, reuse, security | Readability, recursion, breaking down complex queries | Business logic, multi-step operations, data modification | Reusable calculations/lookups inside queries |

---

## 1. VIEW

**Definition:** A saved `SELECT` query stored in the database that behaves like a virtual table.
**Think:** *"A reusable way to see data."*

### Key facts
- Stores the **query**, not the data (a normal view holds no data of its own; each time you query it, the underlying query runs).
- Used like a table: `SELECT * FROM ViewName`.
- **No parameters.** (If you need parameters, use an inline table-valued function.)
- Benefits: simplify complex joins, reuse logic, **security** (hide columns/rows from users), consistent business definitions.
- **Materialized / Indexed view**: actually stores the result physically for speed (PostgreSQL: `MATERIALIZED VIEW`; SQL Server: indexed view). Needs refreshing (PostgreSQL) or is maintained automatically (SQL Server).
- Can be updatable (INSERT/UPDATE/DELETE) **only if** simple: single base table, no `GROUP BY`, `DISTINCT`, aggregates, `UNION`, etc.
- `ORDER BY` is not allowed in a view definition in SQL Server (unless used with `TOP`).

### Easy case
```sql
CREATE VIEW vw_CustomerList AS
SELECT CustomerID, Name, Country
FROM Customers;

-- Use
SELECT * FROM vw_CustomerList WHERE Country = 'Colombia';
```

### Complex case (joins + aggregation, reused by many queries)
```sql
CREATE VIEW vw_CustomerSalesSummary AS
SELECT  c.CustomerID,
        c.Name,
        c.Country,
        COUNT(o.OrderID)  AS NumOrders,
        SUM(o.Total)      AS TotalSpent,
        MAX(o.OrderDate)  AS LastOrderDate
FROM Customers c
LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.Name, c.Country;

-- Use: looks like a table, hides the join/aggregation logic
SELECT Name, TotalSpent
FROM vw_CustomerSalesSummary
WHERE TotalSpent > 10000;
```

### Security case (hide sensitive columns)
```sql
CREATE VIEW vw_EmployeePublic AS
SELECT EmployeeID, Name, DepartmentID   -- Salary is NOT exposed
FROM Employees;
-- Grant users access to the view only, not to the Employees table.
```

### Manage
```sql
ALTER VIEW vw_CustomerList AS ...;
DROP VIEW vw_CustomerList;
```

**Exam trap:** A view does **not** speed things up by itself (unless materialized/indexed). It is just a stored query.

---

## 2. CTE (Common Table Expression)

**Definition:** A temporary named result set defined with `WITH`, available **only for the single statement that follows it**.
**Think:** *"A temporary result I can build and then use in the main query."*

### Key facts
- Syntax: `WITH name AS ( query ) SELECT ... FROM name`.
- **Not stored** in the database. Disappears when the statement ends.
- Main goals: **readability**, avoiding repeated subqueries, breaking complex logic into steps, and **recursion**.
- Can define **multiple CTEs** separated by commas (one `WITH`).
- A CTE can reference **earlier** CTEs in the same `WITH`.
- Can be **recursive** (references itself), used for hierarchies (org charts, trees, bill of materials).
- Can be used with `SELECT`, `INSERT`, `UPDATE`, `DELETE`.
- A CTE is **not** a temp table: it is not materialized/stored (in general), cannot be indexed, and cannot be reused in a second statement.
- In SQL Server, the statement before `WITH` must end with `;`.

### Easy case
```sql
WITH BigOrders AS (
    SELECT OrderID, CustomerID, Total
    FROM Orders
    WHERE Total > 1000
)
SELECT * FROM BigOrders;
```

### Complex case A: multiple CTEs, building step by step
```sql
WITH CustomerTotals AS (
    SELECT CustomerID, SUM(Total) AS TotalSpent
    FROM Orders
    GROUP BY CustomerID
),
AverageSpend AS (
    SELECT AVG(TotalSpent) AS AvgSpent
    FROM CustomerTotals            -- uses the previous CTE
)
SELECT c.Name, ct.TotalSpent
FROM CustomerTotals ct
JOIN Customers c     ON c.CustomerID = ct.CustomerID
CROSS JOIN AverageSpend a
WHERE ct.TotalSpent > a.AvgSpent;  -- customers above average
```

### Complex case B: recursive CTE (hierarchy)
```sql
WITH OrgChart AS (
    -- 1) Anchor member: starting point (top of hierarchy)
    SELECT EmployeeID, Name, ManagerID, 0 AS Level
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- 2) Recursive member: joins back to the CTE itself
    SELECT e.EmployeeID, e.Name, e.ManagerID, oc.Level + 1
    FROM Employees e
    JOIN OrgChart oc ON e.ManagerID = oc.EmployeeID
)
SELECT * FROM OrgChart
ORDER BY Level;
```
**Recursive CTE = Anchor + `UNION ALL` + Recursive member (+ implicit termination when no rows are returned).**
SQL Server default recursion limit is 100 (`OPTION (MAXRECURSION n)` to change it). PostgreSQL/MySQL require `WITH RECURSIVE`.

### CTE used for deleting duplicates (classic)
```sql
WITH Dups AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Name, Country ORDER BY CustomerID) AS rn
    FROM Customers
)
DELETE FROM Dups WHERE rn > 1;
```

**Exam traps:**
- CTE vs View: view is **stored/permanent**, CTE is **temporary (one statement)**.
- CTE vs Temp table: temp table is physically stored in tempdb, can be reused across statements and indexed.

---

## 3. STORED PROCEDURE

**Definition:** A named, reusable block of SQL (one or many statements) stored in the database and executed on demand.
**Think:** *"An operation the database can perform for me."*

### Key facts
- Executed with `EXEC` / `EXECUTE` (or `CALL` in MySQL/PostgreSQL/Oracle).
- **Can** modify data (`INSERT`, `UPDATE`, `DELETE`), use transactions, control flow (`IF`, `WHILE`), `TRY...CATCH`, temp tables, dynamic SQL.
- **Parameters**: input, **OUTPUT**, optional defaults.
- May return: result sets, OUTPUT parameters, an integer return code.
- **Cannot** be used inside a `SELECT` (you can't write `SELECT * FROM my_proc`).
- Benefits: reuse, **performance** (execution plan caching), **security** (grant `EXEC` without table access), reduced network traffic, protection against SQL injection when parameterized, centralized business logic.
- Can call other procedures and functions.

### Easy case
```sql
CREATE PROCEDURE usp_GetCustomersByCountry
    @Country NVARCHAR(50)
AS
BEGIN
    SELECT CustomerID, Name
    FROM Customers
    WHERE Country = @Country;
END;

-- Use
EXEC usp_GetCustomersByCountry @Country = 'Colombia';
```

### Complex case (transaction + validation + error handling + OUTPUT)
```sql
CREATE PROCEDURE usp_PlaceOrder
    @CustomerID INT,
    @Total      DECIMAL(10,2),
    @NewOrderID INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID)
            THROW 50001, 'Customer does not exist.', 1;

        INSERT INTO Orders (CustomerID, OrderDate, Total)
        VALUES (@CustomerID, GETDATE(), @Total);

        SET @NewOrderID = SCOPE_IDENTITY();

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;   -- re-raise the error
    END CATCH
END;

-- Use
DECLARE @id INT;
EXEC usp_PlaceOrder @CustomerID = 5, @Total = 250.00, @NewOrderID = @id OUTPUT;
SELECT @id AS CreatedOrder;
```

### Manage
```sql
ALTER PROCEDURE usp_GetCustomersByCountry ...;
DROP PROCEDURE usp_GetCustomersByCountry;
```

**Exam traps:**
- Procedure **does not have to return a value**; a function **must**.
- Procedure **can** change data; function **generally cannot**.
- You **cannot** call a procedure inside a `SELECT`/`WHERE`/`JOIN`.

---

## 4. FUNCTION (User-Defined Function, UDF)

**Definition:** A reusable routine that **returns a value** (scalar) or **a table**, and can be used as part of a query/expression.
**Think:** *"A reusable operation that gives me something back."*

### Key facts
- **Must** return something (`RETURNS`).
- Used **inside** queries: in `SELECT`, `WHERE`, `JOIN`, `ORDER BY`, etc.
- **Input parameters only** (no OUTPUT).
- Generally **no side effects**: cannot modify table data (`INSERT/UPDATE/DELETE` on permanent tables), no transactions, limited error handling (`TRY...CATCH` not allowed in T-SQL functions).
- Three types in SQL Server:

| Type | Returns | Used like |
|---|---|---|
| **Scalar function** | A single value | `SELECT dbo.fn(x)` |
| **Inline table-valued function (iTVF)** | A table from a single `SELECT` | `SELECT * FROM dbo.fn(x)`, a **parameterized view** |
| **Multi-statement table-valued function (mTVF)** | A table built with multiple statements (table variable) | `SELECT * FROM dbo.fn(x)` |

- Performance note: scalar and multi-statement functions can be slow on large data (row by row execution). **Inline TVFs usually perform best** because the optimizer expands them like a view.

### Easy case: scalar function
```sql
CREATE FUNCTION dbo.fn_FullPrice (@Price DECIMAL(10,2), @TaxRate DECIMAL(4,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Price * (1 + @TaxRate);
END;

-- Use inside a query
SELECT OrderID, Total, dbo.fn_FullPrice(Total, 0.19) AS TotalWithTax
FROM Orders;
```

### Complex case A: inline table-valued function (parameterized view)
```sql
CREATE FUNCTION dbo.fn_OrdersByCustomer (@CustomerID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT OrderID, OrderDate, Total
    FROM Orders
    WHERE CustomerID = @CustomerID
);

-- Use as a table
SELECT * FROM dbo.fn_OrdersByCustomer(5);

-- Use with APPLY (call it per row of another table)
SELECT c.Name, o.OrderID, o.Total
FROM Customers c
CROSS APPLY dbo.fn_OrdersByCustomer(c.CustomerID) o;
```

### Complex case B: multi-statement table-valued function
```sql
CREATE FUNCTION dbo.fn_TopCustomers (@MinSpent DECIMAL(12,2))
RETURNS @Result TABLE (CustomerID INT, Name NVARCHAR(100), TotalSpent DECIMAL(12,2))
AS
BEGIN
    INSERT INTO @Result
    SELECT c.CustomerID, c.Name, SUM(o.Total)
    FROM Customers c
    JOIN Orders o ON o.CustomerID = c.CustomerID
    GROUP BY c.CustomerID, c.Name
    HAVING SUM(o.Total) >= @MinSpent;

    RETURN;
END;

SELECT * FROM dbo.fn_TopCustomers(5000);
```

### Manage
```sql
ALTER FUNCTION dbo.fn_FullPrice ...;
DROP FUNCTION dbo.fn_FullPrice;
```

**Exam traps:**
- Function **must** return a value; procedure may not.
- Function **can be used in SELECT**; procedure cannot.
- Function **cannot** do data modification (INSERT/UPDATE/DELETE on real tables); procedure can.
- Inline TVF = "view with parameters".

---

## 5. Procedure vs Function (the most tested comparison)

| Feature | **Stored Procedure** | **Function** |
|---|---|---|
| Return value | Optional | **Mandatory** |
| Return type | Result sets, OUT params, int code | Scalar value or table |
| Use in `SELECT` / `WHERE` | No | **Yes** |
| Called with | `EXEC` / `CALL` | Inside expressions/queries |
| INSERT/UPDATE/DELETE | **Allowed** | Not allowed (on permanent tables) |
| Transactions | **Allowed** | Not allowed |
| TRY...CATCH | **Allowed** | Not allowed (T-SQL) |
| OUTPUT parameters | **Yes** | No |
| Can call the other | Procedure can call functions | Function can't call procedures (generally) |
| Typical use | Business process / data change | Calculation / reusable lookup |

---

## 6. View vs CTE (second most tested comparison)

| Feature | **View** | **CTE** |
|---|---|---|
| Stored in database | **Yes** | No |
| Lifetime | Until dropped | One statement only |
| Reusable across queries | **Yes** | No |
| Recursion | No | **Yes** |
| Security (hide data) | **Yes** | No |
| Best for | Permanent shared definition | Structuring one complex query |

---

## 7. "Which one should I use?" Decision Guide

| Situation | Use |
|---|---|
| Many queries need the same join/filter logic, or I need to hide columns from users | **View** |
| One complex query is hard to read, or I need the same subquery twice in one query | **CTE** |
| Need to traverse a hierarchy (employee → manager, categories, tree) | **Recursive CTE** |
| Need to run a multi-step process, modify data, use transactions | **Stored Procedure** |
| Need a reusable calculation inside SELECT/WHERE (e.g., tax, formatting) | **Scalar Function** |
| Need a view that accepts parameters | **Inline Table-Valued Function** |
| Need to give users permission to perform an action but not touch tables | **Stored Procedure** |

---

## 8. Memory Hooks

- **View** = **V**irtual table, **V**iew only (saved SELECT).
- **CTE** = **C**hange-of-scope: **C**ontained in **one** statement, **T**emporary.
- **Procedure** = **P**erforms actions (can change data), **P**arameters in/out, **P**ermission-friendly.
- **Function** = **F**eeds back a value, **F**its inside a SELECT, **F**orbidden to change data.

**Rapid-fire exam answers**
1. *Does a view store data?* No, it stores a query (except materialized/indexed views).
2. *Can a view take parameters?* No (use an inline TVF).
3. *Is a CTE stored permanently?* No, lasts one statement.
4. *Can a CTE be recursive?* Yes (anchor + UNION ALL + recursive member).
5. *Can a function modify table data?* No.
6. *Can a procedure be called inside a SELECT?* No.
7. *Must a function return a value?* Yes.
8. *Must a procedure return a value?* No.
9. *Best-performing function type?* Inline table-valued function.
10. *Can a function have OUTPUT parameters?* No.

---

## 9. Dialect Notes (in case your course uses another DBMS)

| Topic | SQL Server | PostgreSQL | MySQL | Oracle |
|---|---|---|---|---|
| Call a procedure | `EXEC proc` | `CALL proc()` | `CALL proc()` | `EXEC proc` / `CALL` |
| Recursive CTE | `WITH` | `WITH RECURSIVE` | `WITH RECURSIVE` | `WITH` |
| Materialized view | Indexed view | `MATERIALIZED VIEW` | Not native | `MATERIALIZED VIEW` |
| Function that modifies data | Not allowed | Allowed (functions can) | Limited | Allowed in some cases |
| Procedures | Yes | Yes (v11+) | Yes | Yes (PL/SQL) |

> **Always check which dialect your exam uses.** The *concepts* above are universal; syntax details vary.
