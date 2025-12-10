/* ================================================================================
 DROP DE TABLAS BI (Business Intelligence)
================================================================================
   - Propósito: Eliminar todas las tablas de hechos y dimensiones del esquema BI
   - Orden: Primero las tablas de hechos (tienen FKs), luego las dimensiones
   - Uso: Ejecutar antes de recrear las tablas BI
*/

USE GD2C2025;
GO

-- ================================================================================
-- PASO 1: DROP DE TABLAS DE HECHOS (tienen FKs a las dimensiones)
-- ================================================================================

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Hechos_Encuestas', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Hechos_Encuestas;
GO

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Hechos_Financiero', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Hechos_Financiero;
GO

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Hechos_Evaluaciones_Finales', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Hechos_Evaluaciones_Finales;
GO

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Hechos_Resultados_Cursada', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Hechos_Resultados_Cursada;
GO

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Hechos_Inscripciones', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Hechos_Inscripciones;
GO

-- ================================================================================
-- PASO 2: DROP DE TABLAS DE DIMENSIONES (sin dependencias)
-- ================================================================================

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Dim_Bloque_Satisfaccion', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Dim_Bloque_Satisfaccion;
GO

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Profesor', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Profesor;
GO

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Dim_Tiempo', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Dim_Tiempo;
GO

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso;
GO

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Dim_Sede', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Dim_Sede;
GO

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Turno', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Turno;
GO

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Dim_Medio_Pago', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Dim_Medio_Pago;
GO

IF OBJECT_ID('GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Alumno', 'U') IS NOT NULL
    DROP TABLE GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Alumno;
GO

PRINT 'Todas las tablas BI han sido eliminadas correctamente.';
GO

-- ================================================================================
-- VISTAS
-- ================================================================================
DROP VIEW IF EXISTS GUARDIANES_DEL_DATO.BI_Vista_Top3_Categorias_Turnos;
GO

DROP VIEW IF EXISTS GUARDIANES_DEL_DATO.BI_Vista_Desempenio_Cursada;
GO

DROP VIEW IF EXISTS GUARDIANES_DEL_DATO.BI_Vista_Tasa_Rechazo_Inscripciones;
GO

DROP VIEW IF EXISTS GUARDIANES_DEL_DATO.BI_Vista_Tiempo_Finalizacion;
GO

DROP VIEW IF EXISTS GUARDIANES_DEL_DATO.BI_Vista_Ausentismo_Finales;
GO

DROP VIEW IF EXISTS GUARDIANES_DEL_DATO.BI_Vista_Desvio_Pagos;
GO

DROP VIEW IF EXISTS GUARDIANES_DEL_DATO.BI_Vista_Nota_Promedio_Finales;
GO

DROP VIEW IF EXISTS GUARDIANES_DEL_DATO.BI_Vista_Morosidad_Mensual;
GO

DROP VIEW IF EXISTS GUARDIANES_DEL_DATO.BI_Vista_Top3_Ingresos_Categorias;
GO

DROP VIEW IF EXISTS GUARDIANES_DEL_DATO.BI_Vista_Indice_Satisfaccion;
GO