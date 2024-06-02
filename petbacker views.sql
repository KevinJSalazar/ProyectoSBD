use petbacker;


-- 1) Acceso rápido a datos de refugiosss 
drop view if exists DatosRefugio;
create view DatosRefugio as 
SELECT nombre, descripcion, foto, pagina_web
FROM RefugioMascotas
;

-- 2) Mostrar a que refugio ha donado cada usuario
drop view if exists RefugiosDonados;
create view RefugiosDonados as 
select distinct U.nickname Usuario, R.nombre Refugio, D.monto Monto
from usuario U join donacion D on U.idusu = D.idusu join refugiomascotas R on D.idref = R.idRef;

-- 3) Servicio creado por el cuidador
drop view if exists ServiciosCuidador;
create view ServiciosCuidador as
select nickname "Nombre Cuidador", titulo Servicio from usuario join servicio on idusu = idcui;

-- 4) Servicio solicitado por usuario
drop view if exists ServicioSolicitado;
create view ServicioSolicitado as
select U.nickname Usuario, Se.titulo "Servicio solicitado" from usuario U join solicitud S using(idUsu) join servicio Se using(idSer);

-- 5) Comentarios creados por usuarios
drop view if exists ComentariosUsuario;
create view ComentariosUsuario as
SELECT nickname Nombre, contenido Comentario
FROM Usuario join Comentario using(idUsu)
;

-- 6) Datos breves de usuarios
drop view if exists UsuariosRegistrados;
create view UsuariosRegistrados as 
SELECT nickname, email, red_social, tipo
FROM Usuario
;

-- 7) Servicios registrados
drop view if exists ServiciosRegistrados;
create view ServiciosRegistrados as
SELECT titulo, precio, pais
FROM servicio
;

-- 8) Mascotas de los usuarios
drop view if exists UsuarioMascota;
create view UsuarioMascota as
SELECT U.nickname, Tm.mascota
FROM Usuario U join Solicitud S using(idUsu) join Servicio Se using(idSer) join TipoServicio T using(idTipoSer) join TipoMascotas Tm using (idTipoSer)
;

-- 9) Cantidad de servicios solicitados por usuarios
drop view if exists CantidadServicios;
create view CantidadServicios as 
SELECT nickname, count(idUsu)
FROM Usuario join Solicitud using(idUsu)
GROUP BY nickname
;

-- 10) Información de los tipos de servicios
drop view if exists TipoSerInfo;
create view TipoSerInfo as 
SELECT fecha_inicio, fecha_fin, tipo
FROM TipoServicio
;

-- Indices

-- Indice para realizar busquedas más rápido por nombre de usuarios específicos
create index indNombre on Usuario(nickname) ;

-- Indice para encontrar servicios específicos
create index indTitulo on Servicio(titulo);

-- Indice para encontrar refugios por nombre
create index indRefNom on RefugioMascotas(nombre);

-- Indice para agilizar la búsqueda de servicios por valoración
create index indVal on Comentario(valoracion);

-- Indice para filtrar de forma rápida los refugios que reciben más donaciones
create index indMonto on Donacion(monto);


select * from TipoSerInfo;



