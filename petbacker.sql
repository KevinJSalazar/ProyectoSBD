drop database PetBacker;
create database if not exists PetBacker;
use PetBacker;
create table RefugioMascotas(
	idRef int not null unique check(idRef > 0 AND idRef < 1000),
    email char(50) not null unique,
    descripcion char(250) not null,
    foto char(250) not null,
    pagina_web char(50) not null,
    direccion char(50) not null,
    estado char(30) not null,
    ciudad char(30) not null,
    telefono char(20) not null,
    telefonoOp char(20),
    primary key(idRef)
);
create table Usuario(
	idUsu int not null unique check(idUsu > 0 AND idUsu < 100000),
    email char(50) not null unique,
    nickname char(250) not null,
    contraseña char(50) not null,
    telefono char(20),
    foto char(250) not null,
    red_social char(30),
    vales int not null,
    tarjeta int,
    tipo char(20) check(tipo = "Cuidador" OR tipo is null),
    primary key(idUsu)
);
create table Donacion(
	idDon int not null unique check(idDon > 0 AND idDon < 100000),
	idRef int not null unique check(idRef > 0 AND idRef < 1000),
	idUsu int not null unique check(idUsu > 0 AND idUsu < 100000),
	fecha date not null,
    monto double not null,
    cupon double not null,
    primary key(idDon, idRef, idUsu),
    foreign key(idRef) references RefugioMascotas(idRef),
    foreign key(idUsu) references Usuario(idUsu)
);
create table TipoServicio(
	idTipoSer int not null unique check(idTipoSer > 0 AND idTipoSer < 100000),
    lugar_recogida char(250) not null,
    fecha_inicio date not null,
    numero_dias int not null check(numero_dias >= 1 AND numero_dias <= 365),
	fecha_fin date not null,
    detalles char(250),
    raza char(100) not null,
    numero_mascotas int not null check(numero_mascotas >= 1 AND numero_mascotas <= 8),
    tipo char(50) not null check(tipo IN ("Alojamiento", "Paseo de Perros", "Cuidado de Mascotas", "Guardería", "Taxi de Mascotas", "Peluquería", "Adiestramiento de mascota" )),
    servicio_recogida boolean,
	numero_paseos_diario int check(numero_paseos_diario >= 1 AND numero_paseos_diario <= 3),
    primary key(idTipoSer)
);
create table Tamaño(
	idTam int auto_increment not null unique,
    idTipoSer int not null check(idTipoSer > 0 AND idTipoSer < 100000),
    tamaño char(30) not null check(tamaño IN ("1-5kg", "5-10kg", "10-20kg", "20-40kg", "40+kg")),
    primary key(idTam, idTipoSer),
    foreign key(idtipoSer) references TipoServicio(idTipoSer)
);
create table TipoMascotas(
	idTipoMas int not null unique check(idTipoMas > 0 AND idTipoMas < 1000000),
    idTipoSer int not null unique check(idTipoSer > 0 AND idTipoSer < 100000),
    mascota char(30) not null check(mascota IN ("Perro", "Gato", "Conejo", "Conejillo de indias", "Hurón", "Ave", "Reptil", "Otros")),
    primary key(idTipoMas, idTipoSer),
    foreign key(idtipoSer) references TipoServicio(idTipoSer)
);
create table TipoAseo(
	idTipoAseo int not null unique check(idTipoAseo > 0 AND idTipoAseo < 1000000),
    idTipoSer int not null unique check(idTipoSer > 0 AND idTipoSer < 100000),
    aseo char(50) not null check(aseo IN ("básico", "completo", "ducha", "afeitado de almohadillas de patas", "recorte y relleno de uñas")),
    primary key(idTipoAseo, idTipoSer),
    foreign key(idtipoSer) references TipoServicio(idTipoSer)
);
create table Servicio(
	idSer int not null unique check(idSer > 0 AND idSer < 100000),
    idCui int not null unique check(idCui > 0 AND idCui < 100000),
    titulo char(50) not null,
    descripcion char(250) not null,
    precio double not null,
    pais char(30) not null,
    provincia char(30) not null,
    ciudad char(30) not null,
    idTipoSer int not null,
    primary key(idSer, idCui),
    foreign key(idCui) references Usuario(idUsu),
    foreign key(idTipoSer) references TipoServicio(idTipoSer)
);
create table Solicitud(
	idSol int auto_increment not null unique,
	idSer int not null check(idSer > 0 AND idSer < 100000),
    idUsu int not null check(idUsu > 0 AND idUsu < 100000),
    idCui int not null check(idCui > 0 AND idCui < 100000),
    constraint diferentes1 check(idUsu != idCui),
    fecha date not null,
    primary key(idSol, idSer, idUsu, idCui),
    foreign key(idSer) references Servicio(idSer),
    foreign key(idUsu) references Usuario(idUsu),
    foreign key(idCui) references Usuario(idUsu)
);
create table Comentario(
	idSol int auto_increment not null unique,
	idSer int not null check(idSer > 0 AND idSer < 100000),
    idUsu int not null check(idUsu > 0 AND idUsu < 100000),
    idCui int not null check(idCui > 0 AND idCui < 100000),
    constraint diferentes2 check(idUsu != idCui),
    fecha date not null,
    valoracion double not null,
    contenido char(250) not null,
    primary key(idSol, idSer, idUsu, idCui),
    foreign key(idSer) references Servicio(idSer),
    foreign key(idUsu) references Usuario(idUsu),
    foreign key(idCui) references Usuario(idUsu)
);

