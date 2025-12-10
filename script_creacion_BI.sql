USE GD2C2025;
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Alumno
(
    rango_etario_id int IDENTITY(1,1) PRIMARY KEY,
    rango_descripcion nvarchar(50)
);
GO

INSERT INTO GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Alumno
    (rango_descripcion)
VALUES
    ('<25'),
    ('25-35'),
    ('35-50'),
    ('>50');
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Dim_Medio_Pago
(
    medio_pago_bi_id int IDENTITY(1,1) PRIMARY KEY,
    medio_pago_id_transaccional int,
    medio_pago_nombre nvarchar(255)
);
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Dim_Sede
(
    sede_id INT IDENTITY(1,1) PRIMARY KEY,
    sede_id_transaccional INT,
    sede_nombre NVARCHAR(255),
    sede_localidad NVARCHAR(255),
    sede_provincia NVARCHAR(255)
);
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Turno
(
    turno_id INT IDENTITY,
    turno_descripcion VARCHAR(60),

    CONSTRAINT PK_BI_Turno PRIMARY KEY (turno_id)
)
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso
(
    categoria_id INT IDENTITY(1,1) PRIMARY KEY,
    categoria_id_transaccional INT,
    categoria_descripcion NVARCHAR(255)
);
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Dim_Tiempo
(
    tiempo_id INT PRIMARY KEY,
    fecha DATE,
    anio INT,
    cuatrimestre INT,
    semestre INT,
    mes INT,
    dia INT
);
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Profesor
(
    rango_etario_id INT IDENTITY(1,1) PRIMARY KEY,
    rango_descripcion NVARCHAR(50)
);

INSERT INTO GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Profesor
    (rango_descripcion)
VALUES
    ('25-35'),
    ('35-50'),
    ('>50'); 
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Dim_Bloque_Satisfaccion
(
    bloque_id INT IDENTITY(1,1) PRIMARY KEY,
    bloque_descripcion NVARCHAR(50)
);

INSERT INTO GUARDIANES_DEL_DATO.BI_Dim_Bloque_Satisfaccion
    (bloque_descripcion)
VALUES
    ('Satisfechos: Notas entre 7 y 10'),
    ('Neutrales: Notas entre 5 y 6'),
    ('Insatisfechos: Notas entre 1 y 4'); 
GO


USE GD2C2025; 
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Hechos_Inscripciones
(
    insc_id INT IDENTITY(1,1) PRIMARY KEY,

    -- FKs a Dimensiones
    insc_tiempo_inscripcion INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Tiempo(tiempo_id),
    insc_sede INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Sede(sede_id),
    insc_categoria_curso INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso(categoria_id),
    insc_rango_etario_alumno INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Alumno(rango_etario_id),

    insc_turno_curso INT REFERENCES GUARDIANES_DEL_DATO.BI_Turno(turno_id),

    -- Métricas
    insc_cant_inscriptos INT DEFAULT 1,
    insc_cant_rechazados INT DEFAULT 0
);
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Hechos_Resultados_Cursada
(
    resCur_id INT IDENTITY(1,1) PRIMARY KEY,

    -- FKs a Dimensiones
    resCur_tiempo INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Tiempo(tiempo_id),
    resCur_sede INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Sede(sede_id),
    resCur_rango_etario_alumno INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Alumno(rango_etario_id),
    resCur_categoria_curso INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso(categoria_id),
    resCur_turno INT REFERENCES GUARDIANES_DEL_DATO.BI_Turno(turno_id),

    -- Métricas
    resCur_cursada_aprobada INT,
    resCur_total_alumnos INT DEFAULT 1
);
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Hechos_Evaluaciones_Finales
(
    evalF_id INT IDENTITY(1,1),

    -- Dimensiones (FKs)
    evalF_tiempo INT,
    evalF_sede INT,
    evalF_curso INT,
    evalF_rango_etario_alumno INT,

    -- Métricas
    evalF_nota_final DECIMAL(4,2),
    evalF_es_ausente INT,
    evalF_dias_para_finalizar INT,

    PRIMARY KEY (evalF_id),

    -- Definición de FKs
    FOREIGN KEY (evalF_tiempo) REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Tiempo(tiempo_id),
    FOREIGN KEY (evalF_sede) REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Sede(sede_id),
    FOREIGN KEY (evalF_curso) REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso(categoria_id),
    FOREIGN KEY (evalF_rango_etario_alumno) REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Alumno(rango_etario_id)
);
GO


