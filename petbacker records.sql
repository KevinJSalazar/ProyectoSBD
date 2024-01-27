USE PetBacker;
INSERT INTO RefugioMascotas (email, nombre, descripcion, foto, pagina_web, direccion, estado, ciudad, telefono, telefonoOp) VALUES
('refugio1@example.com', 'Refugio de Animales Felices', 'Refugio para perros y gatos abandonados.', NULL, 'www.refugiofeliz.com', 'Calle Principal 123', 'California', 'Los Angeles', '1234567890', '0987654321'),
('refugio2@example.com', 'Hogar de Mascotas Rescatadas', 'Rescatamos y rehabilitamos mascotas necesitadas.', NULL, 'www.hogarmascotasrescatadas.org', 'Avenida Central 456', 'Texas', 'Houston', '9876543210', NULL),
('refugio3@example.com', 'Refugio de Esperanza Animal', 'Brindamos refugio y cuidado a perros callejeros.', NULL, 'www.esperanzaanimal.org', 'Calle de la Esperanza 789', 'Florida', 'Miami', '7418529630', NULL),
('refugio4@example.com', 'Refugio Amor y Protección', 'Ofrecemos amor y cuidado a perros y gatos abandonados.', NULL, 'www.amoryproteccionrefugio.com', 'Avenida Libertad 246', 'New York', 'Nueva York', '3692581470', NULL),
('refugio5@example.com', 'Centro de Rescate Animal', 'Rescatamos y encontramos hogares amorosos para mascotas necesitadas.', NULL, 'www.rescateanimalcenter.org', 'Calle de la Misericordia 135', 'California', 'San Francisco', '9517534680', NULL),
('refugio6@example.com', 'Refugio de Mascotas Sin Hogar', 'Damos refugio temporal a mascotas abandonadas hasta encontrarles un hogar.', NULL, 'www.mascotassinhogar.org', 'Avenida de la Solidaridad 789', 'Texas', 'Austin', '8529631470', NULL),
('refugio7@example.com', 'Santuario Animal', 'Brindamos cuidado y amor a animales en situaciones difíciles.', NULL, 'www.santuarioanimal.org', 'Calle de la Compasión 357', 'Florida', 'Orlando', '2587413690', NULL),
('refugio8@example.com', 'Rescate y Rehabilitación de Mascotas', 'Rescatamos y rehabilitamos animales maltratados y abandonados.', NULL, 'www.rescaterehabilitacionmascotas.org', 'Avenida Esperanza 951', 'California', 'San Diego', '1472583690', NULL),
('refugio9@example.com', 'Refugio de Animales Sin Hogar', 'Proporcionamos refugio temporal y cuidado a mascotas sin hogar.', NULL, 'www.refugiosinhogar.org', 'Calle de la Comprensión 753', 'Texas', 'Dallas', '3691472580', NULL),
('refugio10@example.com', 'Hogar Temporal de Mascotas', 'Ofrecemos refugio temporal y amor a mascotas necesitadas hasta encontrarles un hogar permanente.', NULL, 'www.hogartemporalmascotas.org', 'Avenida de la Solidaridad 753', 'Florida', 'Tampa', '1239874560', NULL);


INSERT INTO Usuario (email, nickname, contraseña, telefono, foto, red_social, vales, tarjeta, tipo) VALUES
('usuario1@example.com', 'AmanteDeLosAnimales', 'contraseña123', '9876543210', NULL, 'facebook.com/amantedelosanimales', 10, '1234567890123456', 'Cuidador'),
('usuario2@example.com', 'ProtectorDePeludos', 'micontraseña', '1234567890', NULL, 'twitter.com/protectorpeludos', 5, '9876543210987654', 'Cuidador'),
('usuario3@example.com', 'RescatistaSolidario', '123456', '3692581470', NULL, 'instagram.com/rescatistasolidario', 3, '6543210987654321', 'Cuidador'),
('usuario4@example.com', 'DefensorDeAnimales', 'animallover', '7418529630', NULL, 'facebook.com/defensordeanimales', 8, '3210987654321098', 'Cuidador'),
('usuario5@example.com', 'CuidadorCompasivo', 'miclave', '9517534680', NULL, 'twitter.com/cuidadorcompasivo', 12, '2109876543210987', 'Cuidador'),
('usuario6@example.com', 'AmigoDeLosPeludos', 'contraseña1234', '8529631470', NULL, 'instagram.com/amigodelospeludos', 6, '5432109876543210', 'Cuidador'),
('usuario7@example.com', 'AdoptaNoCompres', '12345678', '2587413690', NULL, 'facebook.com/adoptanocompres', 4, '8765432109876543', 'Cuidador'),
('usuario8@example.com', 'AyudaAnimal', 'miclave123', '1472583690', NULL, 'twitter.com/ayudaanimal', 9, '6543210987654321', 'Cuidador'),
('usuario9@example.com', 'RescatadorFiel', 'password', '3691472580', NULL, 'instagram.com/rescatadorfiel', 7, '9876543210123456', 'Cuidador'),
('usuario10@example.com', 'GuardiánDePeludos', 'contraseña', '1239874560', NULL, 'facebook.com/guardiandepeludos', 11, '1234567890987654', 'Cuidador');