insert into RefugioMascotas values(1, "asd@company.com", "Refugio de Gatitos en el Guasmo",  "https://i0.wp.com/puppis.blog/wp-content/uploads/2022/02/abc-cuidado-de-los-gatos-min.jpg?resize=1024%2C681&ssl=1", "www.gatitosrefugiados.com", "Coop. Unión de bananeros", "Guayas", "Guayaquil", 1234541244, null);
insert into RefugioMascotas values(2, "das@company.com", "Refugio Perrito", "url.png",  "www.refugioperritos.com", "Portete y la 32", "Guayas", "Guayaquil", 1234541244, null);
insert into RefugioMascotas values(3, "exc@company.com", "Refugio Animal", "url.png",  "www.refugioanimal.com", "Rumichaca", "Guayas", "Guayaquil", 1234541244, null);
insert into RefugioMascotas values(4, "def@company.com", "Refugio amiguitos", "url.png",  "www.refugioamigo.com", "Malecón del salado", "Guayas", "Guayaquil", 1234541244, null);
insert into RefugioMascotas values(5, "qwe@company.com", "Refugio Gato Bonito", "url.png",  "www.refugiogatito.com", "Espol Campus Prosperina", "Guayas", "Guayaquil", 1234541244, null);
insert into RefugioMascotas values(6, "erd@company.com", "El gato elegante", "url.png",  "www.refugiogatoelegante.com", "Malecón 2000", "Guayas", "Guayaquil", 1234541244, null);
insert into RefugioMascotas values(7, "wfd@company.com", "Refugio cachorro", "url.png",  "www.refugiocachorro.com", "Mall el Fortín", "Guayas", "Guayaquil", 1234541244, null);
insert into RefugioMascotas values(8, "gtr@company.com", "Refugio animales seguros", "url.png",  "www.refugioanimalseguro.com", "9 de Octubre", "Guayas", "Guayaquil", 1234541244, null);
insert into RefugioMascotas values(9, "jtn@company.com", "Refugio Las Peñas", "url.png",  "www.refugiopeñas.com", "Las Peñas", "Guayas", "Guayaquil", 1234541244, null);
insert into RefugioMascotas values(10, "llm@company.com", "El perro feliz", "url.png",  "www.refugioperrofeli.com", "Urdesa", "Guayas", "Guayaquil", 1234541244, null);

