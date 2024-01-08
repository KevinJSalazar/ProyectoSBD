use PetBacker;

-- RefugioMascotas
INSERT INTO RefugioMascotas (email, nombre, descripcion, foto, pagina_web, direccion, estado, ciudad, telefono, telefonoOp)
VALUES
('refugio1@gmail.com', 'Refugio Uno', 'Refugio para perros y gatos', NULL, 'www.refugio1.com', 'Calle Principal 123', 'Activo', 'Ciudad 1', '123-456-7890', '987-654-3210'),
('refugio2@gmail.com', 'Refugio Dos', 'Refugio para animales pequeños', NULL, 'www.refugio2.com', 'Avenida Secundaria 456', 'Activo', 'Ciudad 2', '456-789-0123', NULL),
('refugio3@gmail.com', 'Refugio Tres', 'Cuidamos de animales heridos', NULL, 'www.refugio3.com', 'Plaza Central 789', 'Activo', 'Ciudad 3', '789-012-3456', '012-345-6789'),
('refugio4@gmail.com', 'Refugio Cuatro', 'Adopciones para mascotas abandonadas', NULL, 'www.refugio4.com', 'Avenida Principal 234', 'Activo', 'Ciudad 4', '234-567-8901', NULL),
('refugio5@gmail.com', 'Refugio Cinco', 'Refugio temporal para mascotas perdidas', NULL, 'www.refugio5.com', 'Calle Secundaria 567', 'Activo', 'Ciudad 5', '567-890-1234', NULL),
('refugio6@gmail.com', 'Refugio Seis', 'Ayuda a animales en situaciones de emergencia', NULL, 'www.refugio6.com', 'Avenida Central 890', 'Activo', 'Ciudad 6', '890-123-4567', '123-456-7890'),
('refugio7@gmail.com', 'Refugio Siete', 'Rescate de animales en condiciones críticas', NULL, 'www.refugio7.com', 'Plaza Secundaria 123', 'Activo', 'Ciudad 7', '123-456-7890', '987-654-3210'),
('refugio8@gmail.com', 'Refugio Ocho', 'Atención veterinaria para mascotas necesitadas', NULL, 'www.refugio8.com', 'Avenida Final 456', 'Activo', 'Ciudad 8', '456-789-0123', NULL),
('refugio9@gmail.com', 'Refugio Nueve', 'Refugio para animales exóticos', NULL, 'www.refugio9.com', 'Calle Secundaria 789', 'Activo', 'Ciudad 9', '789-012-3456', '012-345-6789'),
('refugio10@gmail.com', 'Refugio Diez', 'Adopciones para mascotas rescatadas de maltrato', NULL, 'www.refugio10.com', 'Plaza Principal 234', 'Activo', 'Ciudad 10', '234-567-8901', NULL);

-- Usuario
INSERT INTO Usuario (email, nickname, contraseña, telefono, foto, red_social, vales, tarjeta, tipo)
VALUES
('usuario1@gmail.com', 'Usuario1', 'contraseña123', '111-222-3333', NULL, 'Facebook', 5, 1234567890123456, 'Cuidador'),
('usuario2@gmail.com', 'Usuario2', 'password456', '444-555-6666', NULL, 'Instagram', 10, 9876543210987654, 'Default'),
('usuario3@gmail.com', 'Usuario3', 'clave789', '777-888-9999', NULL, 'Twitter', 3, 3456789012345678, 'Cuidador'),
('usuario4@gmail.com', 'Usuario4', 'secreto012', '222-333-4444', NULL, 'LinkedIn', 8, 5678901234567890, 'Default'),
('usuario5@gmail.com', 'Usuario5', 'miContraseña', '555-666-7777', NULL, 'Snapchat', 12, 8765432109876543, 'Cuidador'),
('usuario6@gmail.com', 'Usuario6', 'claveSegura', '888-999-0000', NULL, 'Pinterest', 7, 2345678901234567, 'Default'),
('usuario7@gmail.com', 'Usuario7', '123456789', '333-444-5555', NULL, 'WhatsApp', 4, 6543210987654321, 'Cuidador'),
('usuario8@gmail.com', 'Usuario8', 'miPass', '666-777-8888', NULL, 'Telegram', 9, 4321098765432109, 'Default'),
('usuario9@gmail.com', 'Usuario9', 'contraseña987', '999-000-1111', NULL, 'Tumblr', 6, 2109876543210987, 'Cuidador'),
('usuario10@gmail.com', 'Usuario10', 'password123', '000-111-2222', NULL, 'Skype', 11, 1098765432109876, 'Default');

