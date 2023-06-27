USE [master]
GO

CREATE DATABASE [teste_ipdv]
 CONTAINMENT = NONE
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
CREATE LOGIN user_ipdv WITH PASSWORD=N'teste123', DEFAULT_DATABASE= teste_ipdv
GO
ALTER SERVER ROLE [sysadmin] ADD MEMBER user_ipdv
GO
USE teste_ipdv
GO
CREATE USER user_ipdv FOR LOGIN user_ipdv
GO
ALTER USER user_ipdv WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER user_ipdv
GO

USE teste_ipdv
GO

CREATE TABLE Departamento (
    id int IDENTITY(1,1) PRIMARY KEY,
    departamento varchar(50) NOT NULL
);

CREATE TABLE Cargo (
    id int IDENTITY(1,1) PRIMARY KEY,
    cargo varchar(50) NOT NULL
);

CREATE TABLE Usuario (
    id int IDENTITY(1,1) PRIMARY KEY,
    nome_completo varchar(50) NOT NULL,
	salario decimal(10,0) NOT NULL,
	data_nascimento date NULL,
	cidade varchar(50) NULL,
	id_cargo int NOT NULL,
	id_departamento int NOT NULL
);

ALTER TABLE dbo.Usuario  WITH NOCHECK ADD  CONSTRAINT FK_Usuario_Cargo FOREIGN KEY(id)
REFERENCES dbo.Cargo (id)
GO
ALTER TABLE dbo.Usuario
NOCHECK CONSTRAINT FK_Usuario_Cargo;  
GO
ALTER TABLE dbo.Usuario  WITH NOCHECK ADD  CONSTRAINT FK_Usuario_Departamento FOREIGN KEY(id)
REFERENCES dbo.Departamento (id)
GO
ALTER TABLE dbo.Usuario
NOCHECK CONSTRAINT FK_Usuario_Departamento;  
GO