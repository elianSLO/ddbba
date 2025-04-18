create database unidad1

use unidad1
create schema ddbba

create table ddbba.registro 
(
	id int identity(1,1) primary key,
	fyh datetime,
	texto varchar(50),
	modulo varchar(10),
)

select *from ddbba.registro


create or alter procedure ddbba.insertarLog
	@modulo varchar(10),
	@texto	varchar(50)
as
begin
	if(@modulo = '' or @modulo is NULL) 
		set @modulo = 'N/A'

	insert into ddbba.registro (modulo,texto,fyh)
	values (@modulo,@texto,GETDATE())
end

create table ddbba.persona
(
	id int identity primary key,
	dni int not null,
	nombre varchar(50),
	apellido varchar(50),
	localidad varchar(50),
	fnac date,
	tel varchar(50),
	patente varchar(10)
)

create table ddbba.materia
(
	id int identity(1,1) primary key,
	nombre varchar(50)
)

create table ddbba.curso
(
	id int not null,
	codComision int not null
)
alter table ddbba.curso
add constraint pk_curso primary key (id,codComision)