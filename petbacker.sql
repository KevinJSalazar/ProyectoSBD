-- drop database PetBacker;
create database PetBacker;
use PetBacker;
create table RefugioMascotas(
	idRef int not null auto_increment,
    email char(50) not null unique,
    nombre char(100) not null unique,
    descripcion char(250) not null,
    foto longblob,
    pagina_web char(50) not null,
    direccion char(50) not null,
    estado char(30) not null,
    ciudad char(30) not null,
    telefono char(10) not null,
    telefonoOp char(10),
    primary key(idRef)
);
create table Usuario(
	idUsu int not null auto_increment,
    email char(50) not null unique,
    nickname char(250) not null unique,
    contraseña char(20) not null,
    telefono char(10),
    foto longblob,
    red_social char(50) unique,
    vales int not null default 0,
    tarjeta char(20),
    tipo char(10) check(tipo = "Cuidador" OR tipo = "Default"),
    primary key(idUsu)
);
create table Donacion(
	idDon int not null auto_increment,
	idRef int not null,
	idUsu int not null,
	fecha date not null,
    monto double not null,
    cupon double not null,
    primary key(idDon, idRef, idUsu),
    foreign key(idRef) references RefugioMascotas(idRef),
    foreign key(idUsu) references Usuario(idUsu)
);
create table TipoServicio(
	idTipoSer int not null auto_increment,
    lugar_recogida char(250) not null,
    fecha_inicio date not null,
    numero_dias int not null check(numero_dias >= 1 AND numero_dias <= 365),
	fecha_fin date not null,
    constraint fecha_posible check(datediff(fecha_fin, fecha_inicio) >= 0),
    detalles char(250),
    raza char(100) not null,
    numero_mascotas int not null check(numero_mascotas >= 1 AND numero_mascotas <= 8),
    tipo char(50) not null check(tipo IN ("Alojamiento", "Paseo de Perros", "Cuidado de Mascotas", "Guardería", "Taxi de Mascotas", "Peluquería", "Adiestramiento de mascota")),
    servicio_recogida boolean,
	numero_paseos_diario int check(numero_paseos_diario >= 0 AND numero_paseos_diario <= 3),
    primary key(idTipoSer)
);
create table Tamaño(
	idTam int not null auto_increment,
    idTipoSer int not null,
    tamaño char(30) not null check(tamaño IN ("1-5kg", "5-10kg", "10-20kg", "20-40kg", "40+kg")),
    primary key(idTam, idTipoSer),
    foreign key(idtipoSer) references TipoServicio(idTipoSer)
);
create table TipoMascotas(
	idTipoMas int not null auto_increment,
    idTipoSer int not null,
    mascota char(30) not null check(mascota IN ("Perro", "Gato", "Conejo", "Conejillo de indias", "Hurón", "Ave", "Reptil", "Otros")),
    primary key(idTipoMas, idTipoSer),
    foreign key(idtipoSer) references TipoServicio(idTipoSer)
);
create table TipoAseo(
	idTipoAseo int not null auto_increment,
    idTipoSer int not null,
    aseo char(50) not null check(aseo IN ("básico", "completo", "ducha", "afeitado de almohadillas de patas", "recorte y relleno de uñas")),
    -- constraint servicioAseo check(idTipoSer IN (select idTipoSer from TipoServicio t where t.idTipoSer IN (idTipoSer))),
    primary key(idTipoAseo, idTipoSer),
    foreign key(idtipoSer) references TipoServicio(idTipoSer)
);
create table Servicio(
	idSer int not null auto_increment,
    idCui int not null,
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
	idSol int not null auto_increment,
	idSer int not null,
    idUsu int not null,
    idCui int not null,
    constraint diferentes1 check(idUsu != idCui),
    fecha date not null,
    primary key(idSol, idSer, idUsu, idCui),
    foreign key(idSer) references Servicio(idSer),
    foreign key(idUsu) references Usuario(idUsu),
    foreign key(idCui) references Usuario(idUsu)
);
create table Comentario(
	idSol int not null auto_increment unique,
	idSer int not null,
    idUsu int not null,
    idCui int not null,
    constraint diferentes2 check(idUsu != idCui),
    fecha date not null,
    valoracion double not null check(valoracion >= 1 AND valoracion <= 8),
    contenido char(250) not null,
    primary key(idSol, idSer, idUsu, idCui),
    foreign key(idSer) references Servicio(idSer),
    foreign key(idUsu) references Usuario(idUsu),
    foreign key(idCui) references Usuario(idUsu)
);