CREATE TABLE GUARDIANES_DEL_DATO.BI_Hechos_Financiero
(
    finan_id INT IDENTITY(1,1) PRIMARY KEY,

    -- FKs a Dimensiones
    finan_tiempo INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Tiempo(tiempo_id),
    finan_sede INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Sede(sede_id),
    finan_categoria_curso INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso(categoria_id),
    finan_medio_de_pago INT NULL REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Medio_Pago(medio_pago_bi_id),

    -- Métricas
    finan_importe_facturado DECIMAL(12,2),
    finan_importe_pagado DECIMAL(12,2) DEFAULT 0,
    finan_importe_adeudado DECIMAL(12,2),
    finan_fuera_termino INT DEFAULT 0
);
GO

CREATE TABLE GUARDIANES_DEL_DATO.BI_Hechos_Encuestas
(
    encuesta_id INT IDENTITY(1,1) PRIMARY KEY,

    -- FKs a Dimensiones
    encuesta_tiempo INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Tiempo(tiempo_id),
    encuesta_sede INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Sede(sede_id),
    encuesta_rangoEtarioProf INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Profesor(rango_etario_id),
    encuesta_bloqueSatisfaccion INT REFERENCES GUARDIANES_DEL_DATO.BI_Dim_Bloque_Satisfaccion(bloque_id),

    -- Métricas
    encuesta_cantRespuestas INT DEFAULT 1,
    encuesta_nota_obtenida INT
);
GO

-- MIGRACION DE DIM
INSERT INTO GUARDIANES_DEL_DATO.BI_Dim_Medio_Pago
    (medio_pago_id_transaccional, medio_pago_nombre)
SELECT
    medioPago_id,
    medioPago_nombre
FROM GUARDIANES_DEL_DATO.MedioDePago;
GO

INSERT INTO GUARDIANES_DEL_DATO.BI_Dim_Sede
    (sede_id_transaccional, sede_nombre, sede_localidad, sede_provincia)
SELECT
    s.sede_id,
    s.sede_nombre,
    l.localidad_nombre,
    p.prov_nombre
FROM GUARDIANES_DEL_DATO.Sede s
    JOIN GUARDIANES_DEL_DATO.Localidad l ON s.sede_localidad = l.localidad_id
    JOIN GUARDIANES_DEL_DATO.Provincia p ON l.localidad_provincia = p.prov_id;
GO

INSERT INTO GUARDIANES_DEL_DATO.BI_Turno
    (turno_descripcion)
SELECT DISTINCT turno_descripcion
FROM GUARDIANES_DEL_DATO.Turno;
GO

INSERT INTO GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso
    (categoria_id_transaccional, categoria_descripcion)
SELECT
    cateCurso_id,
    cateCurso_descripcion

FROM GUARDIANES_DEL_DATO.CategoriaCurso;
GO

BEGIN TRANSACTION
DECLARE @FechaDesde DATE;
DECLARE @FechaHasta DATE;

CREATE TABLE #Fechas_Calculo
(
    fecha DATE
);

INSERT INTO #Fechas_Calculo
    (fecha)
SELECT insc_fecha
FROM GUARDIANES_DEL_DATO.Inscripcion
WHERE insc_fecha IS NOT NULL;
INSERT INTO #Fechas_Calculo
    (fecha)
SELECT curs_fechaInicio
FROM GUARDIANES_DEL_DATO.Curso
WHERE curs_fechaInicio IS NOT NULL;
INSERT INTO #Fechas_Calculo
    (fecha)
SELECT curs_fechaFin
FROM GUARDIANES_DEL_DATO.Curso
WHERE curs_fechaFin IS NOT NULL;
INSERT INTO #Fechas_Calculo
    (fecha)
SELECT fact_fechaEmision
FROM GUARDIANES_DEL_DATO.Factura
WHERE fact_fechaEmision IS NOT NULL;
INSERT INTO #Fechas_Calculo
    (fecha)
SELECT pago_fecha
FROM GUARDIANES_DEL_DATO.Pago
WHERE pago_fecha IS NOT NULL;
INSERT INTO #Fechas_Calculo
    (fecha)
SELECT eval_fecha
FROM GUARDIANES_DEL_DATO.Evaluacion
WHERE eval_fecha IS NOT NULL;
INSERT INTO #Fechas_Calculo
    (fecha)
SELECT mesaExam_fecha
FROM GUARDIANES_DEL_DATO.MesaExamen
WHERE mesaExam_fecha IS NOT NULL;
INSERT INTO #Fechas_Calculo
    (fecha)
SELECT encuesta_fechaRegistro
FROM GUARDIANES_DEL_DATO.Encuesta
WHERE encuesta_fechaRegistro IS NOT NULL;

SELECT @FechaDesde = MIN(fecha), @FechaHasta = MAX(fecha)
FROM #Fechas_Calculo;

