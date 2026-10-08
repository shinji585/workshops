
SELECT 
    nombre, 
    precio_unitario
FROM producto
WHERE precio_unitario > 500
ORDER BY precio_unitario DESC;


SELECT 
    ciudad_residencia, 
    COUNT(*) AS total_clientes
FROM cliente
GROUP BY ciudad_residencia;

SELECT 
    AVG(salario) AS salario_promedio,
    MAX(salario) AS salario_maximo,
    MIN(salario) AS salario_minimo
FROM empleado;



SELECT 
    p.nombre AS producto,
    p.precio_unitario AS precio,
    c.nombre AS categoria
FROM producto p
INNER JOIN categoria c ON p.id_categoria = c.id;

SELECT 
    pd.nombre,
    pd.apellido,
    v.id AS codigo_venta,
    v.fecha
FROM venta v
INNER JOIN cliente c ON v.id_cliente = c.id
INNER JOIN persona_data pd ON c.id_personal_data = pd.id;

SELECT 
    v.id AS codigo_venta,
    CONCAT(pd_emp.nombre, ' ', pd_emp.apellido) AS nombre_empleado,
    CONCAT(pd_cli.nombre, ' ', pd_cli.apellido) AS nombre_cliente
FROM venta v
INNER JOIN empleado e ON v.id_empleado = e.id
INNER JOIN persona_data pd_emp ON e.id_personal_data = pd_emp.id
INNER JOIN cliente c ON v.id_cliente = c.id
INNER JOIN persona_data pd_cli ON c.id_personal_data = pd_cli.id;

SELECT 
    p.nombre AS producto,
    dv.cantidad,
    dv.precio_unitario,
    (dv.cantidad * dv.precio_unitario) AS subtotal
FROM detalle_venta dv
INNER JOIN producto p ON dv.id_producto = p.id
WHERE dv.id_venta = 101;



SELECT 
    CONCAT(pd.nombre, ' ', pd.apellido) AS cliente,
    COALESCE(SUM(dv.cantidad * dv.precio_unitario), 0) AS total_gastado
FROM cliente c
INNER JOIN persona_data pd ON c.id_personal_data = pd.id
INNER JOIN venta v ON c.id = v.id_cliente
INNER JOIN detalle_venta dv ON v.id = dv.id_venta
GROUP BY c.id, pd.nombre, pd.apellido;

SELECT 
    p.nombre AS producto,
    SUM(dv.cantidad) AS total_unidades_vendidas
FROM detalle_venta dv
INNER JOIN producto p ON dv.id_producto = p.id
GROUP BY p.id, p.nombre
ORDER BY total_unidades_vendidas DESC
LIMIT 3;

SELECT 
    CONCAT(pd.nombre, ' ', pd.apellido) AS empleado,
    COALESCE(SUM(dv.cantidad * dv.precio_unitario), 0) AS total_ventas
FROM empleado e
INNER JOIN persona_data pd ON e.id_personal_data = pd.id
INNER JOIN venta v ON e.id = v.id_empleado
INNER JOIN detalle_venta dv ON v.id = dv.id_venta
GROUP BY e.id, pd.nombre, pd.apellido
ORDER BY total_ventas DESC;



SELECT 
    c.nombre AS categoria,
    COUNT(p.id) AS cantidad_productos
FROM categoria c
LEFT JOIN producto p ON c.id = p.id_categoria
GROUP BY c.id, c.nombre;

SELECT 
    CONCAT(pd.nombre, ' ', pd.apellido) AS cliente,
    COUNT(v.id) AS total_compras
FROM cliente c
INNER JOIN persona_data pd ON c.id_personal_data = pd.id
INNER JOIN venta v ON c.id = v.id_cliente
GROUP BY c.id, pd.nombre, pd.apellido
HAVING COUNT(v.id) > 3;