SELECT ROUND(
        AVG(
            EXTRACT(
                YEAR
                FROM AGE(date_of_birth)
            )
        )
    ) AS average_age
FROM persona;