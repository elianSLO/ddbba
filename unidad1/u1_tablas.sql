create database unidad1

use unidad1

create schema ddbba

create table ddbba.registro
(
	id int identity(1,1) primary key,
	fyh datetime default (GETDATE()),
	txt varchar(50),
	modulo varchar(10)
)

create table ddbba.persona
(
	id int identity(1,1) primary key,
	nombre varchar(30),
	apellido varchar(30),
	dni int check (dni > 999999 and dni < 99999999),
	fnac date,
	localidad varchar(30),
	tel varchar(15),
	patente char(7) null,

	constraint ck_patente check (
		patente LIKE '[A-Z][A-Z][0-9][0-9][0-9][A-Z][A-Z]'	OR	-- Para autos con patente nueva.
		patente LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9]'		OR	-- Para autos y motos patentes viejas.
		patente LIKE '[A-Z][0-9][0-9][0-9][A-Z][A-Z][A-Z]'
	),

	constraint ck_tel check (
		tel NOT LIKE '%[^0-9]%' and		-- Solo numeros.
		LEN(tel) between 10 and 14		-- 2 a 4 digitos para prefijo + 6 a 8 para numero.
		)
)
alter table ddbba.persona alter column nombre varchar(50)


create table ddbba.materia
(
	id int identity primary key,
	nombre varchar(30) not null
)

create table ddbba.curso	--  No registra historicos.
(
	idMateria int,
	codComision char(4) check ( codComision like '[1-6][369]00'), -- DIA - TURNO - 00
	constraint pk_curso primary key (idMateria,codComision),
	constraint fk_cursoMateria foreign key (idMateria) references ddbba.materia (id)
)

create table ddbba.participa
(
	idPersona int not null,
	idMateria int not null,
	codComision char(4),
	rol char(1) not null check (rol in ('A','P'))
)

create table ddbba.valoresPersona
(
	id int identity(1,1) primary key,
	nombre varchar(50),
	apellido varchar(30),
	localidad varchar(30)
)


select * from ddbba.registro
--delete from ddbba.registro where id = 3

select * from ddbba.persona
--delete from ddbba.persona where id = 6
select * from ddbba.materia

select * from ddbba.curso

select * from ddbba.participa

select * from ddbba.valoresPersona
-- delete from ddbba.valoresPersona
--exec ddbba.insertarLog '','Borrando valores genericos'
-- drop table ddbba.registro
-- drop table ddbba.participa
-- drop table ddbba.curso
-- drop table ddbba.persona
-- drop table ddbba.materia
-- drop table ddbba.valoresPersona
--exec ddbba.insertarLog '','Borrando tabla valoresPersona'

-- delete from ddbba.persona 
--exec ddbba.insertarLog '','Borrando personas'

-- delete from ddbba.valoresPersona
--exec ddbba.insertarLog '','Borrando valores genericos de personas'