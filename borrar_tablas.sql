USE [GD2C2025]
GO

-- Borrar procedimientos
DROP PROCEDURE IF EXISTS migrar_datos
DROP PROCEDURE IF EXISTS crear_tablas
GO

-- Borrar todas las FK del schema
DECLARE @sql NVARCHAR(MAX) = ''
SELECT @sql = @sql + 
    'ALTER TABLE ' + QUOTENAME(SCHEMA_NAME(fk.schema_id)) + '.' + QUOTENAME(OBJECT_NAME(fk.parent_object_id)) +
    ' DROP CONSTRAINT ' + QUOTENAME(fk.name) + '; '
FROM sys.foreign_keys fk
WHERE SCHEMA_NAME(fk.schema_id) = 'GUARDIANES_DEL_DATO'

IF @sql <> ''
BEGIN
    PRINT 'Eliminando FKs...'
    EXEC sp_executesql @sql
    PRINT 'FKs eliminadas correctamente'
END
ELSE
BEGIN
    PRINT 'No hay FKs para eliminar'
END
GO

-- Borrar todas las tablas del schema
DECLARE @sql2 NVARCHAR(MAX) = ''
SELECT @sql2 = @sql2 + 
    'DROP TABLE ' + QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) + '; '
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'GUARDIANES_DEL_DATO'
  AND TABLE_TYPE = 'BASE TABLE'

IF @sql2 <> ''
BEGIN
    PRINT 'Eliminando tablas...'
    EXEC sp_executesql @sql2
    PRINT 'Tablas eliminadas correctamente'
END
ELSE
BEGIN
    PRINT 'No hay tablas para eliminar'
END
GO

-- Borrar el schema
IF EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'GUARDIANES_DEL_DATO')
BEGIN
    PRINT 'Eliminando schema GUARDIANES_DEL_DATO...'
    DROP SCHEMA GUARDIANES_DEL_DATO
    PRINT 'Schema eliminado correctamente'
END
ELSE
BEGIN
    PRINT 'El schema GUARDIANES_DEL_DATO no existe'
END
GO

PRINT 'Limpieza completada exitosamente'
GO