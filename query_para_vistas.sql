USE GD2C2025;
GO
-- ==============================================================
-- Vista 1: Top 3 Categorías de Cursos con más inscriptos por Turno
-- ==============================================================
SELECT *
FROM GUARDIANES_DEL_DATO.BI_Vista_Top3_Categorias_Turnos
ORDER BY anio DESC, sede_nombre, total_inscriptos_categoria DESC;
GO
-- ==============================================================
-- Vista 2: Porcentaje de rechazo de inscripciones por mes y sede
-- ==============================================================
SELECT anio, mes, sede_nombre, porcentaje_rechazo
FROM GUARDIANES_DEL_DATO.BI_Vista_Tasa_Rechazo_Inscripciones
ORDER BY anio DESC, mes DESC, sede_nombre;
GO
-- ==============================================================
-- Vista 3: Porcentaje de alumnos que aprobaron la cursada
-- ==============================================================
SELECT anio, sede_nombre, porcentaje_aprobacion
FROM GUARDIANES_DEL_DATO.BI_Vista_Desempenio_Cursada
ORDER BY anio DESC, sede_nombre;
GO
-- ==============================================================
-- Vista 4: Tiempo promedio (en días) para finalizar una carrera/curso
-- ==============================================================
SELECT anio_inicio, categoria_descripcion, tiempo_promedio_dias
FROM GUARDIANES_DEL_DATO.BI_Vista_Tiempo_Finalizacion
ORDER BY anio_inicio DESC, categoria_descripcion;
GO
-- ==============================================================
-- Vista 5: Nota promedio de finales por rango etario y categoría
-- ==============================================================
SELECT
    anio,
    semestre,
    rango_etario,
    categoria_descripcion,
    nota_promedio
FROM GUARDIANES_DEL_DATO.BI_Vista_Nota_Promedio_Finales
ORDER BY anio DESC, semestre DESC, rango_etario, categoria_descripcion;
GO
-- ==============================================================
-- Vista 6: Porcentaje de ausentismo en finales
-- ==============================================================
SELECT anio, semestre, sede_nombre, porcentaje_ausentes
FROM GUARDIANES_DEL_DATO.BI_Vista_Ausentismo_Finales
ORDER BY anio DESC, semestre DESC, sede_nombre;
GO
-- ==============================================================
-- Vista 7: Porcentaje de pagos realizados fuera de término
-- ==============================================================
SELECT anio, semestre, porcentaje_fuera_termino
FROM GUARDIANES_DEL_DATO.BI_Vista_Desvio_Pagos
ORDER BY anio DESC, semestre DESC;
GO
-- ==============================================================
-- Vista 8: Tasa de Morosidad Financiera mensual
-- ==============================================================
SELECT anio, mes, tasa_morosidad
FROM GUARDIANES_DEL_DATO.BI_Vista_Morosidad_Mensual
ORDER BY anio DESC, mes DESC;
GO
-- ==============================================================
-- Vista 9: Top 3 Categorías con mayores ingresos por sede y año
-- ==============================================================
SELECT anio, sede_nombre, ranking, categoria_descripcion, total_ingresos
FROM GUARDIANES_DEL_DATO.BI_Vista_Top3_Ingresos_Categorias
ORDER BY anio DESC, sede_nombre, ranking;
GO
-- ==============================================================
-- Vista 10: Índice de satisfacción anual por rango etario de profesor
-- ==============================================================
SELECT anio, sede_nombre, rango_etario_profesor, indice_satisfaccion
FROM GUARDIANES_DEL_DATO.BI_Vista_Indice_Satisfaccion
ORDER BY anio DESC, sede_nombre, rango_etario_profesor;
GO