INSERT INTO Donacion (idRef, idUsu, fecha, monto, cupon) VALUES
(1, 1, '2023-01-05', 100.00, 0.00),
(2, 2, '2023-02-10', 50.00, 0.00),
(3, 3, '2023-03-15', 75.00, 0.00),
(4, 4, '2023-04-20', 200.00, 0.00),
(5, 5, '2023-05-25', 150.00, 0.00),
(6, 6, '2023-06-30', 120.00, 0.00),
(7, 7, '2023-07-05', 80.00, 0.00),
(8, 8, '2023-08-10', 90.00, 0.00),
(9, 9, '2023-09-15', 110.00, 0.00),
(10, 10, '2023-10-20', 70.00, 0.00);

INSERT INTO TipoServicio (lugar_recogida, fecha_inicio, numero_dias, fecha_fin, detalles, raza, numero_mascotas, tipo, servicio_recogida, numero_paseos_diario) VALUES
('En casa del dueño', '2023-01-05', 7, '2023-01-12', 'Cuidado especial requerido para mascota anciana', 'Labrador Retriever', 1, 'Cuidado de Mascotas', true, 2),
('En el refugio', '2023-02-10', 3, '2023-02-13', 'Requiere dieta específica', 'Persa', 1, 'Alojamiento', false, 0),
('En la residencia del cuidador', '2023-03-15', 5, '2023-03-20', 'Necesita paseos largos diarios', 'Golden Retriever', 1, 'Paseo de Perros', true, 3),
('En el hogar del propietario', '2023-04-20', 2, '2023-04-22', 'Mascota tímida, necesita atención tranquila', 'Mestizo', 1, 'Cuidado de Mascotas', true, 1),
('En casa del cliente', '2023-05-25', 4, '2023-05-29', 'Necesita ser cepillado regularmente', 'Maine Coon', 1, 'Peluquería', false, 0),
('En la residencia del cliente', '2023-06-30', 7, '2023-07-07', 'Requiere medicación diaria', 'Bulldog Francés', 1, 'Cuidado de Mascotas', false, 0),
('En casa del dueño', '2023-07-05', 6, '2023-07-11', 'Mascota con comportamiento agresivo hacia otros animales', 'Chihuahua', 1, 'Cuidado de Mascotas', true, 2),
('En el hogar del propietario', '2023-08-10', 1, '2023-08-11', 'Mascota muy activa, necesita mucho ejercicio', 'Border Collie', 1, 'Paseo de Perros', true, 3),
('En la residencia del cuidador', '2023-09-15', 10, '2023-09-25', 'Mascota con alergias alimentarias', 'Labradoodle', 1, 'Cuidado de Mascotas', true, 1),
('En casa del cliente', '2023-10-20', 3, '2023-10-23', 'Mascota miedosa, necesita atención paciente', 'Siamese', 1, 'Cuidado de Mascotas', false, 0);

INSERT INTO Tamaño (idTipoSer, tamaño) VALUES
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

INSERT INTO TipoMascotas (idTipoSer, mascota) VALUES
(1, 'Perro'),
(2, 'Gato'),
(3, 'Conejo'),
(4, 'Conejillo de indias'),
(5, 'Hurón'),
(6, 'Ave'),
(7, 'Reptil'),
(8, 'Otros'),
(9, 'Perro'),
(10, 'Gato');

