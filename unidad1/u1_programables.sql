use unidad1

create or alter procedure ddbba.insertarLog 
	@modulo varchar(10),
	@txt varchar(50) 
as
begin
	if LTRIM(RTRIM(@modulo)) = ''	--LTRIM y RTRIM eliminan los espacios en blanco.
		set @modulo = 'N/A';
	insert into ddbba.registro (modulo,txt) values(@modulo, @txt)
end

create or alter procedure ddbba.crearPersona 
	@cant int
as
begin
	declare @contador int, 
			@dni int, 
			@fnac date, 
			@tel varchar(15),
			@nombre varchar(30),
			@nombres varchar(50),
			@apellido varchar(30),
			@patente char(7),
			@localidad varchar(30),
			@rand int,
			@limite int

	set @contador = 0
	set @limite = (select COUNT(*) from ddbba.valoresPersona)

	while @contador < @cant
	begin
		set @rand = cast((RAND(CHECKSUM(NEWID()))* @limite)+1 as int);	-- Obtengo el primer nombre
		set @nombre  = (select nombre from ddbba.valoresPersona where id = @rand);

		set @rand = cast((RAND(CHECKSUM(NEWID()))* @limite)+1 as int);	-- Obtengo el segundo nombre
		set @nombres = @nombre + ' ' + (select nombre from ddbba.valoresPersona where id = @rand);
		
		set @rand = cast((RAND(CHECKSUM(NEWID()))* @limite)+1 as int);
		set @apellido = (select apellido from ddbba.valoresPersona where id = @rand);

		set @rand = cast((RAND(CHECKSUM(NEWID()))* @limite)+1 as int);
		set @localidad = (select localidad from ddbba.valoresPersona where id = @rand);
 
		SET @rand = CAST(RAND(CHECKSUM(NEWID())) * 100000000 AS INT); -- Aleatorio de 8 digitos
		SET @tel = '11' + RIGHT('00000000' + CAST(@rand AS VARCHAR(8)), 8);	-- Armo el tel. con 11 + 8 digitos 
 
		SET @dni = CAST(RAND(CHECKSUM(NEWID())) * 90000000 + 10000000 AS INT);

		set @rand = CAST(RAND(CHECKSUM(NEWID())) * DATEDIFF(DAY,'1950-01-01',GETDATE()) as INT); --	Cantidad aleatoria de dias entre 1950 y hoy
		set @fnac = DATEADD(DAY,@rand,'1950-01-01');

		set @rand = CAST(RAND(CHECKSUM(NEWID()))*2 as int)
		if @rand = 0
		begin
			-- Letras A - Z  desde 65 - 90 en ASCII
			--set @rand = CAST(RAND()*(90-65+1)+65 AS INT);	-- Genero aleatorio entre 65 y 90
			SET @patente = 
				CHAR(CAST(RAND(CHECKSUM(NEWID())) * (90 - 65 + 1) + 65 AS INT)) + 
				CHAR(CAST(RAND(CHECKSUM(NEWID())) * (90 - 65 + 1) + 65 AS INT)) + 
				CHAR(CAST(RAND(CHECKSUM(NEWID())) * (90 - 65 + 1) + 65 AS INT)) + 
				CAST(CAST(RAND(CHECKSUM(NEWID())) * 10 AS INT) AS VARCHAR) + 
				CAST(CAST(RAND(CHECKSUM(NEWID())) * 10 AS INT) AS VARCHAR) + 
				CAST(CAST(RAND(CHECKSUM(NEWID())) * 10 AS INT) AS VARCHAR);
		end
		else
		begin
			SET @patente = 
				CHAR(CAST(RAND(CHECKSUM(NEWID())) * (90 - 65 + 1) + 65 AS INT)) + 
				CHAR(CAST(RAND(CHECKSUM(NEWID())) * (90 - 65 + 1) + 65 AS INT)) + 
				CAST(CAST(RAND(CHECKSUM(NEWID())) * 10 AS INT) AS VARCHAR) + 
				CAST(CAST(RAND(CHECKSUM(NEWID())) * 10 AS INT) AS VARCHAR) + 
				CAST(CAST(RAND(CHECKSUM(NEWID())) * 10 AS INT) AS VARCHAR) + 
				CHAR(CAST(RAND(CHECKSUM(NEWID())) * (90 - 65 + 1) + 65 AS INT)) + 
				CHAR(CAST(RAND(CHECKSUM(NEWID())) * (90 - 65 + 1) + 65 AS INT));
		end

		insert into ddbba.persona (nombre,apellido,dni,localidad,fnac,tel,patente)
		values ( @nombres, @apellido, @dni, @localidad, @fnac, @tel, @patente)

		set @contador = @contador + 1
	end
end