-- Donacion
INSERT INTO Donacion (idRef, idUsu, fecha, monto, cupon)
VALUES
(1, 2, '2024-01-01', 50.0, 5.0),
(2, 3, '2024-02-01', 100.0, 10.0),
(3, 4, '2024-03-01', 30.0, 3.0),
(4, 5, '2024-04-01', 75.0, 7.5),
(5, 6, '2024-05-01', 60.0, 6.0),
(6, 7, '2024-06-01', 45.0, 4.5),
(7, 8, '2024-07-01', 25.0, 2.5),
(8, 9, '2024-08-01', 90.0, 9.0),
(9, 10, '2024-09-01', 15.0, 1.5),
(10, 1, '2024-10-01', 120.0, 12.0);

-- TipoServicio
INSERT INTO TipoServicio (lugar_recogida, fecha_inicio, numero_dias, fecha_fin, detalles, raza, numero_mascotas, tipo, servicio_recogida, numero_paseos_diario)
VALUES
('Parque', '2024-01-01', 7, '2024-01-07', 'Alojamiento para perros pequeños', 'Pequeña', 3, 'Alojamiento', true, 2),
('Casa del cliente', '2024-02-01', 5, '2024-02-05', 'Paseo diario para gatos', 'Todas', 1, 'Paseo de Perros', false, 1),
('Guardería', '2024-03-01', 3, '2024-03-03', 'Cuidado de mascotas durante el día', 'Todas', 5, 'Cuidado de Mascotas', false, 0),
('Centro de peluquería', '2024-04-01', 1, '2024-04-01', 'Peluquería para perros y gatos', 'Todas', 2, 'Peluquería', true, 0),
('Parque', '2024-05-01', 2, '2024-05-02', 'Paseo matutino y vespertino para perros', 'Todas', 4, 'Paseo de Perros', true, 2),
('Casa del cliente', '2024-06-01', 4, '2024-06-04', 'Cuidado nocturno para perros pequeños', 'Pequeña', 2, 'Guardería', false, 0),
('Taxi móvil', '2024-07-01', 1, '2024-07-01', 'Transporte de mascotas a citas veterinarias', 'Todas', 1, 'Taxi de Mascotas', true, 0),
('Centro de adiestramiento', '2024-08-01', 10, '2024-08-10', 'Entrenamiento básico para perros', 'Todas', 3, 'Adiestramiento de mascota', false, 0),
('Parque', '2024-09-01', 3, '2024-09-03', 'Paseo diario para perros', 'Todas', 2, 'Paseo de Perros', false, 3),
('Casa del cliente', '2024-10-01', 7, '2024-10-07', 'Cuidado extendido para gatos', 'Todas', 1, 'Guardería', true, 0);

-- Tamaño
INSERT INTO Tamaño (idTipoSer, tamaño)
VALUES
(1, '1-5kg'),
(2, '5-10kg'),
(3, '10-20kg'),
(4, '20-40kg'),
(5, '40+kg'),
(6, '1-5kg'),
(7, '5-10kg'),
(8, '10-20kg'),
(9, '20-40kg'),
(10, '40+kg');

-- TipoMascotas
INSERT INTO TipoMascotas (idTipoSer, mascota)
VALUES
(1, 'Perro'),
(2, 'Gato'),
(3, 'Conejo'),
(4, 'Conejillo de indias'),
(5, 'Hurón'),
(6, 'Ave'),
(7, 'Reptil'),
(8, 'Otros'),
(9, 'Gato'),
(10, 'Perro');