DROP TABLE #Fechas_Calculo;

WHILE @FechaDesde <= @FechaHasta
    BEGIN
    INSERT INTO GUARDIANES_DEL_DATO.BI_Dim_Tiempo
        (
        tiempo_id,
        fecha,
        anio,
        cuatrimestre,
        semestre,
        mes,
        dia
        )
    VALUES
        (
            YEAR(@FechaDesde) * 10000 + MONTH(@FechaDesde) * 100 + DAY(@FechaDesde),
            @FechaDesde,
            YEAR(@FechaDesde),
            CASE 
                WHEN MONTH(@FechaDesde) BETWEEN 1 AND 4 THEN 1
                WHEN MONTH(@FechaDesde) BETWEEN 5 AND 8 THEN 2
                ELSE 3 
            END, -- Cuatrimestre
            CASE 
                WHEN MONTH(@FechaDesde) BETWEEN 1 AND 6 THEN 1
                ELSE 2 
            END, -- Semestre
            MONTH(@FechaDesde),
            DAY(@FechaDesde)
        );

    SET @FechaDesde = DATEADD(DAY, 1, @FechaDesde);
END

COMMIT TRANSACTION;
GO

-- MIGRACION DE HECHOS
INSERT INTO GUARDIANES_DEL_DATO.BI_Hechos_Inscripciones
    (
    insc_tiempo_inscripcion,
    insc_sede,
    insc_categoria_curso,
    insc_rango_etario_alumno,
    insc_turno_curso,
    insc_cant_inscriptos,
    insc_cant_rechazados
    )
SELECT
    t.tiempo_id,
    s_bi.sede_id,
    c_bi.categoria_id,
    re.rango_etario_id,
    tu.turno_id,
    SUM(1) AS insc_cant_inscriptos,
    SUM(CASE WHEN e.estado_descripcion = 'Rechazada' THEN 1 ELSE 0 END) AS insc_cant_rechazados
FROM GUARDIANES_DEL_DATO.Inscripcion i
    JOIN GUARDIANES_DEL_DATO.Curso c ON i.insc_curso = c.curs_id
    JOIN GUARDIANES_DEL_DATO.Alumno a ON i.insc_alumno = a.alum_legajo
    JOIN GUARDIANES_DEL_DATO.Estado e ON i.insc_estado = e.estado_id
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Tiempo t ON t.fecha = i.insc_fecha
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Sede s_bi ON s_bi.sede_id_transaccional = c.curs_sede
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso c_bi ON c_bi.categoria_id_transaccional = c.curs_categoria
    JOIN GUARDIANES_DEL_DATO.Horario h ON h.horario_curso = c.curs_id
    JOIN GUARDIANES_DEL_DATO.BI_Turno tu ON tu.turno_descripcion = (
        SELECT TOP 1
        T.turno_descripcion
    FROM GUARDIANES_DEL_DATO.Turno T
    WHERE T.turno_id = h.horario_turno
    )
    LEFT JOIN GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Alumno re
    ON (re.rango_descripcion = '<25' AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) < 25)
        OR (re.rango_descripcion = '25-35' AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) >= 25 AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) < 35)
        OR (re.rango_descripcion = '35-50' AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) >= 35 AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) <= 50)
        OR (re.rango_descripcion = '>50' AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) > 50)
GROUP BY
    t.tiempo_id,
    s_bi.sede_id,
    c_bi.categoria_id,
    re.rango_etario_id,
    tu.turno_id;
GO

INSERT INTO GUARDIANES_DEL_DATO.BI_Hechos_Financiero
    (
    finan_tiempo,
    finan_sede,
    finan_categoria_curso,
    finan_medio_de_pago,
    finan_importe_facturado,
    finan_importe_pagado,
    finan_importe_adeudado,
    finan_fuera_termino
    )
SELECT
    t_emi.tiempo_id,
    s_bi.sede_id,
    c_bi.categoria_id,
    mp_bi.medio_pago_bi_id,
    SUM(df.detaFact_importe) AS finan_importe_facturado,
    SUM(CASE WHEN p.pago_id IS NOT NULL THEN df.detaFact_importe ELSE 0 END) AS finan_importe_pagado,
    SUM(CASE WHEN p.pago_id IS NULL THEN df.detaFact_importe ELSE 0 END) AS finan_importe_adeudado,
    SUM(CASE WHEN p.pago_id IS NOT NULL AND p.pago_fecha > f.fact_fechaVencimiento THEN 1 ELSE 0 END) AS finan_fuera_termino
