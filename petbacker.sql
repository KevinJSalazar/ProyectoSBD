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
	idTipoSer int not null unique check(idTipoSer > 0 AND idTipoSer < 10),
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
	idTam int not null unique check(idTam > 0 AND idTam < 1000000),
    idTipoSer int not null unique check(idTipoSer > 0 AND idTipoSer < 10),
    tamaño char(30) not null check(tamaño IN ("1-5kg", "5-10kg", "10-20kg", "20-40kg", "40+kg")),
    primary key(idTam, idTipoSer),
    foreign key(idtipoSer) references TipoServicio(idTipoSer)
);
create table TipoMascotas(
	idTipoMas int not null unique check(idTipoMas > 0 AND idTipoMas < 1000000),
    idTipoSer int not null unique check(idTipoSer > 0 AND idTipoSer < 10),
    mascota char(30) not null check(mascota IN ("Perro", "Gato", "Conejo", "Conejillo de indias", "Hurón", "Ave", "Reptil", "Otros")),
    primary key(idTipoMas, idTipoSer),
    foreign key(idtipoSer) references TipoServicio(idTipoSer)
);
create table TipoAseo(
	idTipoAseo int not null unique check(idTipoAseo > 0 AND idTipoAseo < 1000000),
    idTipoSer int not null unique check(idTipoSer > 0 AND idTipoSer < 10),
    aseo char(30) not null check(aseo IN ("básico", "completo", "ducha", "afeitado de almohadillas de patas", "recorte y relleno de uñas")),
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
	idSol int not null unique check(idSol > 0 AND idSol < 10000000),
	idSer int not null unique check(idSer > 0 AND idSer < 100000),
    idUsu int not null unique check(idUsu > 0 AND idUsu < 100000),
    idCui int not null unique check(idCui > 0 AND idCui < 100000),
	constraint diferentes1 check(idUsu != idCui),
    fecha date not null,
    primary key(idSol, idSer, idUsu, idCui),
    foreign key(idSer) references Servicio(idSer),
    foreign key(idUsu) references Usuario(idUsu),
    foreign key(idCui) references Usuario(idUsu)
);
create table Comentario(
	idSol int not null unique check(idSol > 0 AND idSol < 10000000),
	idSer int not null unique check(idSer > 0 AND idSer < 100000),
    idUsu int not null unique check(idUsu > 0 AND idUsu < 100000),
    idCui int not null unique check(idCui > 0 AND idCui < 100000),
	constraint diferentes2 check(idUsu != idCui),
    fecha date not null,
    valoracion double not null,
    contenido char(250) not null,
    primary key(idSol, idSer, idUsu, idCui),
    foreign key(idSer) references Servicio(idSer),
    foreign key(idUsu) references Usuario(idUsu),
    foreign key(idCui) references Usuario(idUsu)
);

use PetBacker;
insert into Servicio values(60, 20, "Cuidado de Mascotas", "cuidado bonito", 25.50, Ecuador, Guayas, Guayaquil, 70); 
insert into Servicio values(61, 21, "Cuidado de Mascotas", "cuidado bonito", 25.50, Ecuador, Guayas, Guayaquil, 71); 
insert into Servicio values(62, 22, "Cuidado de Mascotas", "cuidado bonito", 25.50, Ecuador, Guayas, Guayaquil, 72);
insert into Servicio values(63, 23, "Cuidado de Mascotas", "cuidado bonito", 25.50, Ecuador, Guayas, Guayaquil, 73); 
insert into Servicio values(64, 24, "Paseo de Perros", "Paseo entretenido", 30.50, Ecuador, Tarqui, Guayaquil, 74);  
insert into Servicio values(65, 25, "Paseo de Perros", "Paseo entretenido", 30.50, Ecuador, Tarqui, Guayaquil, 75);
insert into Servicio values(66, 26, "Paseo de Perros", "Paseo entretenido", 30.50, Ecuador, Tarqui, Guayaquil, 76);
insert into Servicio values(67, 27, "Alojamiento", "Alojamiento espacioso.", 35.50, Ecuador, Chimborazo, Guayaquil, 77);
insert into Servicio values(68, 28, "Alojamiento", "Alojamiento espacioso.", 35.50, Ecuador, Chimborazo, Guayaquil, 78);
insert into Servicio values(69, 29, "Alojamiento", "Alojamiento espacioso.", 35.50, Ecuador, Chimborazo, Guayaquil, 79);

insert into Solicitud values(80, 60, 1, 20, 2023/12/01);
insert into Solicitud values(81, 61, 2, 21, 2023/12/02);
insert into Solicitud values(82, 62, 3, 22, 2023/12/03);
insert into Solicitud values(83, 63, 4, 23, 2023/12/04);
insert into Solicitud values(84, 64, 5, 24, 2023/12/05);
insert into Solicitud values(85, 65, 6, 25, 2023/12/06);
insert into Solicitud values(86, 66, 7, 26, 2023/12/07);
insert into Solicitud values(87, 67, 8, 27, 2023/12/08);
insert into Solicitud values(88, 68, 9, 28, 2023/12/09);
insert into Solicitud values(89, 69, 10, 29, 2023/12/10);

insert into Comentario values(90, 60, 1, 20, 2023/12/02, 10, "Me gusta");
insert into Comentario values(91, 61, 2, 21, 2023/12/03, 10, "Me gusta");
insert into Comentario values(92, 62, 3, 22, 2023/12/04, 10, "Me gusta");
insert into Comentario values(93, 63, 4, 23, 2023/12/05, 10, "Me gusta");
insert into Comentario values(94, 64, 5, 24, 2023/12/06, 10, "Me gusta");
insert into Comentario values(95, 65, 6, 25, 2023/12/07, 10, "Me gusta");
insert into Comentario values(96, 66, 7, 26, 2023/12/08, 10, "Me gusta");
insert into Comentario values(97, 67, 8, 27, 2023/12/09, 10, "Me gusta");
insert into Comentario values(98, 68, 9, 28, 2023/12/10, 10, "Me gusta");
insert into Comentario values(99, 69, 10, 29, 2023/12/11, 10, "Me gusta");