INSERT INTO TipoAseo (idTipoSer, aseo) VALUES
(5, 'completo'),
(5, 'ducha'),
(5, 'afeitado de almohadillas de patas'),
(5, 'recorte y relleno de uñas');

INSERT INTO Servicio (idCui, titulo, descripcion, precio, pais, provincia, ciudad, idTipoSer) VALUES
(1, 'Cuidado de mascotas en casa', 'Ofrezco cuidado de mascotas en un ambiente hogareño y amoroso.', 30.00, 'Estados Unidos', 'California', 'Los Angeles', 1),
(2, 'Paseo diario para perros', 'Paseos diarios para perros de todas las razas y tamaños.', 15.00, 'Estados Unidos', 'Texas', 'Houston', 3),
(3, 'Alojamiento para gatos', 'Alojamiento seguro y confortable para gatos en un entorno tranquilo.', 20.00, 'Estados Unidos', 'Florida', 'Miami', 2),
(4, 'Cuidado de mascotas a domicilio', 'Visitas diarias para alimentar, jugar y cuidar de tus mascotas en tu hogar.', 25.00, 'Estados Unidos', 'New York', 'Nueva York', 1),
(5, 'Servicio de taxi para mascotas', 'Transporte seguro y cómodo para mascotas a sus citas veterinarias o cualquier otro lugar.', 40.00, 'Estados Unidos', 'California', 'San Francisco', 5),
(6, 'Peluquería canina', 'Baño, corte de pelo y cepillado para perros de todas las razas y tamaños.', 50.00, 'Estados Unidos', 'Texas', 'Austin', 6),
(7, 'Guardería para perros', 'Guardería diurna para perros con juegos y actividades supervisadas.', 35.00, 'Estados Unidos', 'Florida', 'Orlando', 4),
(8, 'Adiestramiento de mascotas', 'Entrenamiento profesional y amigable para perros de todas las edades y razas.', 60.00, 'Estados Unidos', 'California', 'San Diego', 7),
(9, 'Visitas a domicilio para gatos', 'Visitas diarias para cuidar de tus gatos en la comodidad de tu hogar.', 30.00, 'Estados Unidos', 'Texas', 'Dallas', 2),
(10, 'Paseo relajante para perros', 'Paseos tranquilos y relajantes para perros que prefieren un ritmo más pausado.', 20.00, 'Estados Unidos', 'Florida', 'Tampa', 3);

INSERT INTO Solicitud (idSer, idUsu, idCui, fecha) VALUES
(1, 1, 2, '2023-01-03'),
(2, 3, 4, '2023-02-08'),
(3, 5, 6, '2023-03-13'),
(4, 7, 8, '2023-04-18'),
(5, 9, 10, '2023-05-23'),
(6, 1, 2, '2023-06-28'),
(7, 3, 4, '2023-07-03'),
(8, 5, 6, '2023-08-08'),
(9, 7, 8, '2023-09-13'),
(10, 9, 10, '2023-10-18');

INSERT INTO Comentario (idSer, idUsu, idCui, fecha, valoracion, contenido) VALUES
(1, 2, 1, '2023-01-15', 4.5, 'Excelente cuidado, mi mascota estaba muy feliz.'),
(2, 4, 3, '2023-02-20', 5.0, 'Mi perro realmente disfrutó su paseo, ¡gracias!'),
(3, 6, 5, '2023-03-25', 4.0, 'Mi gato se veía genial después del alojamiento.'),
(4, 8, 7, '2023-04-30', 4.8, 'Muy profesional y atento al cuidar de mi mascota.'),
(5, 10, 9, '2023-05-30', 4.2, 'El servicio de taxi para mascotas fue muy conveniente.'),
(6, 2, 1, '2023-07-05', 4.7, 'Mi perro se veía muy bien después del servicio de peluquería.'),
(7, 4, 3, '2023-08-10', 4.5, 'La guardería para perros proporcionó un buen ambiente para mi mascota.'),
(8, 6, 5, '2023-09-15', 4.9, 'El adiestramiento de mi perro fue muy efectivo.'),
(9, 8, 7, '2023-10-20', 4.3, 'El cuidador fue muy amable durante las visitas a mi gato.'),
(10, 10, 9, '2023-11-25', 4.6, 'Los paseos relajantes fueron perfectos para mi perro mayor.');