FROM GUARDIANES_DEL_DATO.DetalleFactura df
    JOIN GUARDIANES_DEL_DATO.Factura f ON df.detaFact_factura = f.fact_numero
    JOIN GUARDIANES_DEL_DATO.Curso c ON df.detaFact_curso = c.curs_id
    LEFT JOIN GUARDIANES_DEL_DATO.Pago p ON p.pago_factura = f.fact_numero
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Tiempo t_emi ON t_emi.fecha = f.fact_fechaEmision
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Sede s_bi ON s_bi.sede_id_transaccional = c.curs_sede
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso c_bi ON c_bi.categoria_id_transaccional = c.curs_categoria
    LEFT JOIN GUARDIANES_DEL_DATO.BI_Dim_Medio_Pago mp_bi ON mp_bi.medio_pago_id_transaccional = p.pago_medioDePago
GROUP BY
    t_emi.tiempo_id,
    s_bi.sede_id,
    c_bi.categoria_id,
    mp_bi.medio_pago_bi_id;
GO

SELECT tp_alumno, tp_curso,
    CASE WHEN tp_nota >= 4 THEN 1 ELSE 0 END as tp_aprobado
INTO #Temp_TP_Status
FROM GUARDIANES_DEL_DATO.TrabajoPractico;

SELECT
    e.eval_alumno,
    c.curs_id,
    COUNT(DISTINCT mc.moduCurso_modulo) as modulos_aprobados
INTO #Temp_Modulos_Status
FROM GUARDIANES_DEL_DATO.Evaluacion e
    JOIN GUARDIANES_DEL_DATO.ModuloCurso mc ON e.eval_moduloCurso = mc.moduCurso_id
    JOIN GUARDIANES_DEL_DATO.Curso c ON mc.moduCurso_curso = c.curs_id
WHERE e.eval_nota >= 4
GROUP BY e.eval_alumno, c.curs_id;

SELECT moduCurso_curso, COUNT(moduCurso_modulo) as total_modulos
INTO #Temp_Curso_Modulos
FROM GUARDIANES_DEL_DATO.ModuloCurso
GROUP BY moduCurso_curso;

INSERT INTO GUARDIANES_DEL_DATO.BI_Hechos_Resultados_Cursada
    (
    resCur_tiempo,
    resCur_sede,
    resCur_rango_etario_alumno,
    resCur_categoria_curso,
    resCur_turno,
    resCur_cursada_aprobada,
    resCur_total_alumnos
    )
SELECT
    t.tiempo_id,
    s_bi.sede_id,
    re.rango_etario_id,
    c_bi.categoria_id,
    tu.turno_id,
    SUM(CASE WHEN ISNULL(tp.tp_aprobado, 0) = 1 AND ISNULL(ms.modulos_aprobados, 0) = cm.total_modulos THEN 1 ELSE 0 END) AS resCur_cursada_aprobada,
    COUNT(*) AS resCur_total_alumnos
FROM GUARDIANES_DEL_DATO.Inscripcion i
    JOIN GUARDIANES_DEL_DATO.Curso c ON i.insc_curso = c.curs_id
    JOIN GUARDIANES_DEL_DATO.Alumno a ON i.insc_alumno = a.alum_legajo
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Tiempo t ON t.fecha = c.curs_fechaInicio
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Sede s_bi ON s_bi.sede_id_transaccional = c.curs_sede
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso c_bi ON c_bi.categoria_id_transaccional = c.curs_categoria
    JOIN GUARDIANES_DEL_DATO.Horario h ON h.horario_curso = c.curs_id
    JOIN GUARDIANES_DEL_DATO.BI_Turno tu ON tu.turno_descripcion = (
        SELECT TOP 1
        T.turno_descripcion
    FROM GUARDIANES_DEL_DATO.Turno T
    WHERE T.turno_id = h.horario_turno
    )
    LEFT JOIN GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Alumno re
    ON (re.rango_descripcion = '<25' AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) < 25)
        OR (re.rango_descripcion = '25-35' AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) >= 25 AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) < 35)
        OR (re.rango_descripcion = '35-50' AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) >= 35 AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) <= 50)
        OR (re.rango_descripcion = '>50' AND DATEDIFF(YEAR, a.alum_fechNacimiento, GETDATE()) > 50)
    LEFT JOIN #Temp_TP_Status tp ON tp.tp_alumno = i.insc_alumno AND tp.tp_curso = i.insc_curso
    LEFT JOIN #Temp_Modulos_Status ms ON ms.eval_alumno = i.insc_alumno AND ms.curs_id = i.insc_curso
    LEFT JOIN #Temp_Curso_Modulos cm ON cm.moduCurso_curso = i.insc_curso
GROUP BY
    t.tiempo_id,
    s_bi.sede_id,
    re.rango_etario_id,
    c_bi.categoria_id,
    tu.turno_id;

