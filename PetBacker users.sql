USE PetBacker;

DROP USER 'Kevin'@'localhost';
DROP USER Alejandro;
DROP USER Genesis;
DROP USER Levin;
DROP USER 'Adolfito'@'localhost';

-- Crear usuarios
CREATE USER 'Kevin'@'localhost' IDENTIFIED BY 'Rocko';
CREATE USER Alejandro IDENTIFIED BY 'Veinte';
CREATE USER Genesis IDENTIFIED BY 'Lopez_al_cuadrado';
CREATE USER Levin;
CREATE USER 'Adolfito'@'localhost' IDENTIFIED BY 'OnceOnce';

-- Asignar permisos
GRANT EXECUTE ON PROCEDURE InsertarRefugioMascotas TO 'Kevin'@'localhost';
GRANT EXECUTE ON PROCEDURE ActualizarRefugioMascotas TO 'Kevin'@'localhost';
GRANT EXECUTE ON PROCEDURE EliminarRefugioMascotas TO 'Kevin'@'localhost';
GRANT SELECT, INSERT, DELETE ON RefugioMascotas TO 'Kevin'@'localhost';
GRANT SELECT ON RefugiosDonados TO 'Kevin'@'localhost';

GRANT EXECUTE ON PROCEDURE InsertarUsuario TO Alejandro;
GRANT EXECUTE ON PROCEDURE ActualizarUsuario TO Alejandro;
GRANT EXECUTE ON PROCEDURE EliminarUsuario TO Alejandro;
GRANT SELECT, INSERT, DELETE ON Usuario TO Alejandro;
GRANT SELECT ON ComentariosUsuario TO Alejandro;

GRANT EXECUTE ON PROCEDURE InsertarDonacion TO Genesis;
GRANT EXECUTE ON PROCEDURE ActualizarDonacion TO Genesis;
GRANT EXECUTE ON PROCEDURE EliminarDonacion TO Genesis;
GRANT SELECT, INSERT, DELETE ON Donacion TO Genesis;

GRANT EXECUTE ON PROCEDURE InsertarServicio TO Levin;
GRANT EXECUTE ON PROCEDURE ActualizarServicio TO Levin;
GRANT EXECUTE ON PROCEDURE EliminarServicio TO Levin;
GRANT SELECT, INSERT, DELETE ON Servicio TO Levin;
GRANT SELECT ON ServicioSolicitado TO Levin;

GRANT EXECUTE ON PROCEDURE InsertarSolicitud TO Levin;
GRANT SELECT ON CantidadServicios TO 'Adolfito'@'localhost';
GRANT SELECT ON UsuarioMascota TO 'Adolfito'@'localhost';
