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
	dni int,
	nombre varchar(50),
	apellido varchar(50),
	localidad varchar(50),
	fnac date,
	tel varchar(50),
	patente varchar(10)
)
alter table ddbba.persona alter column dni int

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
add idMat int not null
alter table ddbba.curso
add idProf int not null
alter table ddbba.curso
add constraint pk_curso primary key (id,codComision)
alter table ddbba.curso
add constraint fk_materia foreign key (idMat) references ddbba.materia(id)
alter table ddbba.curso
add constraint fk_prof foreign key (idProf) references ddbba.persona(id)

create table ddbba.cursa
(
	idAlumno int not null,
	idCurso int not null,
	codComision int not null,
	constraint fk_alumno foreign key (idAlumno) references ddbba.persona (id),
	constraint fk_curso foreign key (idCurso,codComision) references ddbba.curso(id,codComision)
)

insert into ddbba.persona (nombre) 
values ('Jair')
select * from ddbba.persona
select * from ddbba.materia
insert into ddbba.materia (nombre)
values ('DDBBA'),('Analisis')

insert into ddbba.curso (id,codComision,idMat,idProf)
values (2,5600,1,14)
values (1,5300,1,14)

select * from ddbba.curso

create or alter trigger ddbba.noAlumnoProfe on ddbba.cursa