DROP TABLE #Temp_TP_Status;
DROP TABLE #Temp_Modulos_Status;
DROP TABLE #Temp_Curso_Modulos;
GO
--linea 473
INSERT INTO GUARDIANES_DEL_DATO.BI_Hechos_Evaluaciones_Finales
    (
    evalF_tiempo,
    evalF_sede,
    evalF_curso,
    evalF_rango_etario_alumno,
    evalF_nota_final,
    evalF_es_ausente,
    evalF_dias_para_finalizar
    )
SELECT
    t_fin.tiempo_id, -- Fecha del examen final (Mesa)
    s_bi.sede_id,
    c_bi.categoria_id,
    re.rango_etario_id,
    CAST(AVG(ef.evalFinal_nota) AS DECIMAL(4,2)) AS evalF_nota_final,
    SUM(CASE WHEN ef.evalFinal_presente = 0 THEN 1 ELSE 0 END) AS evalF_es_ausente,
    CAST(AVG(DATEDIFF(DAY, c.curs_fechaInicio, me.mesaExam_fecha)) AS INT) AS evalF_dias_para_finalizar
FROM GUARDIANES_DEL_DATO.EvaluacionFinal ef
    JOIN GUARDIANES_DEL_DATO.MesaExamen me ON ef.evalFinal_mesaExamen = me.mesaExam_id
    JOIN GUARDIANES_DEL_DATO.Curso c ON me.mesaExam_curso = c.curs_id
    JOIN GUARDIANES_DEL_DATO.Alumno a ON ef.evalFinal_alumno = a.alum_legajo
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Tiempo t_fin ON t_fin.fecha = me.mesaExam_fecha
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Sede s_bi ON s_bi.sede_id_transaccional = c.curs_sede
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso c_bi ON c_bi.categoria_id_transaccional = c.curs_categoria
    LEFT JOIN GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Alumno re
    ON (re.rango_descripcion = '<25' AND DATEDIFF(YEAR, a.alum_fechNacimiento, me.mesaExam_fecha) < 25)
        OR (re.rango_descripcion = '25-35' AND DATEDIFF(YEAR, a.alum_fechNacimiento, me.mesaExam_fecha) >= 25 AND DATEDIFF(YEAR, a.alum_fechNacimiento, me.mesaExam_fecha) < 35)
        OR (re.rango_descripcion = '35-50' AND DATEDIFF(YEAR, a.alum_fechNacimiento, me.mesaExam_fecha) >= 35 AND DATEDIFF(YEAR, a.alum_fechNacimiento, me.mesaExam_fecha) <= 50)
        OR (re.rango_descripcion = '>50' AND DATEDIFF(YEAR, a.alum_fechNacimiento, me.mesaExam_fecha) > 50)
GROUP BY
    t_fin.tiempo_id,
    s_bi.sede_id,
    c_bi.categoria_id,
    re.rango_etario_id;
GO

INSERT INTO GUARDIANES_DEL_DATO.BI_Hechos_Encuestas
    (
    encuesta_tiempo,
    encuesta_sede,
    encuesta_rangoEtarioProf,
    encuesta_bloqueSatisfaccion,
    encuesta_nota_obtenida,
    encuesta_cantRespuestas
    )
SELECT
    t.tiempo_id,
    s_bi.sede_id,
    re_prof.rango_etario_id,
    bs.bloque_id,
    AVG(TRY_CAST(r.resp_valor AS INT)) AS encuesta_nota_obtenida,
    COUNT(*) AS encuesta_cantRespuestas
FROM GUARDIANES_DEL_DATO.Respuesta r
    JOIN GUARDIANES_DEL_DATO.Encuesta e ON r.resp_encuesta = e.encuesta_id
    JOIN GUARDIANES_DEL_DATO.Curso c ON e.encuesta_curso = c.curs_id
    JOIN GUARDIANES_DEL_DATO.Profesor p ON c.curs_profesor = p.prof_id
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Tiempo t ON t.fecha = e.encuesta_fechaRegistro
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Sede s_bi ON s_bi.sede_id_transaccional = c.curs_sede
    LEFT JOIN GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Profesor re_prof
    ON (DATEDIFF(YEAR, p.prof_fechNacimiento, GETDATE()) BETWEEN 
            CASE WHEN re_prof.rango_descripcion = '25-35' THEN 25 
                 WHEN re_prof.rango_descripcion = '35-50' THEN 35 
                 ELSE 51 END
            AND
            CASE WHEN re_prof.rango_descripcion = '25-35' THEN 35 
                 WHEN re_prof.rango_descripcion = '35-50' THEN 50 
                 ELSE 200 END)
    JOIN GUARDIANES_DEL_DATO.BI_Dim_Bloque_Satisfaccion bs
    ON (
            (TRY_CAST(r.resp_valor AS INT) BETWEEN 7 AND 10 AND bs.bloque_descripcion LIKE 'Satisfechos%') OR
        (TRY_CAST(r.resp_valor AS INT) BETWEEN 5 AND 6 AND bs.bloque_descripcion LIKE 'Neutrales%') OR
        (TRY_CAST(r.resp_valor AS INT) BETWEEN 1 AND 4 AND bs.bloque_descripcion LIKE 'Insatisfechos%')
        )
