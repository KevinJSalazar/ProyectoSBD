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