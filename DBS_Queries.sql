CREATE DATABASE SW_PROJEKT

USE SW_PROJEKT

CREATE TABLE Licences (
	ID_Licence int IDENTITY(1,1) PRIMARY KEY,
	Code varchar(24) NOT NULL,
	Expiration date NOT NULL,
	Capacity smallint NOT NULL,
	Banned bit NOT NULL,
	ID_Product int FOREIGN KEY REFERENCES Licences(ID_Licence)
)

CREATE TABLE Users (
	ID_User int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(25) NOT NULL,
	Surname varchar(25) NOT NULL,
	e_mail varchar(25) NOT NULL,
	pwd_hash BINARY(64) NOT NULL, --SHA2_512
	ID_Licence int FOREIGN KEY REFERENCES Licences(ID_Licence)
)

CREATE TABLE Companies(
	ID_Company int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(50) NOT NULL,
	ID_Licence int FOREIGN KEY REFERENCES Licences(ID_Licence)
)

CREATE TABLE Products (
	ID_Product int IDENTITY(1,1) PRIMARY KEY,
	ProductName varchar(25)
)

CREATE PROCEDURE dbo.AddUser
    @_Name varchar(25),
	@_Surname varchar(25),
	@_e_mail varchar(25),
	@_pwd_hash nvarchar(50),
    @responseMessage nvarchar(250) OUTPUT
AS
BEGIN
    SET NOCOUNT ON
    
    BEGIN TRY
        INSERT INTO Users (Name,Surname, e_mail,pwd_hash)
        VALUES(@_Name, @_Surname,@_e_mail,HASHBYTES('SHA2_512', @_pwd_hash))
        SET @responseMessage='Success'
    END TRY

    BEGIN CATCH
        SET @responseMessage=ERROR_MESSAGE() 
    END CATCH

END
		SELECT Name, Surname,e_mail, pwd_hash FROM Users
	@_e_mail = 'vlado@vk.ru',
	@_pwd_hash = N'motherru',
	@_Surname = 'Goncharov',
    @_Name = 'Vladimir',
    @responseMessage=@responseMessage OUTPUT
--adding user 
DECLARE @responseMessage NVARCHAR(250)
EXEC dbo.AddUser

INSERT INTO Products (ProductName)
	VALUES	('Starter'),
			('Professional'),
			('Enterprise')