GROUP BY
        t.tiempo_id,
        s_bi.sede_id,
        re_prof.rango_etario_id,
        bs.bloque_id;
GO



-- CREACION DE VISTAS
-- =============================================================

-- PARA VER LA VISTA = 236 rows
-- SELECT * 
-- FROM GUARDIANES_DEL_DATO.BI_Vista_Top3_Categorias_Turnos
-- ORDER BY anio DESC, sede_nombre, total_inscriptos_categoria DESC;

-- ==============================================================

CREATE VIEW GUARDIANES_DEL_DATO.BI_Vista_Top3_Categorias_Turnos
AS
    SELECT
        t.anio,
        s.sede_nombre,
        Top3.categoria_descripcion,
        tu.turno_descripcion,
        SUM(h.insc_cant_inscriptos) AS total_inscriptos_turno,
        Top3.total_inscriptos_categoria,
        Top3.ranking
    FROM
        GUARDIANES_DEL_DATO.BI_Dim_Tiempo t
CROSS JOIN
    GUARDIANES_DEL_DATO.BI_Dim_Sede s
CROSS APPLY (
    -- Lógica del Ranking: Obtenemos las 3 mejores categorías para este Año-Sede
    SELECT TOP 3
            c.categoria_id,
            c.categoria_descripcion,
            SUM(h_cat.insc_cant_inscriptos) AS total_inscriptos_categoria,
            ROW_NUMBER() OVER (ORDER BY SUM(h_cat.insc_cant_inscriptos) DESC) AS ranking
        FROM
            GUARDIANES_DEL_DATO.BI_Hechos_Inscripciones h_cat
            JOIN
            GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso c ON h_cat.insc_categoria_curso = c.categoria_id
        WHERE
        h_cat.insc_tiempo_inscripcion = t.tiempo_id
            AND h_cat.insc_sede = s.sede_id
        GROUP BY
        c.categoria_id, c.categoria_descripcion
        ORDER BY
        total_inscriptos_categoria DESC
) AS Top3
        INNER JOIN
        GUARDIANES_DEL_DATO.BI_Hechos_Inscripciones h ON
        h.insc_tiempo_inscripcion = t.tiempo_id
            AND h.insc_sede = s.sede_id
            AND h.insc_categoria_curso = Top3.categoria_id
        INNER JOIN
        GUARDIANES_DEL_DATO.BI_Turno tu ON h.insc_turno_curso = tu.turno_id
    GROUP BY
    t.anio,
    s.sede_nombre,
    Top3.categoria_descripcion,
    Top3.total_inscriptos_categoria,
    Top3.ranking,
    tu.turno_descripcion;
GO

-- ==============================================================
-- VISTA 2 - 7 años (2019 a 2025) * 5 meses (1 a 5) * 4 sedes

-- PARA VER LA VISTA
-- SELECT anio, mes, sede_nombre, porcentaje_rechazo
-- FROM GUARDIANES_DEL_DATO.BI_Vista_Tasa_Rechazo_Inscripciones
-- ORDER BY anio DESC, mes DESC, sede_nombre;
-- ==============================================================

CREATE VIEW GUARDIANES_DEL_DATO.BI_Vista_Tasa_Rechazo_Inscripciones
AS
    SELECT
        t.anio,
        t.mes,
        s.sede_nombre,
        CAST(SUM(h.insc_cant_rechazados) * 100.0 / SUM(h.insc_cant_inscriptos) AS DECIMAL(10,2)) AS porcentaje_rechazo
    FROM
        GUARDIANES_DEL_DATO.BI_Hechos_Inscripciones h
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Tiempo t ON h.insc_tiempo_inscripcion = t.tiempo_id
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Sede s ON h.insc_sede = s.sede_id
    GROUP BY
    t.anio,
    t.mes,
    s.sede_nombre;
GO


-- ==============================================================
-- VISTA 3 - 7 años * 4 sedes = 28 rows