insert into Usuario values(1, "vet@outlook.com", "Vet24", 12345, 3334445551, "image.png", null, 20, 1111111111, null);
insert into Usuario values(2, "det@outlook.com", "Det41", 54321, 3332245551, "image.jpg", "Det Exa 4", 10, 1111111112, null);
insert into Usuario values(3, "des@outlook.com", "Des45", "12asd23def", 3334445551, "image.png", null, 35, 1111111113, null);
insert into Usuario values(4, "rad@outlook.com", "RadIcal", 343451, 3334335551, "image.png", null, 40, 1111111114, null);
insert into Usuario values(5, "bir@outlook.com", "Birdie21", "Net86", 3334665551, "image.jpg", "Bir Cage 5", 20, 1111111115, null);
insert into Usuario values(6, "num@outlook.com", "NumLock41", "defaultvalue123", 3224445551, "image.png", null, 20, 1111111116, null);
insert into Usuario values(7, "cli@outlook.com", "Clitheclient", "ExcellentCompany", 3354445551, "image.png", null, 5, 1111111117, null);
insert into Usuario values(8, "org@outlook.com", "Org563", "Sparky2024", 3334425651, "image.jpg", null, 0, 1111111118, null);
insert into Usuario values(9, "pul@outlook.com", "Pulp76", "qw12er34ty5", 3398645551, "image.png", null, 100, 1111111119, null);
insert into Usuario values(10, "red@outlook.com", "RedlikeaFlower", "qwerty", 3322145551, "image.png", "Red June", 15, 1111111110, null);

insert into Usuario values(20, "der@outlook.com", "Der24", 12345, 3334442551, "image.jpg", "Derek Flint", 0, 1111111101, "Cuidador");
insert into Usuario values(21, "fer@outlook.com", "Fernando31", 1234, 1334442551, "image.png", "Fernando Pinargote", 40, 1111111102, "Cuidador");
insert into Usuario values(22, "ter@outlook.com", "Teresse789", "54a631s", 1334443552, "image.png", null, 40, 1111111103, "Cuidador");
insert into Usuario values(23, "lev@outlook.com", "Levze514", "asd41qwe51.4", 1322442551, "image.png", null, 500, 1111111104, "Cuidador");
insert into Usuario values(24, "liv@outlook.com", "LivingForever1", "Forever_and.Ever20", 1334442533, "image.png", "Liv Ramos", 0, 1111111105, "Cuidador");
insert into Usuario values(25, "gru@outlook.com", "GruVillain54", "Moon", 1334242751, "image.png", null, 0, 1111111106, "Cuidador");
insert into Usuario values(26, "min@outlook.com", "Min0909", "des31ftg.6", 8934442551, "image.png", null, 15, 1111111107, "Cuidador");
insert into Usuario values(27, "lor@outlook.com", "Lor82", 1234, 1339842551, "image.png", null, 0, 1111111108, "Cuidador");
insert into Usuario values(28, "gef@outlook.com", "Geff", 54321, 1334476551, "image.png", null, 0, 1111111109, "Cuidador");
insert into Usuario values(29, "ban@outlook.com", "YouAreBanned", 1285567890, 1334442551, "image.png", "Ban Des", 0, 1111111010, "Cuidador");

insert into Donacion values(1, 1, 1, "2023-07-24", 5, 10);
insert into Donacion values(2, 4, 2, "2023-07-24", 5, 10);
insert into Donacion values(3, 3, 4, "2023-07-24", 5, 10);
insert into Donacion values(4, 2, 3, "2023-05-25", 20, 40);
insert into Donacion values(5, 5, 6, "2023-05-25", 25, 50);
insert into Donacion values(6, 7, 25, "2023-02-12", 50, 100);
insert into Donacion values(7, 6, 23, "2023-08-03", 1, 2);
insert into Donacion values(8, 8, 26, "2023-08-04", 1, 2);
insert into Donacion values(9, 10, 5, "2023-07-24", 30, 60);
insert into Donacion values(10, 9, 8, "2023-04-24", 12, 24);