-- TipoAseo
INSERT INTO TipoAseo (idTipoSer, aseo)
VALUES
(1, 'básico'),
(2, 'completo'),
(3, 'ducha'),
(4, 'afeitado de almohadillas de patas'),
(5, 'recorte y relleno de uñas'),
(6, 'básico'),
(7, 'completo'),
(8, 'ducha'),
(9, 'afeitado de almohadillas de patas'),
(10, 'recorte y relleno de uñas');

-- Servicio
INSERT INTO Servicio (idCui, titulo, descripcion, precio, pais, provincia, ciudad, idTipoSer)
VALUES
(1, 'Alojamiento para perros', 'Cómoda estadía para perros pequeños', 30.0, 'País1', 'Provincia1', 'Ciudad1', 1),
(3, 'Paseo de gatos', 'Paseo diario para gatos', 15.0, 'País2', 'Provincia2', 'Ciudad2', 2),
(5, 'Cuidado especial para mascotas', 'Atención especializada para mascotas con necesidades específicas', 50.0, 'País3', 'Provincia3', 'Ciudad3', 3),
(7, 'Guardería de día', 'Guardería para mascotas durante el día', 25.0, 'País4', 'Provincia4', 'Ciudad4', 4),
(7, 'Taxi para mascotas', 'Transporte seguro para mascotas', 20.0, 'País5', 'Provincia5', 'Ciudad5', 5),
(5, 'Peluquería canina', 'Servicio de peluquería para perros', 35.0, 'País6', 'Provincia6', 'Ciudad6', 6),
(3, 'Adiestramiento de mascotas', 'Clases de adiestramiento para perros', 40.0, 'País7', 'Provincia7', 'Ciudad7', 7),
(1, 'Paseo de perros premium', 'Paseo exclusivo para perros con servicios premium', 50.0, 'País8', 'Provincia8', 'Ciudad8', 8),
(1, 'Servicio de guardería nocturna', 'Guardería para mascotas durante la noche', 30.0, 'País9', 'Provincia9', 'Ciudad9', 9),
(5, 'Peluquería felina', 'Servicio de peluquería para gatos', 25.0, 'País10', 'Provincia10', 'Ciudad10', 10);

-- Solicitud
INSERT INTO Solicitud (idSer, idUsu, idCui, fecha)
VALUES
(1, 2, 1, '2024-03-02'),
(2, 1, 2, '2024-04-02'),
(3, 1, 2, '2024-05-03'),
(4, 2, 1, '2024-06-04'),
(5, 1, 2, '2024-07-05'),
(6, 2, 1, '2024-08-06'),
(7, 1, 2, '2024-09-07'),
(8, 2, 1, '2024-10-08'),
(9, 1, 2, '2024-11-09'),
(10, 2, 1, '2024-12-10');

-- Comentario
INSERT INTO Comentario (idSer, idUsu, idCui, fecha, valoracion, contenido)
VALUES
(1, 2, 1, '2024-03-03', 4.5, '¡Muy satisfecho con el servicio!'),
(2, 1, 2, '2024-04-03', 5.0, '¡Excelente paseo para mi gato!'),
(3, 1, 2, '2024-05-03', 4.0, 'Buen cuidado para mis mascotas'),
(4, 2, 1, '2024-06-03', 4.8, 'Recomendaría este servicio a otros propietarios'),
(5, 1, 2, '2024-07-03', 3.5, 'Algo de retraso en el servicio de taxi'),
(6, 2, 1, '2024-08-03', 4.7, 'El peluquero hizo un gran trabajo'),
(7, 1, 2, '2024-09-03', 4.2, 'Clases de adiestramiento muy útiles'),
(8, 2, 1, '2024-10-03', 4.9, 'Paseo de perros premium valió la pena'),
(9, 1, 2, '2024-11-03', 4.0, 'Servicio de guardería nocturna confiable'),
(10, 2, 1, '2024-12-03', 4.5, 'Peluquería felina satisfactoria');