-- PARA VER LA VISTA
-- SELECT anio, sede_nombre, porcentaje_aprobacion
-- FROM GUARDIANES_DEL_DATO.BI_Vista_Desempenio_Cursada
-- ORDER BY anio DESC, sede_nombre;
-- ==============================================================
CREATE VIEW GUARDIANES_DEL_DATO.BI_Vista_Desempenio_Cursada
AS
    SELECT
        t.anio,
        s.sede_nombre,
        CAST(SUM(h.resCur_cursada_aprobada) * 100.0 / SUM(h.resCur_total_alumnos) AS DECIMAL(10,2)) AS porcentaje_aprobacion
    FROM
        GUARDIANES_DEL_DATO.BI_Hechos_Resultados_Cursada h
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Tiempo t ON h.resCur_tiempo = t.tiempo_id
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Sede s ON h.resCur_sede = s.sede_id
    GROUP BY
    t.anio,
    s.sede_nombre;
GO


-- ==============================================================
-- VISTA 4 - 5 cursos * 7 años = 35 rows

-- PARA VER LA VISTA
-- SELECT anio, categoria_descripcion, tiempo_promedio_dias
-- FROM GUARDIANES_DEL_DATO.BI_Vista_Tiempo_Finalizacion
-- ORDER BY anio DESC, categoria_descripcion;
-- ==============================================================
CREATE VIEW GUARDIANES_DEL_DATO.BI_Vista_Tiempo_Finalizacion
AS
    SELECT
        t.anio AS anio,
        c.categoria_descripcion,
        AVG(h.evalF_dias_para_finalizar) AS tiempo_promedio_dias
    FROM
        GUARDIANES_DEL_DATO.BI_Hechos_Evaluaciones_Finales h
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Tiempo t ON h.evalF_tiempo = t.tiempo_id
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso c ON h.evalF_curso = c.categoria_id
    WHERE
    h.evalF_es_ausente = 0
    -- Solo considerar alumnos que se presentaron al final
    GROUP BY
    t.anio,
    c.categoria_descripcion;
GO


-- ==============================================================
-- VISTA 5 - Nota promedio de finales

-- PARA VER LA VISTA
-- SELECT 
--     anio,
--     semestre,
--     rango_etario,
--     categoria_descripcion,
--     nota_promedio
-- FROM GUARDIANES_DEL_DATO.BI_Vista_Nota_Promedio_Finales
-- ORDER BY anio DESC, semestre DESC, rango_etario, categoria_descripcion;
-- ==============================================================
CREATE VIEW GUARDIANES_DEL_DATO.BI_Vista_Nota_Promedio_Finales
AS
    SELECT
        t.anio,
        t.semestre,
        re.rango_descripcion AS rango_etario,
        c.categoria_descripcion,
        AVG(h.evalF_nota_final) AS nota_promedio
    FROM
        GUARDIANES_DEL_DATO.BI_Hechos_Evaluaciones_Finales h
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Tiempo t ON h.evalF_tiempo = t.tiempo_id
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Alumno re ON h.evalF_rango_etario_alumno = re.rango_etario_id
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso c ON h.evalF_curso = c.categoria_id
    WHERE
    h.evalF_es_ausente = 0
    -- Solo considerar alumnos que se presentaron
    GROUP BY
    t.anio,
    t.semestre,
    re.rango_descripcion,
    c.categoria_descripcion;
GO


-- ==============================================================
-- VISTA 6 - Tasa de ausentismo finales