insert into TipoServicio values(70, "9 de Octubre", "2023-02-14", 3, "2023-02-17", "Sensible a ruidos", "Siames", 1, "Guardería", false, null);
insert into TipoServicio values(71, "Alborada", "2023-10-03", 1, "2023-10-04", null, "Mestizo", 2, "Paseo de Perros", true, 2);
insert into TipoServicio values(72, "Parque Centenario", "2023-12-01", 14, "2023-12-15", null, "Sphynx", 2, "Alojamiento", false, null);
insert into TipoServicio values(73, "Samborondón", "2023-04-04", 5, "2023-04-09", null, "Pug", 3, "Paseo de Perros", true, 2);
insert into TipoServicio values(74, "Alborada", "2023-02-03", 20, "2023-02-23", "Es muy jugueton", "Mestizo", 2, "Alojamiento", false, null);
insert into TipoServicio values(75, "Avenida Kenedy", "2024-02-14", 10, "2024-02-24", "Sensible al frio", "Mestizo", 3, "Alojamiento", true, 3);
insert into TipoServicio values(76, "Avenida Carchi", "2023-12-24", 1, "2023-12-25", null, "Boxer", 1, "Cuidado de Mascotas", true, 2);
insert into TipoServicio values(77, "Samborondón", "2023-05-25", 2, "2023-05-27", null, "Mestizo", 2, "Guardería", false, null);
insert into TipoServicio values(78, "Bella Vista", "2023-07-19", 5, "2023-07-24", "Cuidado lo pisa", "Chihuahua", 2, "Guardería", true, 2);
insert into TipoServicio values(79, "Bella Vista 2", "2023-07-19", 5, "2023-07-24", "Cuidado lo pisa", "Chihuahua", 2, "Guardería", true, 2);

insert into Tamaño values(1, 70, "1-5kg");
insert into Tamaño values(2, 71, "5-10kg");
insert into Tamaño values(3, 72, "1-5kg");
insert into Tamaño values(4, 73, "5-10kg");
insert into Tamaño values(5, 74, "1-5kg");
insert into Tamaño values(6, 75, "20-40kg");
insert into Tamaño values(7, 76, "5-10kg");
insert into Tamaño values(8, 77, "20-40kg");
insert into Tamaño values(9, 78, "5-10kg");
insert into Tamaño values(0, 79, "5-10kg");

insert into TipoMascotas values (1, 70, "Gato");
insert into TipoMascotas values (2, 71, "Perro");
insert into TipoMascotas values (3, 72, "Gato");
insert into TipoMascotas values (4, 73, "Perro");
insert into TipoMascotas values (5, 74, "Perro");
insert into TipoMascotas values (6, 75, "Reptil");
insert into TipoMascotas values (7, 76, "Perro");
insert into TipoMascotas values (8, 77, "Perro");
insert into TipoMascotas values (9, 78, "Otros");
insert into TipoMascotas values (10, 79, "Ave");

insert into TipoAseo values (1, 70, "completo");
insert into TipoAseo values (2, 71, "ducha");
insert into TipoAseo values (3, 72, "ducha");
insert into TipoAseo values (4, 73, "afeitado de almohadillas de patas");
insert into TipoAseo values (5, 74, "básico");
insert into TipoAseo values (6, 75, "ducha");
insert into TipoAseo values (7, 76, "afeitado de almohadillas de patas");
insert into TipoAseo values (8, 77, "básico");
insert into TipoAseo values (9, 78, "recorte y relleno de uñas");
insert into TipoAseo values (10, 79, "completo");

