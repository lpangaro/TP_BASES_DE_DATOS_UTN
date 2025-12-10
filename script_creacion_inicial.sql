--CREACION DEL ESQUEMA
CREATE SCHEMA GUARDIANES_DEL_DATO
go

-- CREACION DE TABLAS --
CREATE PROCEDURE crear_tablas
as
begin
    --Crear tabla Provincia
    CREATE TABLE GUARDIANES_DEL_DATO.Provincia
    (
        prov_id int IDENTITY,
        prov_nombre nvarchar(255),

        CONSTRAINT PK_Provincia PRIMARY KEY (prov_id)
    )

    --Crear tabla Localidad
    CREATE TABLE GUARDIANES_DEL_DATO.Localidad
    (
        localidad_id int IDENTITY,
        localidad_nombre nvarchar(255),
        localidad_provincia int,

        CONSTRAINT PK_Localidad PRIMARY KEY (localidad_id)
    )

    --Crear Referencia de Localidad a Provincia
    ALTER TABLE GUARDIANES_DEL_DATO.Localidad
    add CONSTRAINT FK_LocalidadProvincia
    foreign key (localidad_provincia) REFERENCES GUARDIANES_DEL_DATO.Provincia (prov_id)

    --Crear tabla Estado
    CREATE TABLE GUARDIANES_DEL_DATO.Estado
    (
        estado_id int IDENTITY,
        estado_descripcion nvarchar(255),

        CONSTRAINT PK_Estado PRIMARY KEY (estado_id)
    )

    --Crear tabla Institucion
    CREATE TABLE GUARDIANES_DEL_DATO.Institucion
    (
        inst_id int IDENTITY,
        inst_nombre nvarchar(255),
        inst_razonSocial nvarchar(255),
        inst_cuit nvarchar(255),

        CONSTRAINT PK_Institucion PRIMARY KEY (inst_id)
    )

    --Crear tabla Sede
    CREATE TABLE GUARDIANES_DEL_DATO.Sede
    (
        sede_id int IDENTITY,
        sede_nombre nvarchar(255),
        sede_direccion nvarchar(255),
        sede_email nvarchar(255),
        sede_telefono nvarchar(255),
        sede_localidad int,
        sede_institucion int,

        CONSTRAINT PK_Sede PRIMARY KEY (sede_id)
    )

    --Crear referencia de Sede a Localidad
    ALTER TABLE GUARDIANES_DEL_DATO.Sede
    add CONSTRAINT FK_SedeLocalidad
    foreign key (sede_localidad) REFERENCES GUARDIANES_DEL_DATO.Localidad (localidad_id)

    --Crear referencia de Sede a Institucion
    ALTER TABLE GUARDIANES_DEL_DATO.Sede
    add CONSTRAINT FK_SedeInstitucion
    foreign key (sede_institucion) REFERENCES GUARDIANES_DEL_DATO.Institucion (inst_id)

    --Crear tabla Profesor
    CREATE TABLE GUARDIANES_DEL_DATO.Profesor
    (
        prof_id int IDENTITY,
        prof_nombre nvarchar(255),
        prof_apellido nvarchar(255),
        prof_direccion nvarchar(255),
        prof_fechNacimiento date,
        prof_email nvarchar(255),
        prof_telefono nvarchar(255),
        prof_dni nvarchar(255),
        prof_localidad int,

        CONSTRAINT PK_Profesor PRIMARY KEY (prof_id)
    )

    --Crear referencia de Profesor a Localidad
    ALTER TABLE GUARDIANES_DEL_DATO.Profesor
    add CONSTRAINT FK_ProfesorLocalidad
    foreign key (prof_localidad) REFERENCES GUARDIANES_DEL_DATO.Localidad (localidad_id)

    --Crear tabla Alumno
    CREATE TABLE GUARDIANES_DEL_DATO.Alumno
    (
        alum_legajo bigint,
        alum_nombre nvarchar(255),
        alum_apellido nvarchar(255),
        alum_direccion nvarchar(255),
        alum_fechNacimiento date,
        alum_email nvarchar(255),
        alum_telefono nvarchar(255),
        alum_dni nvarchar(255),
        alum_localidad int,

        CONSTRAINT PK_Alumno PRIMARY KEY (alum_legajo)
    )

    --Crear referencia de Alumno a Localidad
    ALTER TABLE GUARDIANES_DEL_DATO.Alumno
    add CONSTRAINT FK_AlumnoLocalidad
    foreign key (alum_localidad) REFERENCES GUARDIANES_DEL_DATO.Localidad (localidad_id)

    --Crear tabla CategoriaCurso
    CREATE TABLE GUARDIANES_DEL_DATO.CategoriaCurso
    (
        cateCurso_id int IDENTITY,
        cateCurso_descripcion nvarchar(255),

        CONSTRAINT PK_CategoriaCurso PRIMARY KEY (cateCurso_id)
    )

    --Crear tabla Curso
    CREATE TABLE GUARDIANES_DEL_DATO.Curso
    (
        curs_id int IDENTITY,
        curs_codigo nvarchar(255),
        curs_nombre nvarchar(255),
        curs_descripcion nvarchar(255),
        curs_fechaInicio date,
        curs_fechaFin date,
        curs_categoria int,
        curs_duracionMeses int,
        curs_sede int,
        curs_precioMensual decimal(12,2),
        curs_profesor int,

        CONSTRAINT PK_Curso PRIMARY KEY (curs_id)
    )

    --Crear referencia de Curso a CategoriaCurso
    ALTER TABLE GUARDIANES_DEL_DATO.Curso
    add CONSTRAINT FK_CursoCategoriaCurso
    foreign key (curs_categoria) REFERENCES GUARDIANES_DEL_DATO.CategoriaCurso (cateCurso_id)

    --Crear referencia de Curso a Sede
    ALTER TABLE GUARDIANES_DEL_DATO.Curso
    add CONSTRAINT FK_CursoSede
    foreign key (curs_sede) REFERENCES GUARDIANES_DEL_DATO.Sede (sede_id)

    --Crear referencia de Curso a Profesor
    ALTER TABLE GUARDIANES_DEL_DATO.Curso
    add CONSTRAINT FK_CursoProfesor
    foreign key (curs_profesor) REFERENCES GUARDIANES_DEL_DATO.Profesor (prof_id)

    --Crear tabla Dia
    CREATE TABLE GUARDIANES_DEL_DATO.Dia
    (
        dia_id int IDENTITY,
        dia_descripcion nvarchar(255),

        CONSTRAINT PK_Dia PRIMARY KEY (dia_id)
    )

    --Crear tabla Turno
    CREATE TABLE GUARDIANES_DEL_DATO.Turno
    (
        turno_id int IDENTITY,
        turno_descripcion nvarchar(255),

        CONSTRAINT PK_Turno PRIMARY KEY (turno_id)
    )

    --Crear tabla Horario
    CREATE TABLE GUARDIANES_DEL_DATO.Horario
    (
        horario_curso int,
        horario_dia int,
        horario_turno int,

        CONSTRAINT PK_Horario PRIMARY KEY (horario_curso, horario_dia, horario_turno)
    )

    --Crear referencia de Horario a Curso
    ALTER TABLE GUARDIANES_DEL_DATO.Horario
    add CONSTRAINT FK_HorarioCurso
    foreign key (horario_curso) REFERENCES GUARDIANES_DEL_DATO.Curso (curs_id)

    --Crear referencia de Horario a Dia 
    ALTER TABLE GUARDIANES_DEL_DATO.Horario
    add CONSTRAINT FK_HorarioDia
    foreign key (horario_dia) REFERENCES GUARDIANES_DEL_DATO.Dia (dia_id)

    --Crear referencia de Horario a Turno
    ALTER TABLE GUARDIANES_DEL_DATO.Horario
    add CONSTRAINT FK_HorarioTurno
    foreign key (horario_turno) REFERENCES GUARDIANES_DEL_DATO.Turno (turno_id)

    --Crear tabla Inscripcion
    CREATE TABLE GUARDIANES_DEL_DATO.Inscripcion
    (
        insc_id int IDENTITY,
        insc_numero int,
        insc_fecha date,
        insc_fechaResp date,
        insc_alumno bigint,
        insc_estado int,
        insc_curso int,

        CONSTRAINT PK_Inscripcion PRIMARY KEY (insc_numero)
    )

    --Crear referencia de Inscripcion a Estado
    ALTER TABLE GUARDIANES_DEL_DATO.Inscripcion
    add CONSTRAINT FK_InscripcionEstado
    foreign key (insc_estado) REFERENCES GUARDIANES_DEL_DATO.Estado (estado_id)

    --Crear referencia de Inscripcion a Alumno
    ALTER TABLE GUARDIANES_DEL_DATO.Inscripcion
    add CONSTRAINT FK_InscripcionAlumno
    foreign key (insc_alumno) REFERENCES GUARDIANES_DEL_DATO.Alumno (alum_legajo)

    --Crear referencia de Inscripcion a Curso
    ALTER TABLE GUARDIANES_DEL_DATO.Inscripcion
    add CONSTRAINT FK_InscripcionCurso
    foreign key (insc_curso) REFERENCES GUARDIANES_DEL_DATO.Curso (curs_id)

    --Crear tabla Factura
    CREATE TABLE GUARDIANES_DEL_DATO.Factura
    (
        fact_numero int,
        fact_fechaVencimiento date,
        fact_importeTotal decimal(12,2),
        fact_alumno bigint,
        fact_fechaEmision date,

        CONSTRAINT PK_Factura PRIMARY KEY (fact_numero)
    )

    --Crear referencia de Factura a Alumno
    ALTER TABLE GUARDIANES_DEL_DATO.Factura
    add CONSTRAINT FK_FacturaAlumno
    foreign key (fact_alumno) REFERENCES GUARDIANES_DEL_DATO.Alumno (alum_legajo)

    --Crear tabla MedioDePago
    CREATE TABLE GUARDIANES_DEL_DATO.MedioDePago
    (
        medioPago_id int IDENTITY,
        medioPago_nombre nvarchar(255),

        CONSTRAINT PK_MedioDePago PRIMARY KEY (medioPago_id)
    )

    --Crear tabla Pago
    CREATE TABLE GUARDIANES_DEL_DATO.Pago
    (
        pago_id int IDENTITY,
        pago_fecha date,
        pago_importe decimal(12,2),
        pago_medioDePago int,
        pago_factura int,

        CONSTRAINT PK_Pago PRIMARY KEY (pago_id)
    )

    --Crear referencia de Pago a MedioDePago
    ALTER TABLE GUARDIANES_DEL_DATO.Pago
    add CONSTRAINT FK_PagoMedioDePago
    foreign key (pago_medioDePago) REFERENCES GUARDIANES_DEL_DATO.MedioDePago (medioPago_id)

    --Crear referencia de Pago a Factura
    ALTER TABLE GUARDIANES_DEL_DATO.Pago
    add CONSTRAINT FK_PagoFactura
    foreign key (pago_factura) REFERENCES GUARDIANES_DEL_DATO.Factura (fact_numero)

    --Crear tabla Mes
    CREATE TABLE GUARDIANES_DEL_DATO.Mes
    (
        mes_id int,
        mes_descripcion nvarchar(255),

        CONSTRAINT PK_Mes PRIMARY KEY (mes_id)
    )

    --Crear tabla DetalleFactura	
    CREATE TABLE GUARDIANES_DEL_DATO.DetalleFactura
    (
        detaFact_id int IDENTITY,
        detaFact_curso int,
        detaFact_factura int,
        detaFact_periodoAnio int,
        detaFact_periodoMes int,
        detaFact_importe decimal(12,2),

        CONSTRAINT PK_DetalleFactura PRIMARY KEY (detaFact_id)
    )

    --Crear referencia de DetalleFactura a Curso
    ALTER TABLE GUARDIANES_DEL_DATO.DetalleFactura
    add CONSTRAINT FK_DetalleFacturaCurso
    foreign key (detaFact_curso) REFERENCES GUARDIANES_DEL_DATO.Curso (curs_id)

    --Crear referencia de DetalleFactura a Factura
    ALTER TABLE GUARDIANES_DEL_DATO.DetalleFactura
    add CONSTRAINT FK_DetalleFacturaFactura
    foreign key (detaFact_factura) REFERENCES GUARDIANES_DEL_DATO.Factura (fact_numero)

    --Crear referencia de DetalleFactura a Mes
    ALTER TABLE GUARDIANES_DEL_DATO.DetalleFactura
    add CONSTRAINT FK_DetalleFacturaPeriodoMes
    foreign key (detaFact_periodoMes) REFERENCES GUARDIANES_DEL_DATO.Mes (mes_id)

    --Crear tabla Encuesta
    CREATE TABLE GUARDIANES_DEL_DATO.Encuesta
    (
        encuesta_id int IDENTITY,
        encuesta_fechaRegistro date,
        encuesta_observacion varchar(255),
        encuesta_curso int,

        CONSTRAINT PK_Encuesta PRIMARY KEY (encuesta_id)
    )

    --Crear referencia de Encuesta a Curso
    ALTER TABLE GUARDIANES_DEL_DATO.Encuesta
    add CONSTRAINT FK_EncuestaCurso
    foreign key (encuesta_curso) REFERENCES GUARDIANES_DEL_DATO.Curso (curs_id)

    --Crear tabla Pregunta
    CREATE TABLE GUARDIANES_DEL_DATO.Pregunta
    (
        preg_id int IDENTITY,
        preg_descripcion nvarchar(255),

        CONSTRAINT PK_Pregunta PRIMARY KEY (preg_id)
    )

    --Crear tabla Respuesta
    CREATE TABLE GUARDIANES_DEL_DATO.Respuesta
    (
        resp_id int IDENTITY,
        resp_pregunta int,
        resp_encuesta int,
        resp_valor nvarchar(255),

        CONSTRAINT PK_Respuesta PRIMARY KEY (resp_id)
    )

    --Crear referencia de Respuesta a Pregunta
    ALTER TABLE GUARDIANES_DEL_DATO.Respuesta
    add CONSTRAINT FK_RespuestaPregunta
    foreign key (resp_pregunta) REFERENCES GUARDIANES_DEL_DATO.Pregunta (preg_id)

    --Crear referencia de Respuesta a Encuesta
    ALTER TABLE GUARDIANES_DEL_DATO.Respuesta
    add CONSTRAINT FK_RespuestaEncuesta
    foreign key (resp_encuesta) REFERENCES GUARDIANES_DEL_DATO.Encuesta (encuesta_id)

    --Crear tabla TrabajoPractico
    CREATE TABLE GUARDIANES_DEL_DATO.TrabajoPractico
    (
        tp_id int IDENTITY,
        tp_nota int,
        tp_fechaEvaluacion date,
        tp_alumno bigint,
        tp_curso int,

        CONSTRAINT PK_TrabajoPractico PRIMARY KEY (tp_id)
    )

    --Crear referencia de TrabajoPractico a Alumno
    ALTER TABLE GUARDIANES_DEL_DATO.TrabajoPractico
    add CONSTRAINT FK_TPAlumno
    foreign key (tp_alumno) REFERENCES GUARDIANES_DEL_DATO.Alumno (alum_legajo)

    --Crear referencia de TrabajoPractico a Curso
    ALTER TABLE GUARDIANES_DEL_DATO.TrabajoPractico
    add CONSTRAINT FK_TPCurso
    foreign key (tp_curso) REFERENCES GUARDIANES_DEL_DATO.Curso (curs_id)

    --Crear tabla Modulo
    CREATE TABLE GUARDIANES_DEL_DATO.Modulo
    (
        modulo_id int IDENTITY,
        modulo_nombre nvarchar(255),
        modulo_descripcion nvarchar(255),

        CONSTRAINT PK_Modulo PRIMARY KEY (modulo_id)
    )

    --Crear tabla ModuloCurso
    CREATE TABLE GUARDIANES_DEL_DATO.ModuloCurso
    (
        moduCurso_id int IDENTITY(1,1) NOT NULL,
        moduCurso_modulo int NOT NULL,
        moduCurso_curso int NOT NULL,

        CONSTRAINT PK_ModuloCurso PRIMARY KEY (moduCurso_id),
        CONSTRAINT UQ_ModuloCurso_Modulo_Curso UNIQUE (moduCurso_modulo, moduCurso_curso)
    )

    --Crear referencia de ModuloCurso a Modulo
    ALTER TABLE GUARDIANES_DEL_DATO.ModuloCurso
    add CONSTRAINT FK_ModuloCursoModulo
    foreign key (moduCurso_modulo) REFERENCES GUARDIANES_DEL_DATO.Modulo (modulo_id)

    --Crear referencia de ModuloCurso a Curso
    ALTER TABLE GUARDIANES_DEL_DATO.ModuloCurso
    add CONSTRAINT FK_ModuloCursoCurso
    foreign key (moduCurso_curso) REFERENCES GUARDIANES_DEL_DATO.Curso (curs_id)

    --Crear tabla Evaluacion
    CREATE TABLE GUARDIANES_DEL_DATO.Evaluacion
    (
        eval_id int IDENTITY,
        eval_fecha date,
        eval_nota int,
        eval_presente bit,
        eval_instancia int,
        eval_alumno bigint,
        eval_moduloCurso int,

        CONSTRAINT PK_Evaluacion PRIMARY KEY (eval_id)
    )

    --Crear referencia de Evaluacion a Alumno
    ALTER TABLE GUARDIANES_DEL_DATO.Evaluacion
    add CONSTRAINT FK_EvaluacionAlumno
    foreign key (eval_alumno) REFERENCES GUARDIANES_DEL_DATO.Alumno (alum_legajo)

    --Crear referencia de Evaluacion a ModuloCurso
    ALTER TABLE GUARDIANES_DEL_DATO.Evaluacion
    add CONSTRAINT FK_EvaluacionModuloCurso
    foreign key (eval_moduloCurso) REFERENCES GUARDIANES_DEL_DATO.ModuloCurso (moduCurso_id)

    --Crear tabla MesaExamen
    CREATE TABLE GUARDIANES_DEL_DATO.MesaExamen
    (
        mesaExam_id int IDENTITY,
        mesaExam_fecha datetime2,
        mesaExam_hora time,
        mesaExam_descripcion nvarchar(255),
        mesaExam_curso int,
        mesaExam_profesor int,
        CONSTRAINT PK_MesaExamen PRIMARY KEY (mesaExam_id)
    )

    --Crear referencia de MesaExamen a Curso
    ALTER TABLE GUARDIANES_DEL_DATO.MesaExamen
    ADD CONSTRAINT FK_MesaExamenCurso
    FOREIGN KEY (mesaExam_curso) REFERENCES GUARDIANES_DEL_DATO.Curso(curs_id)

    --Crear referencia de MesaExamen a Profesor
    ALTER TABLE GUARDIANES_DEL_DATO.MesaExamen
    ADD CONSTRAINT FK_MesaExamenProfesor
    FOREIGN KEY (mesaExam_profesor) REFERENCES GUARDIANES_DEL_DATO.Profesor(prof_id)

    --Crear tabla InscripcionFinal
    CREATE TABLE GUARDIANES_DEL_DATO.InscripcionFinal
    (
        inscFinal_id int IDENTITY,
        inscFinal_nro int,
        inscFinal_fecha datetime2,
        inscFinal_alumno bigint,
        inscFinal_mesa int,

        CONSTRAINT PK_InscripcionFinal PRIMARY KEY (inscFinal_id),
        CONSTRAINT UQ_InscripcionFinal_Nro UNIQUE (inscFinal_nro)
    )

    --Crear referencia de InscripcionFinal a Alumno
    ALTER TABLE GUARDIANES_DEL_DATO.InscripcionFinal
    ADD CONSTRAINT FK_InscripcionFinalAlumno
    FOREIGN KEY (inscFinal_alumno) REFERENCES GUARDIANES_DEL_DATO.Alumno(alum_legajo)

    --Crear referencia de InscripcionFinal a MesaExamen
    ALTER TABLE GUARDIANES_DEL_DATO.InscripcionFinal	
    ADD CONSTRAINT FK_InscripcionFinalMesa
    FOREIGN KEY (inscFinal_mesa) REFERENCES GUARDIANES_DEL_DATO.MesaExamen(mesaExam_id)

    --Crear tabla EvaluacionFinal
    CREATE TABLE GUARDIANES_DEL_DATO.EvaluacionFinal
    (
        evalFinal_id int IDENTITY,
        evalFinal_mesaExamen int NULL,
        evalFinal_nota int,
        evalFinal_presente bit,
        evalFinal_alumno bigint,
        evalFinal_curso int,
        CONSTRAINT PK_EvaluacionFinal PRIMARY KEY (evalFinal_id)
    )

    --Crear referencia de EvaluacionFinal a MesaExamen
    ALTER TABLE GUARDIANES_DEL_DATO.EvaluacionFinal	
    ADD CONSTRAINT FK_EvaluacionFinalMesaExamen
    FOREIGN KEY (evalFinal_mesaExamen) REFERENCES GUARDIANES_DEL_DATO.MesaExamen(mesaExam_id)

    --Crear referencia de EvaluacionFinal a Alumno
    ALTER TABLE GUARDIANES_DEL_DATO.EvaluacionFinal
    ADD CONSTRAINT FK_EvaluacionFinalAlumno
    FOREIGN KEY (evalFinal_alumno) REFERENCES GUARDIANES_DEL_DATO.Alumno(alum_legajo)

    --Crear referencia de EvaluacionFinal a Curso
    ALTER TABLE GUARDIANES_DEL_DATO.EvaluacionFinal
    ADD CONSTRAINT FK_EvaluacionFinalCurso
    FOREIGN KEY (evalFinal_curso) REFERENCES GUARDIANES_DEL_DATO.Curso(curs_id)

