use unidad1

begin try
insert into ddbba.persona (nombre,apellido,dni,fnac,localidad,tel,patente)
values
('Jair','Hnatiuk',20444323,'1975-05-21','Caseros','1122335566','ABC123')--, -- Debe insertar bien
--('Else','Gundo',989993,'1999-12-03','Moron','1122335566','ABC123')	,			-- Debe fallar por DNI
--('Else','Gundo',29899933,'1999-12-03','Moron','112233556','ABC123')	,			-- Debe fallar por tel
--('Else','Gundo',19899933,'1999-12-03','Moron','1122335566','ABC13')				-- Debe fallar por patente
exec ddbba.insertarLog '','Insercion de persona'
end try
begin catch
	exec ddbba.insertarLog '','Insercion de persona fallo'
end catch


insert into ddbba.materia (nombre)
values('Bases de Datos Aplicadas'), ('Bases de Datos'),('Topicos de programaci�n'),('Analisis matematico I')
insert into ddbba.materia (nombre)
values('Probabilidad y Estadistica'),('Sistemas Operativos')
exec ddbba.insertarLog '','Insercion de materias'

INSERT INTO ddbba.valoresPersona (nombre, apellido, localidad) VALUES
('Juan', 'P�rez', 'Avellaneda'),
('Mar�a', 'Gonz�lez', 'Lan�s'),
('Lucas', 'Rodr�guez', 'Lomas de Zamora'),
('Camila', 'Fern�ndez', 'Quilmes'),
('Nicol�s', 'G�mez', 'Berazategui'),
('Sof�a', 'D�az', 'San Justo'),
('Mateo', 'Sosa', 'Mor�n'),
('Valentina', 'L�pez', 'Ramos Mej�a'),
('Tom�s', 'Mart�nez', 'Temperley'),
('Martina', 'Ram�rez', 'Florencio Varela'),
('Santiago', 'Ruiz', 'San Isidro'),
('Agustina', 'Castro', 'Villa Ballester'),
('Benjam�n', 'Torres', 'La Plata'),
('Luc�a', 'Molina', 'Tigre'),
('Joaqu�n', 'Silva', 'Jos� C. Paz');
exec ddbba.insertarLog '','Insercion de valores genericos en valoresPersona'

exec ddbba.crearPersona 100
exec ddbba.insertarLog '','Creando 100 personas'

select * from ddbba.persona

select * from ddbba.valoresPersona