SELECT
    SchemaName,
    ObjectName,
    ObjectDefinition,
    ObjectType
FROM
(
    /* Views */
    SELECT
        sch.name AS SchemaName,
        v.name AS ObjectName,
        m.definition AS ObjectDefinition,
        'Views' AS ObjectType
    FROM 
        sys.views v
    JOIN 
        sys.schemas sch ON v.schema_id = sch.schema_id
    JOIN 
        sys.sql_modules m ON v.object_id = m.object_id

    UNION

    /* Stored Procedures */
    SELECT
        sch.name AS SchemaName,
        p.name AS ObjectName,
        m.definition AS ObjectDefinition,
        'Stored Procedures' AS ObjectType
    FROM 
        sys.procedures p
    JOIN 
        sys.schemas sch ON p.schema_id = sch.schema_id
    JOIN 
        sys.sql_modules m ON p.object_id = m.object_id

    UNION

    /* Functions */
    SELECT
        sch.name AS SchemaName,
        f.name AS ObjectName,
        m.definition AS ObjectDefinition,
        'Functions' AS ObjectType
    FROM 
        sys.objects f
    JOIN 
        sys.schemas sch ON f.schema_id = sch.schema_id
    JOIN 
        sys.sql_modules m ON f.object_id = m.object_id
    WHERE
        f.type IN ('FN', 'IF', 'TF')  -- 'FN' for scalar functions, 'IF' for inline table-valued functions, 'TF' for multi-statement table-valued functions
) md

ORDER BY
    ObjectType
    SchemaName,
    ObjectName;
    