end
go

EXEC crear_tablas
go

-- MIGRACION --
CREATE PROCEDURE migrar_datos
as
begin
    --Provincia
    INSERT INTO GUARDIANES_DEL_DATO.Provincia
        (prov_nombre)
    SELECT DISTINCT prov_nombre
    from(
                            SELECT DISTINCT Sede_Provincia as prov_nombre
            FROM [GD2C2025].[gd_esquema].[Maestra]
            WHERE Sede_Provincia IS NOT NULL
        UNION
            SELECT DISTINCT Profesor_Provincia as prov_nombre
            FROM [GD2C2025].[gd_esquema].[Maestra]
            WHERE Profesor_Provincia IS NOT NULL
        UNION
            SELECT DISTINCT Alumno_Provincia as prov_nombre
            FROM [GD2C2025].[gd_esquema].[Maestra]
            WHERE Alumno_Provincia IS NOT NULL
    ) as Provincia

    -- Dia (viene de Curso_Dia, no Horario_Dia)
    INSERT INTO GUARDIANES_DEL_DATO.Dia
        (dia_descripcion)
    SELECT DISTINCT Curso_Dia
    FROM [GD2C2025].[gd_esquema].[Maestra]
    WHERE Curso_Dia IS NOT NULL

    -- Turno (viene de Curso_Turno, no Horario_Turno)
    INSERT INTO GUARDIANES_DEL_DATO.Turno
        (turno_descripcion)
    SELECT DISTINCT Curso_Turno
    FROM [GD2C2025].[gd_esquema].[Maestra]
    WHERE Curso_Turno IS NOT NULL

    -- Estado: 2 rows 
    INSERT INTO GUARDIANES_DEL_DATO.Estado
        (estado_descripcion)
    SELECT DISTINCT Inscripcion_Estado
    FROM [GD2C2025].[gd_esquema].[Maestra]
    WHERE Inscripcion_Estado IS NOT NULL

    -- MedioDePago (viene de Pago_MedioPago)
    INSERT INTO GUARDIANES_DEL_DATO.MedioDePago
        (medioPago_nombre)
    SELECT DISTINCT Pago_MedioPago
    FROM [GD2C2025].[gd_esquema].[Maestra]
    WHERE Pago_MedioPago IS NOT NULL

    -- Mes (viene de Periodo_Mes que es BIGINT, no descripción)
    INSERT INTO GUARDIANES_DEL_DATO.Mes
        (mes_id, mes_descripcion)
    SELECT DISTINCT Periodo_Mes,
        CASE Periodo_Mes
        WHEN 1 THEN 'Enero'
        WHEN 2 THEN 'Febrero'
        WHEN 3 THEN 'Marzo'
        WHEN 4 THEN 'Abril'
        WHEN 5 THEN 'Mayo'
        WHEN 6 THEN 'Junio'
        WHEN 7 THEN 'Julio'
        WHEN 8 THEN 'Agosto'
        WHEN 9 THEN 'Septiembre'
        WHEN 10 THEN 'Octubre'
        WHEN 11 THEN 'Noviembre'
        WHEN 12 THEN 'Diciembre'
    END
    FROM [GD2C2025].[gd_esquema].[Maestra]
    WHERE Periodo_Mes IS NOT NULL

    -- Preguntas (viene de Encuesta_Pregunta1 a Encuesta_Pregunta4)
    INSERT INTO GUARDIANES_DEL_DATO.Pregunta
        (preg_descripcion)
    SELECT DISTINCT preg_descripcion
    FROM (
                                SELECT DISTINCT Encuesta_Pregunta1 AS preg_descripcion
            FROM [GD2C2025].[gd_esquema].[Maestra]
            WHERE Encuesta_Pregunta1 IS NOT NULL
        UNION
            SELECT DISTINCT Encuesta_Pregunta2
            FROM [GD2C2025].[gd_esquema].[Maestra]
            WHERE Encuesta_Pregunta2 IS NOT NULL
        UNION
            SELECT DISTINCT Encuesta_Pregunta3
            FROM [GD2C2025].[gd_esquema].[Maestra]
            WHERE Encuesta_Pregunta3 IS NOT NULL
        UNION
            SELECT DISTINCT Encuesta_Pregunta4
            FROM [GD2C2025].[gd_esquema].[Maestra]
            WHERE Encuesta_Pregunta4 IS NOT NULL
) AS Preguntas

    -- CategoriaCurso
    INSERT INTO GUARDIANES_DEL_DATO.CategoriaCurso
        (cateCurso_descripcion)
    SELECT DISTINCT Curso_Categoria
    FROM [GD2C2025].[gd_esquema].[Maestra]
    WHERE Curso_Categoria IS NOT NULL

    -- Modulo
    INSERT INTO GUARDIANES_DEL_DATO.Modulo
        (modulo_nombre, modulo_descripcion)
    SELECT DISTINCT Modulo_Nombre, Modulo_Descripcion
    FROM [GD2C2025].[gd_esquema].[Maestra]
    WHERE Modulo_Nombre IS NOT NULL

    -- Localidad (depende de Provincia)
    INSERT INTO GUARDIANES_DEL_DATO.Localidad
        (localidad_nombre, localidad_provincia)
    SELECT DISTINCT localidad, provincia
    FROM (
                        SELECT DISTINCT Sede_Localidad as localidad,
                (SELECT prov_id
                FROM GUARDIANES_DEL_DATO.Provincia
                WHERE prov_nombre = Sede_Provincia) as provincia
            FROM [GD2C2025].[gd_esquema].[Maestra]
            WHERE Sede_Localidad IS NOT NULL
        UNION
            SELECT DISTINCT Profesor_Localidad,
                (SELECT prov_id
                FROM GUARDIANES_DEL_DATO.Provincia
                WHERE prov_nombre = Profesor_Provincia)
            FROM [GD2C2025].[gd_esquema].[Maestra]
            WHERE Profesor_Localidad IS NOT NULL
        UNION
            SELECT DISTINCT Alumno_Localidad,
                (SELECT prov_id
                FROM GUARDIANES_DEL_DATO.Provincia
                WHERE prov_nombre = Alumno_Provincia)
            FROM [GD2C2025].[gd_esquema].[Maestra]
            WHERE Alumno_Localidad IS NOT NULL
) AS Localidades

    -- Institucion 
    INSERT INTO GUARDIANES_DEL_DATO.Institucion
        (inst_nombre, inst_razonSocial, inst_cuit)
    SELECT DISTINCT
        Institucion_Nombre,
        Institucion_RazonSocial,
        Institucion_Cuit
    FROM [GD2C2025].[gd_esquema].[Maestra]
    WHERE Institucion_Cuit IS NOT NULL

    -- Sede
    INSERT INTO GUARDIANES_DEL_DATO.Sede
        (sede_nombre, sede_direccion, sede_email, sede_telefono, sede_localidad, sede_institucion)
    SELECT DISTINCT
        Sede_Nombre,
        Sede_Direccion,
        Sede_Mail,
        Sede_Telefono,
        (SELECT localidad_id
        FROM GUARDIANES_DEL_DATO.Localidad
        WHERE localidad_nombre = m.Sede_Localidad
            AND localidad_provincia = (SELECT prov_id
            FROM GUARDIANES_DEL_DATO.Provincia
            WHERE prov_nombre = m.Sede_Provincia)),
        (SELECT inst_id
        FROM GUARDIANES_DEL_DATO.Institucion
        WHERE inst_cuit = m.Institucion_Cuit)
    FROM [GD2C2025].[gd_esquema].[Maestra] m
    WHERE Sede_Nombre IS NOT NULL

    -- Profesor (depende de Localidad)
    INSERT INTO GUARDIANES_DEL_DATO.Profesor
        (prof_nombre, prof_apellido, prof_direccion, prof_fechNacimiento, prof_email, prof_telefono, prof_dni, prof_localidad)
    SELECT DISTINCT
        Profesor_nombre,
        Profesor_Apellido,
        Profesor_Direccion,
        Profesor_FechaNacimiento,
        Profesor_Mail,
        Profesor_Telefono,
        Profesor_Dni,
        (SELECT localidad_id
        FROM GUARDIANES_DEL_DATO.Localidad
        WHERE localidad_nombre = m.Profesor_Localidad
            AND localidad_provincia = (SELECT prov_id
            FROM GUARDIANES_DEL_DATO.Provincia
            WHERE prov_nombre = m.Profesor_Provincia))
    FROM [GD2C2025].[gd_esquema].[Maestra] m
    WHERE Profesor_Dni IS NOT NULL

    -- Alumno (depende de Localidad) 
    INSERT INTO GUARDIANES_DEL_DATO.Alumno
        (alum_legajo, alum_nombre, alum_apellido, alum_direccion, alum_fechNacimiento, alum_email, alum_telefono, alum_dni, alum_localidad)
    SELECT DISTINCT
        Alumno_Legajo,
        Alumno_Nombre,
        Alumno_Apellido,
        Alumno_Direccion,
        Alumno_FechaNacimiento,
        Alumno_Mail,
        Alumno_Telefono,
        Alumno_Dni,
        (SELECT localidad_id
        FROM GUARDIANES_DEL_DATO.Localidad
        WHERE localidad_nombre = m.Alumno_Localidad
            AND localidad_provincia = (SELECT prov_id
            FROM GUARDIANES_DEL_DATO.Provincia
            WHERE prov_nombre = m.Alumno_Provincia))
    FROM [GD2C2025].[gd_esquema].[Maestra] m
    WHERE Alumno_Legajo IS NOT NULL

    -- Curso (depende de CategoriaCurso, Sede, Profesor)
    INSERT INTO GUARDIANES_DEL_DATO.Curso
        (curs_codigo, curs_nombre, curs_descripcion, curs_fechaInicio, curs_fechaFin, curs_precioMensual, curs_duracionMeses, curs_categoria, curs_sede, curs_profesor)
    SELECT DISTINCT
        Curso_Codigo,
        Curso_Nombre,
        Curso_Descripcion,
        Curso_FechaInicio,
        Curso_FechaFin,
        Curso_PrecioMensual,
        Curso_DuracionMeses,
        (SELECT cateCurso_id
        FROM GUARDIANES_DEL_DATO.CategoriaCurso
        WHERE cateCurso_descripcion = m.Curso_Categoria),
        (SELECT sede_id
        FROM GUARDIANES_DEL_DATO.Sede
        WHERE sede_nombre = m.Sede_Nombre),
        (SELECT prof_id
        FROM GUARDIANES_DEL_DATO.Profesor
        WHERE prof_dni = m.Profesor_Dni)
    FROM [GD2C2025].[gd_esquema].[Maestra] m
    WHERE Curso_Codigo IS NOT NULL

    -- Horario (depende de Curso, Dia, Turno)
    INSERT INTO GUARDIANES_DEL_DATO.Horario
        (horario_curso, horario_dia, horario_turno)
    SELECT DISTINCT
        c.curs_id,
        d.dia_id,
        t.turno_id
    FROM [GD2C2025].[gd_esquema].[Maestra] m
        INNER JOIN GUARDIANES_DEL_DATO.Curso c
        ON c.curs_codigo = m.Curso_Codigo
        INNER JOIN GUARDIANES_DEL_DATO.Dia d
        ON d.dia_descripcion = m.Curso_Dia
        INNER JOIN GUARDIANES_DEL_DATO.Turno t
        ON t.turno_descripcion = m.Curso_Turno
    WHERE m.Curso_Dia IS NOT NULL
        AND m.Curso_Turno IS NOT NULL

    -- ModuloCurso (depende de Modulo y Curso)
    INSERT INTO GUARDIANES_DEL_DATO.ModuloCurso
        (moduCurso_modulo, moduCurso_curso)
    SELECT DISTINCT m.modulo_id, c.curs_id
    FROM [GD2C2025].[gd_esquema].[Maestra] ma
        INNER JOIN GUARDIANES_DEL_DATO.Modulo m ON m.modulo_nombre = ma.Modulo_Nombre
        INNER JOIN GUARDIANES_DEL_DATO.Curso c ON c.curs_codigo = ma.Curso_Codigo
    WHERE ma.Modulo_Nombre IS NOT NULL AND ma.Curso_Codigo IS NOT NULL

    -- Inscripcion (depende de Alumno, Curso y Estado)
    INSERT INTO GUARDIANES_DEL_DATO.Inscripcion
        (insc_numero, insc_fecha, insc_fechaResp, insc_alumno, insc_estado, insc_curso)
    SELECT DISTINCT
        m.Inscripcion_Numero,
        m.Inscripcion_Fecha,
        m.Inscripcion_FechaRespuesta,
        m.Alumno_Legajo,
        e.estado_id,
        c.curs_id
    FROM [GD2C2025].[gd_esquema].[Maestra] m
        INNER JOIN GUARDIANES_DEL_DATO.Curso c
        ON c.curs_codigo = m.Curso_Codigo
        INNER JOIN GUARDIANES_DEL_DATO.Estado e
        ON e.estado_descripcion = m.Inscripcion_Estado
    WHERE m.Inscripcion_Numero IS NOT NULL

    -- Factura (depende de Alumno)
    INSERT INTO GUARDIANES_DEL_DATO.Factura
        (fact_numero, fact_fechaEmision, fact_fechaVencimiento, fact_importeTotal, fact_alumno)
    SELECT DISTINCT
        Factura_Numero,
        Factura_FechaEmision,
        Factura_FechaVencimiento,
        Factura_Total,
        a.alum_legajo
    FROM [GD2C2025].[gd_esquema].[Maestra] m
        INNER JOIN GUARDIANES_DEL_DATO.Alumno a ON a.alum_legajo = m.Alumno_Legajo
    WHERE Factura_Numero IS NOT NULL

    -- DetalleFactura (depende de Factura, Curso, Mes)
    INSERT INTO GUARDIANES_DEL_DATO.DetalleFactura
        (detaFact_curso, detaFact_factura, detaFact_periodoAnio, detaFact_periodoMes, detaFact_importe)
    SELECT DISTINCT
        c.curs_id,
        f.fact_numero,
        m.Periodo_Anio,
        me.mes_id,
        m.Detalle_Factura_Importe
    FROM [GD2C2025].[gd_esquema].[Maestra] m
        INNER JOIN GUARDIANES_DEL_DATO.Curso c
        ON c.curs_codigo = m.Curso_Codigo
        INNER JOIN GUARDIANES_DEL_DATO.Factura f
        ON f.fact_numero = m.Factura_Numero
        INNER JOIN GUARDIANES_DEL_DATO.Mes me
        ON me.mes_id = m.Periodo_Mes
    WHERE m.Detalle_Factura_Importe IS NOT NULL

    -- Pago (depende de Factura y MedioDePago)
    INSERT INTO GUARDIANES_DEL_DATO.Pago
        (pago_fecha, pago_importe, pago_medioDePago, pago_factura)
    SELECT DISTINCT
        Pago_Fecha,
        Pago_Importe,
        mp.medioPago_id,
        f.fact_numero
    FROM [GD2C2025].[gd_esquema].[Maestra] m
        INNER JOIN GUARDIANES_DEL_DATO.Factura f
        ON f.fact_numero = m.Factura_Numero
        INNER JOIN GUARDIANES_DEL_DATO.MedioDePago mp
        ON mp.medioPago_nombre = m.Pago_MedioPago
    WHERE Pago_Fecha IS NOT NULL
        AND Pago_Importe IS NOT NULL
        AND m.Factura_Numero IS NOT NULL
        AND m.Pago_MedioPago IS NOT NULL

    -- TrabajoPractico (depende de Alumno y Curso)
    INSERT INTO GUARDIANES_DEL_DATO.TrabajoPractico
        (tp_nota, tp_fechaEvaluacion, tp_alumno, tp_curso)
    SELECT DISTINCT
        m.Trabajo_Practico_Nota,
        m.Trabajo_Practico_FechaEvaluacion,
        a.alum_legajo,
        c.curs_id
    FROM [GD2C2025].[gd_esquema].[Maestra] m
        INNER JOIN GUARDIANES_DEL_DATO.Alumno a
        ON a.alum_legajo = m.Alumno_Legajo
        INNER JOIN GUARDIANES_DEL_DATO.Curso c
        ON c.curs_codigo = m.Curso_Codigo
    WHERE m.Trabajo_Practico_FechaEvaluacion IS NOT NULL

    -- Evaluacion (depende de Alumno y ModuloCurso)
    INSERT INTO GUARDIANES_DEL_DATO.Evaluacion
        (eval_fecha, eval_nota, eval_presente, eval_instancia, eval_alumno, eval_moduloCurso)
    SELECT DISTINCT
        m.Evaluacion_Curso_fechaEvaluacion,
        m.Evaluacion_Curso_Nota,
        m.Evaluacion_Curso_Presente,
        m.Evaluacion_Curso_Instancia,
        a.alum_legajo,
        mc.moduCurso_id
    FROM [GD2C2025].[gd_esquema].[Maestra] m
        INNER JOIN GUARDIANES_DEL_DATO.Alumno a
        ON a.alum_legajo = m.Alumno_Legajo
        INNER JOIN GUARDIANES_DEL_DATO.Modulo mo
        ON mo.modulo_nombre = m.Modulo_Nombre
        INNER JOIN GUARDIANES_DEL_DATO.Curso c
        ON c.curs_codigo = m.Curso_Codigo
        INNER JOIN GUARDIANES_DEL_DATO.ModuloCurso mc
        ON mc.moduCurso_modulo = mo.modulo_id
            AND mc.moduCurso_curso = c.curs_id
    WHERE m.Evaluacion_Curso_fechaEvaluacion IS NOT NULL

    --===============================================================================
    -- EXÁMENES FINALES (orden corregido)
    --===============================================================================

    -- MesaExamen: 813 rows
    INSERT INTO GUARDIANES_DEL_DATO.MesaExamen
        (mesaExam_fecha, mesaExam_hora, mesaExam_descripcion, mesaExam_curso, mesaExam_profesor)
    SELECT DISTINCT
        m.Examen_Final_Fecha,
        CAST(m.Examen_Final_Hora AS time),
        m.Examen_Final_Descripcion,
        c.curs_id,
        p.prof_id
    FROM [GD2C2025].[gd_esquema].[Maestra] m
        INNER JOIN GUARDIANES_DEL_DATO.Profesor p
        ON p.prof_dni = m.Profesor_Dni
        INNER JOIN GUARDIANES_DEL_DATO.Curso c
        ON c.curs_codigo = m.Curso_Codigo
    WHERE m.Examen_Final_Fecha IS NOT NULL
        AND m.Examen_Final_Descripcion IS NOT NULL
        AND m.Examen_Final_Hora IS NOT NULL

    -- EvaluacionFinal = 3732 rows
    INSERT INTO GUARDIANES_DEL_DATO.EvaluacionFinal
        (evalFinal_nota, evalFinal_mesaExamen, evalFinal_presente, evalFinal_alumno, evalFinal_curso)
    SELECT DISTINCT
        m.Evaluacion_Final_Nota,
        me.mesaExam_id,
        m.Evaluacion_Final_Presente,
        m.Alumno_Legajo,
        c.curs_id
    FROM [GD2C2025].[gd_esquema].[Maestra] m
        INNER JOIN GUARDIANES_DEL_DATO.Curso c
        ON c.curs_codigo = m.Curso_Codigo
        INNER JOIN GUARDIANES_DEL_DATO.MesaExamen me
        ON me.mesaExam_curso = c.curs_id
            AND me.mesaExam_fecha = m.Examen_Final_Fecha
            AND CAST(me.mesaExam_hora AS varchar(5)) = CAST(m.Examen_Final_Hora AS varchar(5))
    WHERE m.Evaluacion_Final_Presente IS NOT NULL

    -- InscripcionFinal = 3732 rows
    INSERT INTO GUARDIANES_DEL_DATO.InscripcionFinal
        (inscFinal_nro, inscFinal_fecha, inscFinal_alumno, inscFinal_mesa)
    SELECT DISTINCT
        m.Inscripcion_Final_Nro,
        m.Examen_Final_Fecha,
        m.Alumno_Legajo,
        me.mesaExam_id
    FROM GUARDIANES_DEL_DATO.EvaluacionFinal ev
        inner join [GD2C2025].[gd_esquema].[Maestra] m on ev.evalFinal_alumno = m.Alumno_Legajo
        inner join GUARDIANES_DEL_DATO.MesaExamen me on me.mesaExam_id = ev.evalFinal_mesaExamen
    where m.Inscripcion_Final_Nro is not null
        and m.Examen_Final_Fecha is not null

    -- Encuesta (depende de Curso)
    INSERT INTO GUARDIANES_DEL_DATO.Encuesta
        (encuesta_fechaRegistro, encuesta_observacion, encuesta_curso)
    SELECT DISTINCT
        Encuesta_FechaRegistro,
        Encuesta_Observacion,
        c.curs_id
    FROM [GD2C2025].[gd_esquema].[Maestra] m
        INNER JOIN GUARDIANES_DEL_DATO.Curso c ON c.curs_codigo = m.Curso_Codigo
    WHERE Encuesta_FechaRegistro IS NOT NULL

    -- Respuesta (4 preguntas)
    INSERT INTO GUARDIANES_DEL_DATO.Respuesta
        (resp_pregunta, resp_encuesta, resp_valor)
    SELECT DISTINCT
        pr.preg_id,
        e.encuesta_id,
        CAST(r.nota AS nvarchar(255))
    FROM [GD2C2025].[gd_esquema].[Maestra] m
CROSS APPLY (
    VALUES
            (m.Encuesta_Pregunta1, m.Encuesta_Nota1),
            (m.Encuesta_Pregunta2, m.Encuesta_Nota2),
            (m.Encuesta_Pregunta3, m.Encuesta_Nota3),
            (m.Encuesta_Pregunta4, m.Encuesta_Nota4)
) AS r(pregunta, nota)
        INNER JOIN GUARDIANES_DEL_DATO.Pregunta pr
        ON pr.preg_descripcion = r.pregunta
        INNER JOIN GUARDIANES_DEL_DATO.Curso c
        ON c.curs_codigo = m.Curso_Codigo
        INNER JOIN GUARDIANES_DEL_DATO.Encuesta e
        ON e.encuesta_curso = c.curs_id
            AND e.encuesta_fechaRegistro = m.Encuesta_FechaRegistro
    WHERE m.Encuesta_FechaRegistro IS NOT NULL
        AND r.pregunta IS NOT NULL
        AND r.nota IS NOT NULL

end
go

EXEC migrar_datos
go