insert into Servicio values(60, 20, "Mascotas de Ben", "Servicio de cuidado amoroso para mascota", 25.50, "Ecuador", "Pichincha", "Quito", 70); 
insert into Servicio values(61, 21, "Cuidandolos", "Atención cariñosa para mascotas", 25.50, "Ecuador", "Pichincha", "Quito", 71); 
insert into Servicio values(62, 22, "PawParadise", "cuidado bonito", 25.50, "Ecuador", "Pichincha", "Quito", 72);
insert into Servicio values(63, 23, "PetPamperPalace", "Cuidado cariñoso para mascotas", 25.50, "Ecuador", "Pichincha", "Quito", 73); 
insert into Servicio values(64, 24, "Explora Colitas", "Paseo entretenido", 30.50, "Ecuador", "Tarqui", "Guayaquil", 74);  
insert into Servicio values(65, 25, "Aventuras con patitas", "Paseo entretenido para perros", 30.50, "Ecuador", "Tarqui", "Guayaquil", 75);
insert into Servicio values(66, 26, "Paseo Peludo", "Paseo divertido y saludable para perros", 30.50, "Ecuador", "Tarqui", "Guayaquil", 76);
insert into Servicio values(67, 27, "RefugioPetFriendly", "Alojamiento amplio y cómodo.", 35.50, "Ecuador", "Chimborazo", "Riobamba", 77);
insert into Servicio values(68, 28, "Hotel Patas Felices", "Espacio de alojamiento cómodo y acogedor.", 35.50, "Ecuador", "Chimborazo", "Riobamba", 78);
insert into Servicio values(69, 29, "Suites Peludas", "Alojamiento espacioso y confortable.", 35.50, "Ecuador", "Chimborazo", "Riobamba", 79);

insert into Solicitud values(80, 60, 1, 20, "2023-12-01");
insert into Solicitud values(81, 61, 2, 21, "2023-12-02");
insert into Solicitud values(82, 62, 3, 22, "2023-12-03");
insert into Solicitud values(83, 63, 4, 23, "2023-12-04");
insert into Solicitud values(84, 64, 5, 24, "2023-12-05");
insert into Solicitud values(85, 65, 6, 25, "2023-12-06");
insert into Solicitud values(86, 66, 7, 26, "2023-12-07");
insert into Solicitud values(87, 67, 8, 27, "2023-12-08");
insert into Solicitud values(88, 68, 9, 28, "2023-12-09");
insert into Solicitud values(89, 69, 10, 29, "2023-12-10");

insert into Comentario values(90, 60, 1, 20, "2023-12-02", 10, "Me gusta");
insert into Comentario values(91, 61, 2, 21, "2023-12-03", 9, "Brillante");
insert into Comentario values(92, 62, 3, 22, "2023-12-04", 10, "Excelente");
insert into Comentario values(93, 63, 4, 23, "2023-12-05", 9, "Magnifico");
insert into Comentario values(94, 64, 5, 24, "2023-12-06", 10, "Estrafalario");
insert into Comentario values(95, 65, 6, 25, "2023-12-07", 6, "Algo caro");
insert into Comentario values(96, 66, 7, 26, "2023-12-08", 9, "Muy pertinente");
insert into Comentario values(0, 67, 8, 27, "2023-12-09", 8, "Agradable");
insert into Comentario values(98, 68, 9, 28, "2023-12-10", 9, "Seguro");
insert into Comentario values(99,69, 10, 29, "2023-12-11", 10, "Maravilloso");

-- Servicio creado por el cuidador
select nickname, titulo from usuario join servicio on idusu = idcui;

-- Servicio solicitado por usuario
select nickname, titulo from usuario natural join solicitud natural join servicio;

-- Mostrar a que refugio ha donado cada usuario
select distinct U.nickname, R.descripcion from usuario U join donacion D on U.idusu = D.idusu join refugiomascotas R on D.idref = R.idRef;
-- j