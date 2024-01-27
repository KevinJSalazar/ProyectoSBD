USE PetBacker;

-- Stored Procedure Refugio Mascotas
DELIMITER //
CREATE PROCEDURE InsertarRefugioMascotas(
    IN p_email CHAR(50),
    IN p_nombre CHAR(100),
    IN p_descripcion CHAR(250),
    IN p_foto LONGBLOB,
    IN p_pagina_web CHAR(50),
    IN p_direccion CHAR(50),
    IN p_estado CHAR(30),
    IN p_ciudad CHAR(30),
    IN p_telefono CHAR(10),
    IN p_telefonoOp CHAR(10)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        INSERT INTO RefugioMascotas (email, nombre, descripcion, foto, pagina_web, direccion, estado, ciudad, telefono, telefonoOp)
        VALUES (p_email, p_nombre, p_descripcion, p_foto, p_pagina_web, p_direccion, p_estado, p_ciudad, p_telefono, p_telefonoOp);
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción de datos en la tabla RefugioMascotas';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarRefugioMascotas(
    IN p_idRef INT,
    IN p_email CHAR(50),
    IN p_nombre CHAR(100),
    IN p_descripcion CHAR(250),
    IN p_foto LONGBLOB,
    IN p_pagina_web CHAR(50),
    IN p_direccion CHAR(50),
    IN p_estado CHAR(30),
    IN p_ciudad CHAR(30),
    IN p_telefono CHAR(10),
    IN p_telefonoOp CHAR(10)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        UPDATE RefugioMascotas
        SET
            email = p_email,
            nombre = p_nombre,
            descripcion = p_descripcion,
            foto = p_foto,
            pagina_web = p_pagina_web,
            direccion = p_direccion,
            estado = p_estado,
            ciudad = p_ciudad,
            telefono = p_telefono,
            telefonoOp = p_telefonoOp
        WHERE idRef = p_idRef;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización de datos en la tabla RefugioMascotas';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarRefugioMascotas(
    IN p_idRef INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        DELETE FROM RefugioMascotas WHERE idRef = p_idRef;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la eliminación de datos en la tabla RefugioMascotas';
    END IF;
END;
//DELIMITER ;

-- Stored Procedure Usuarios
DELIMITER //
CREATE PROCEDURE InsertarUsuario(
    IN p_email CHAR(50),
    IN p_nickname CHAR(250),
    IN p_contraseña CHAR(20),
    IN p_telefono CHAR(10),
    IN p_foto LONGBLOB,
    IN p_red_social CHAR(50),
    IN p_vales INT,
    IN p_tarjeta CHAR(20),
    IN p_tipo CHAR(10)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        INSERT INTO Usuario (email, nickname, contraseña, telefono, foto, red_social, vales, tarjeta, tipo)
        VALUES (p_email, p_nickname, p_contraseña, p_telefono, p_foto, p_red_social, p_vales, p_tarjeta, p_tipo);
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción de datos en la tabla Usuario';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarUsuario(
    IN p_idUsu INT,
    IN p_email CHAR(50),
    IN p_nickname CHAR(250),
    IN p_contraseña CHAR(20),
    IN p_telefono CHAR(10),
    IN p_foto LONGBLOB,
    IN p_red_social CHAR(50),
    IN p_vales INT,
    IN p_tarjeta CHAR(20),
    IN p_tipo CHAR(10)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        UPDATE Usuario
        SET
            email = p_email,
            nickname = p_nickname,
            contraseña = p_contraseña,
            telefono = p_telefono,
            foto = p_foto,
            red_social = p_red_social,
            vales = p_vales,
            tarjeta = p_tarjeta,
            tipo = p_tipo
        WHERE idUsu = p_idUsu;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización de datos en la tabla Usuario';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarUsuario(
    IN p_idUsu INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        DELETE FROM Usuario WHERE idUsu = p_idUsu;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la eliminación de datos en la tabla Usuario';
    END IF;
END;
//DELIMITER ;

-- Stored Procedure Donacion
DELIMITER //
CREATE PROCEDURE InsertarDonacion(
    IN p_idRef INT,
    IN p_idUsu INT,
    IN p_fecha DATE,
    IN p_monto DOUBLE
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        INSERT INTO Donacion (idRef, idUsu, fecha, monto, cupon)
        VALUES (p_idRef, p_idUsu, p_fecha, p_monto, ROUND(p_monto * 2));
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción de datos en la tabla Donacion';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarDonacion(
    IN p_idDon INT,
    IN p_idRef INT,
    IN p_idUsu INT,
    IN p_fecha DATE,
    IN p_monto DOUBLE
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        UPDATE Donacion
        SET
            idRef = p_idRef,
            idUsu = p_idUsu,
            fecha = p_fecha,
            monto = p_monto,
            cupon = ROUND(p_monto * 2)
        WHERE idDon = p_idDon;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización de datos en la tabla Donacion';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarDonacion(
    IN p_idDon INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        DELETE FROM Donacion WHERE idDon = p_idDon;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la eliminación de datos en la tabla Donacion';
    END IF;
END;
//
DELIMITER ;

-- Stored Procedure TipoServicio
DELIMITER //
CREATE PROCEDURE InsertarTipoServicio(
    IN p_lugar_recogida CHAR(250),
    IN p_fecha_inicio DATE,
    IN p_numero_dias INT,
    IN p_fecha_fin DATE,
    IN p_detalles CHAR(250),
    IN p_raza CHAR(100),
    IN p_numero_mascotas INT,
    IN p_tipo CHAR(50),
    IN p_servicio_recogida BOOLEAN,
    IN p_numero_paseos_diario INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        INSERT INTO TipoServicio (lugar_recogida, fecha_inicio, numero_dias, fecha_fin, detalles, raza, numero_mascotas, tipo, servicio_recogida, numero_paseos_diario)
        VALUES (p_lugar_recogida, p_fecha_inicio, p_numero_dias, p_fecha_fin, p_detalles, p_raza, p_numero_mascotas, p_tipo, p_servicio_recogida, p_numero_paseos_diario);
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción de datos en la tabla TipoServicio';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarTipoServicio(
    IN p_idTipoSer INT,
    IN p_lugar_recogida CHAR(250),
    IN p_fecha_inicio DATE,
    IN p_numero_dias INT,
    IN p_fecha_fin DATE,
    IN p_detalles CHAR(250),
    IN p_raza CHAR(100),
    IN p_numero_mascotas INT,
    IN p_tipo CHAR(50),
    IN p_servicio_recogida BOOLEAN,
    IN p_numero_paseos_diario INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        UPDATE TipoServicio
        SET
            lugar_recogida = p_lugar_recogida,
            fecha_inicio = p_fecha_inicio,
            numero_dias = p_numero_dias,
            fecha_fin = p_fecha_fin,
            detalles = p_detalles,
            raza = p_raza,
            numero_mascotas = p_numero_mascotas,
            tipo = p_tipo,
            servicio_recogida = p_servicio_recogida,
            numero_paseos_diario = p_numero_paseos_diario
        WHERE idTipoSer = p_idTipoSer;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización de datos en la tabla TipoServicio';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarTipoServicio(
    IN p_idTipoSer INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        DELETE FROM TipoServicio WHERE idTipoSer = p_idTipoSer;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la eliminación de datos en la tabla TipoServicio';
    END IF;
END;
//DELIMITER ;

-- Stored Procedure Tamaño
DELIMITER //
CREATE PROCEDURE InsertarTamaño(
    IN p_idTipoSer INT,
    IN p_tamaño CHAR(30)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        INSERT INTO Tamaño (idTipoSer, tamaño)
        VALUES (p_idTipoSer, p_tamaño);
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción de datos en la tabla Tamaño';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarTamaño(
    IN p_idTam INT,
    IN p_idTipoSer INT,
    IN p_tamaño CHAR(30)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        UPDATE Tamaño
        SET
            idTipoSer = p_idTipoSer,
            tamaño = p_tamaño
        WHERE idTam = p_idTam;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización de datos en la tabla Tamaño';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarTamaño(
    IN p_idTam INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        DELETE FROM Tamaño WHERE idTam = p_idTam;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la eliminación de datos en la tabla Tamaño';
    END IF;
END;
//DELIMITER ;

-- Stored Procedure TipoMascotas
DELIMITER //
CREATE PROCEDURE InsertarTipoMascotas(
    IN p_idTipoSer INT,
    IN p_mascota CHAR(30)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        INSERT INTO TipoMascotas (idTipoSer, mascota)
        VALUES (p_idTipoSer, p_mascota);
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción de datos en la tabla TipoMascotas';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarTipoMascotas(
    IN p_idTipoMas INT,
    IN p_idTipoSer INT,
    IN p_mascota CHAR(30)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        UPDATE TipoMascotas
        SET
            idTipoSer = p_idTipoSer,
            mascota = p_mascota
        WHERE idTipoMas = p_idTipoMas;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización de datos en la tabla TipoMascotas';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarTipoMascotas(
    IN p_idTipoMas INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        DELETE FROM TipoMascotas WHERE idTipoMas = p_idTipoMas;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la eliminación de datos en la tabla TipoMascotas';
    END IF;
END;
//DELIMITER ;

-- Stored Procedure TipoAseo
DELIMITER //
CREATE PROCEDURE InsertarTipoAseo(
    IN p_idTipoSer INT,
    IN p_aseo CHAR(50)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        INSERT INTO TipoAseo (idTipoSer, aseo)
        VALUES (p_idTipoSer, p_aseo);
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción de datos en la tabla TipoAseo';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarTipoAseo(
    IN p_idTipoAseo INT,
    IN p_idTipoSer INT,
    IN p_aseo CHAR(50)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        UPDATE TipoAseo
        SET
            idTipoSer = p_idTipoSer,
            aseo = p_aseo
        WHERE idTipoAseo = p_idTipoAseo;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización de datos en la tabla TipoAseo';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarTipoAseo(
    IN p_idTipoAseo INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        DELETE FROM TipoAseo WHERE idTipoAseo = p_idTipoAseo;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la eliminación de datos en la tabla TipoAseo';
    END IF;
END;
//DELIMITER ;

-- Stored Procedure Servicio
DELIMITER //
CREATE PROCEDURE InsertarServicio(
    IN p_idCui INT,
    IN p_titulo CHAR(50),
    IN p_descripcion CHAR(250),
    IN p_precio DOUBLE,
    IN p_pais CHAR(30),
    IN p_provincia CHAR(30),
    IN p_ciudad CHAR(30),
    IN p_idTipoSer INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        INSERT INTO Servicio (idCui, titulo, descripcion, precio, pais, provincia, ciudad, idTipoSer)
        VALUES (p_idCui, p_titulo, p_descripcion, p_precio, p_pais, p_provincia, p_ciudad, p_idTipoSer);
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción de datos en la tabla Servicio';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarServicio(
    IN p_idSer INT,
    IN p_idCui INT,
    IN p_titulo CHAR(50),
    IN p_descripcion CHAR(250),
    IN p_precio DOUBLE,
    IN p_pais CHAR(30),
    IN p_provincia CHAR(30),
    IN p_ciudad CHAR(30),
    IN p_idTipoSer INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        UPDATE Servicio
        SET
            idCui = p_idCui,
            titulo = p_titulo,
            descripcion = p_descripcion,
            precio = p_precio,
            pais = p_pais,
            provincia = p_provincia,
            ciudad = p_ciudad,
            idTipoSer = p_idTipoSer
        WHERE idSer = p_idSer;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización de datos en la tabla Servicio';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarServicio(
    IN p_idSer INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
        BEGIN
            SET error_occurred = 1;
            ROLLBACK;
        END;
        DELETE FROM Servicio WHERE idSer = p_idSer;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la eliminación de datos en la tabla Servicio';
    END IF;
END;
//DELIMITER ;

-- Stored Procedure Solicitud
DELIMITER //
CREATE PROCEDURE InsertarSolicitud(
    IN p_idSer INT,
    IN p_idUsu INT,
    IN p_idCui INT,
    IN p_fecha DATE
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SET error_occurred = 1;
                ROLLBACK;
            END;
        INSERT INTO Solicitud (idSer, idUsu, idCui, fecha)
        VALUES (p_idSer, p_idUsu, p_idCui, p_fecha);
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción de datos en la tabla Solicitud';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarSolicitud(
    IN p_idSol INT,
    IN p_idSer INT,
    IN p_idUsu INT,
    IN p_idCui INT,
    IN p_fecha DATE
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SET error_occurred = 1;
                ROLLBACK;
            END;
        UPDATE Solicitud
        SET
            idSer = p_idSer,
            idUsu = p_idUsu,
            idCui = p_idCui,
            fecha = p_fecha
        WHERE idSol = p_idSol;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización de datos en la tabla Solicitud';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarSolicitud(
    IN p_idSol INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SET error_occurred = 1;
                ROLLBACK;
            END;
        DELETE FROM Solicitud WHERE idSol = p_idSol;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la eliminación de datos en la tabla Solicitud';
    END IF;
END;
//DELIMITER ;

-- Stored Procedure Comentario
DELIMITER //
CREATE PROCEDURE InsertarComentario(
    IN p_idSer INT,
    IN p_idUsu INT,
    IN p_idCui INT,
    IN p_fecha DATE,
    IN p_valoracion DOUBLE,
    IN p_contenido CHAR(250)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SET error_occurred = 1;
                ROLLBACK;
            END;
        INSERT INTO Comentario (idSer, idUsu, idCui, fecha, valoracion, contenido)
        VALUES (p_idSer, p_idUsu, p_idCui, p_fecha, p_valoracion, p_contenido);
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción de datos en la tabla Comentario';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE ActualizarComentario(
    IN p_idSol INT,
    IN p_idSer INT,
    IN p_idUsu INT,
    IN p_idCui INT,
    IN p_fecha DATE,
    IN p_valoracion DOUBLE,
    IN p_contenido CHAR(250)
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SET error_occurred = 1;
                ROLLBACK;
            END;
        UPDATE Comentario
        SET
            idSer = p_idSer,
            idUsu = p_idUsu,
            idCui = p_idCui,
            fecha = p_fecha,
            valoracion = p_valoracion,
            contenido = p_contenido
        WHERE idSol = p_idSol;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la actualización de datos en la tabla Comentario';
    END IF;
END;
//DELIMITER ;

DELIMITER //
CREATE PROCEDURE EliminarComentario(
    IN p_idSol INT
)
BEGIN
    DECLARE error_occurred INT DEFAULT 0;
    START TRANSACTION;
    BEGIN
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
            BEGIN
                SET error_occurred = 1;
                ROLLBACK;
            END;

        DELETE FROM Comentario WHERE idSol = p_idSol;
    END;
    IF error_occurred = 0 THEN
        COMMIT;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la eliminación de datos en la tabla Comentario';
    END IF;
END;
//DELIMITER ;
