use poc_debezium

EXEC sys.sp_cdc_enable_db;

select * from sys.databases where is_cdc_enabled = 1;

EXEC sys.sp_cdc_enable_table

     @source_schema = 'dbo',

     @source_name   = 'userdata',

     @role_name     = 'sa';

	 CREATE TABLE userdata (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    BirthDate DATE,
    Email NVARCHAR(255) UNIQUE,
    Salary DECIMAL(18, 2),
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    ProfileImage VARBINARY(MAX),
    Comments TEXT,
    Rating FLOAT
);

SELECT * FROM sys.tables WHERE is_tracked_by_cdc = 1;


	-- Usando um loop para inserir 1000 registros fict�cios
DECLARE @i INT = 12;
WHILE @i <= 14
BEGIN
    INSERT INTO userdata (Name, BirthDate, Email, Salary, IsActive, ProfileImage, Comments, Rating)
    VALUES (
        CONCAT('Name_', @i), -- Nome fict�cio
        DATEADD(DAY, -ABS(CHECKSUM(NEWID()) % 10000), GETDATE()), -- Data de nascimento aleat�ria nos �ltimos 10000 dias
        CONCAT('email_', @i, '@example.com'), -- Email fict�cio
        ROUND(CAST(5000 + (RAND(CHECKSUM(NEWID())) * 95000) AS DECIMAL(18, 2)), 2), -- Sal�rio aleat�rio entre 5000 e 100000
        CAST(RAND(CHECKSUM(NEWID())) * 2 AS INT), -- IsActive aleat�rio (0 ou 1)
        NULL, -- ProfileImage como NULL (pode ser ajustado para dados bin�rios)
        CONCAT('Comment_', @i), -- Coment�rio fict�cio
        CAST(RAND(CHECKSUM(NEWID())) * 5 AS FLOAT) -- Rating aleat�rio entre 0 e 5
    );
    SET @i = @i + 1;
END


	 ALTER TABLE Cliente
ADD CONSTRAINT PK_Cliente_ClienteID PRIMARY KEY (id);

ALTER TABLE Cliente
ALTER COLUMN id INT NOT NULL;





