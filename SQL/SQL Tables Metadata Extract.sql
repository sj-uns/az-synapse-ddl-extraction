SELECT
    sch.name AS SchemaName,
    t.name AS TableName,
    c.name AS ColumnName,
    ty.name AS DataType,
    COALESCE(inf_cols.character_maximum_length, c.max_length) AS MaxLength,
    c.precision,
    c.scale,
    c.is_nullable,
    c.is_identity,
    c.column_id AS OrdinalPosition,
    dp.distribution_policy_desc AS DistributionType,
    i.type_desc AS IndexType,
    col_dist_prop.HashDistributionColumnName
FROM 
    sys.columns c
LEFT JOIN 
    sys.tables t ON c.object_id = t.object_id
LEFT JOIN 
    sys.schemas sch ON t.schema_id = sch.schema_id
LEFT JOIN 
    sys.types ty ON c.user_type_id = ty.user_type_id
LEFT JOIN 
    sys.index_columns ic ON c.object_id = ic.object_id AND c.column_id = ic.column_id
LEFT JOIN 
    sys.indexes i ON ic.object_id = i.object_id AND ic.index_id = i.index_id
LEFT JOIN 
    sys.pdw_table_distribution_properties dp ON t.object_id = dp.object_id
LEFT JOIN
	(
		SELECT
			cdp.object_id
			, STRING_AGG(hc.name, ', ') AS HashDistributionColumnName
		FROM
			sys.pdw_column_distribution_properties cdp
		LEFT JOIN
			sys.columns hc ON cdp.object_id = hc.object_id AND cdp.column_id = hc.column_id
		WHERE
			cdp.distribution_ordinal > 0
		GROUP BY
			cdp.object_id
	) col_dist_prop
	ON c.object_id = col_dist_prop.object_id
LEFT JOIN
    information_schema.columns inf_cols ON inf_cols.table_schema = sch.name AND inf_cols.table_name = t.name AND inf_cols.column_name = c.name

ORDER BY
    sch.name,
    t.name,
    c.column_id;