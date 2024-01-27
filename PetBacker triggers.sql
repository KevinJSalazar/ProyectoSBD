USE PetBacker;

-- Triggers
DELIMITER //
CREATE TRIGGER cupon
BEFORE INSERT ON petbacker.donacion
FOR EACH ROW
BEGIN
	SET NEW.cupon = round(NEW.monto*2, 2);
END;
// DELIMITER ;

DELIMITER //
CREATE TRIGGER antes_insertar_tipo_aseo
BEFORE INSERT ON TipoAseo
FOR EACH ROW
BEGIN
    DECLARE tipo_servicio VARCHAR(50);

    SELECT tipo INTO tipo_servicio
    FROM TipoServicio
    WHERE idTipoSer = NEW.idTipoSer;

    IF tipo_servicio != 'Peluquería' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El tipo de servicio debe ser "Peluquería" para registrar un tipo de aseo';
    END IF;
END;
//DELIMITER ;