-- PARA VER LA VISTA
-- SELECT anio, semestre, sede_nombre, porcentaje_ausentes
-- FROM GUARDIANES_DEL_DATO.BI_Vista_Ausentismo_Finales
-- ORDER BY anio DESC, semestre DESC, sede_nombre;
-- ==============================================================
CREATE VIEW GUARDIANES_DEL_DATO.BI_Vista_Ausentismo_Finales
AS
    SELECT
        t.anio,
        t.semestre,
        s.sede_nombre,
        CAST(SUM(h.evalF_es_ausente) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS porcentaje_ausentes
    FROM
        GUARDIANES_DEL_DATO.BI_Hechos_Evaluaciones_Finales h
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Tiempo t ON h.evalF_tiempo = t.tiempo_id
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Sede s ON h.evalF_sede = s.sede_id
    GROUP BY
    t.anio,
    t.semestre,
    s.sede_nombre;
GO


-- ==============================================================
-- VISTA 7 - Desvío de pagos

-- PARA VER LA VISTA
-- SELECT anio, semestre, porcentaje_fuera_termino
-- FROM GUARDIANES_DEL_DATO.BI_Vista_Desvio_Pagos
-- ORDER BY anio DESC, semestre DESC;
-- ==============================================================
CREATE VIEW GUARDIANES_DEL_DATO.BI_Vista_Desvio_Pagos
AS
    SELECT
        t.anio,
        t.semestre,
        CAST(SUM(h.finan_fuera_termino) * 100.0 / COUNT(*) AS DECIMAL(10,2)) AS porcentaje_fuera_termino
    FROM
        GUARDIANES_DEL_DATO.BI_Hechos_Financiero h
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Tiempo t ON h.finan_tiempo = t.tiempo_id
    GROUP BY
    t.anio,
    t.semestre;
GO

-- ==============================================================
-- VISTA 8 

-- PARA VER LA VISTA
-- SELECT anio, mes, tasa_morosidad
-- FROM GUARDIANES_DEL_DATO.BI_Vista_Morosidad_Mensual
-- ORDER BY anio DESC, mes DESC;
-- ==============================================================
CREATE VIEW GUARDIANES_DEL_DATO.BI_Vista_Morosidad_Mensual
AS
    SELECT
        t.anio,
        t.mes,
        CAST(
        SUM(h.finan_importe_adeudado) * 100.0 / NULLIF(SUM(h.finan_importe_facturado), 0)
    AS DECIMAL(10,2)) AS tasa_morosidad
    FROM
        GUARDIANES_DEL_DATO.BI_Hechos_Financiero h
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Tiempo t ON h.finan_tiempo = t.tiempo_id
    GROUP BY
    t.anio,
    t.mes;
GO

-- ==============================================================
-- VISTA 9 - 7 años * 4 sedes * 3 categorias = 84 rows

-- PARA VER LA VISTA
-- SELECT anio, sede_nombre, ranking, categoria_descripcion, total_ingresos
-- FROM GUARDIANES_DEL_DATO.BI_Vista_Top3_Ingresos_Categorias
-- ORDER BY anio DESC, sede_nombre, ranking;
-- ==============================================================

CREATE VIEW GUARDIANES_DEL_DATO.BI_Vista_Top3_Ingresos_Categorias
AS
    SELECT
        t.anio,
        s.sede_nombre,
        Top3.categoria_descripcion,
        Top3.total_ingresos,
        Top3.ranking
    FROM
        GUARDIANES_DEL_DATO.BI_Dim_Tiempo t
CROSS JOIN
    GUARDIANES_DEL_DATO.BI_Dim_Sede s
CROSS APPLY (
    SELECT TOP 3
            c.categoria_descripcion,
            SUM(h.finan_importe_pagado) AS total_ingresos,
            ROW_NUMBER() OVER (ORDER BY SUM(h.finan_importe_pagado) DESC) AS ranking
        FROM
            GUARDIANES_DEL_DATO.BI_Hechos_Financiero h
            JOIN
            GUARDIANES_DEL_DATO.BI_Dim_Categoria_Curso c ON h.finan_categoria_curso = c.categoria_id
        WHERE
        h.finan_tiempo = t.tiempo_id
            AND h.finan_sede = s.sede_id
        GROUP BY
        c.categoria_descripcion
        ORDER BY
        total_ingresos DESC
) AS Top3;
GO

-- ==============================================================
-- VISTA 10 

-- PARA VER LA VISTA
-- SELECT anio, sede_nombre, rango_etario_profesor, indice_satisfaccion
-- FROM GUARDIANES_DEL_DATO.BI_Vista_Indice_Satisfaccion
-- ORDER BY anio DESC, sede_nombre, rango_etario_profesor;
-- ==============================================================
CREATE VIEW GUARDIANES_DEL_DATO.BI_Vista_Indice_Satisfaccion
AS
    SELECT
        t.anio,
        s.sede_nombre,
        re.rango_descripcion AS rango_etario_profesor,
        CAST(
        (
            (
                SUM(CASE WHEN bs.bloque_descripcion LIKE 'Satisfechos%' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
                -
                SUM(CASE WHEN bs.bloque_descripcion LIKE 'Insatisfechos%' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
            ) + 100
        ) / 2
    AS DECIMAL(10,2)) AS indice_satisfaccion
    FROM
        GUARDIANES_DEL_DATO.BI_Hechos_Encuestas h
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Tiempo t ON h.encuesta_tiempo = t.tiempo_id
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Sede s ON h.encuesta_sede = s.sede_id
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Rango_Etario_Profesor re ON h.encuesta_rangoEtarioProf = re.rango_etario_id
        JOIN
        GUARDIANES_DEL_DATO.BI_Dim_Bloque_Satisfaccion bs ON h.encuesta_bloqueSatisfaccion = bs.bloque_id
    GROUP BY
    t.anio,
    s.sede_nombre,
    re.rango_descripcion;
GO