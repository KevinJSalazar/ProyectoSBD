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
)
<<<<<<< HEAD

=======
>>>>>>> 7b86b813b219dc45c7083707113849a0b16c510d
