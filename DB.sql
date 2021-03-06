CREATE DATABASE [DB_DemoSerializacion]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_DemoSerializacion', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DB_DemoSerializacion.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DB_DemoSerializacion_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\DB_DemoSerializacion_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

USE [DB_DemoSerializacion]
GO

CREATE TABLE [dbo].[Persona](
	[IdPersona] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](30) NOT NULL,
	[Apellidos] [nvarchar](30) NOT NULL,
	[Direccion] [nvarchar](50) NOT NULL,
	[Edad] [nvarchar](3) NULL,
	[FechaNacimiento] [date] NULL,
 CONSTRAINT [PK_IdPersona] PRIMARY KEY CLUSTERED 
(
	[IdPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Documento](
	[IdDocumento] [int] NOT NULL,
	[IdPersona] [int] NOT NULL,
	[NroDocumento] [varchar](12) NOT NULL,
 CONSTRAINT [PK_DocumentoPersona] PRIMARY KEY CLUSTERED 
(
	[IdDocumento] ASC,
	[IdPersona] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

insert into Persona(Nombre,Apellidos,Direccion,Edad,FechaNacimiento) values 
('Gonzalo', 'Donayre', 'San Isidro, Acasias 100', '20', '1995-06-04'),
('Iris', 'Farfán', 'Urb. Las Palmeras i9', '19', '1996-06-04'),
('Fabian', 'Peña', 'Av. San Martin 123', '50', '1965-08-14'),
('Jean', 'Cayampi', 'Camana 234', '34', '1981-06-09'),
('Lisbet', 'Sanchez', 'Av. Cutervo 156', '21', '1995-02-09'),
('Alfredo', 'Sanchez', 'Calle Chiclayo', '90', '1925-12-09')
GO

--------------------------------DOCUMENTOS
------------------ IdDocumento 1 es DNI (8)
-------------------IdDocumento 2 es partida de nacimiento (15)
-------------------IdDocumento 3 es carnet de extranjería (12)
-------------------IdDocumento 4 es RUC (11)
-------------------IdDocumento 5 es pasaporte (12)
insert into Documento(IdDocumento, IdPersona, NroDocumento) values
(1,1,'70764567'),
(4,1,'43270764567'),
(1,2,'70306763'),
(5,2,'123456789065'),
(1,3,'53578907'),
(4,3,'47653578907'),
(1,4,'74523465'),
(5,4,'512374523465'),
(3,5,'123456789123'),
(4,5,'55345678912'),
(3,6,'321987654321'),
(4,6,'11198765432')

GO

CREATE PROCEDURE [dbo].[usp_GetPersona]
	@IdPersona int
AS
BEGIN
	SET NOCOUNT ON;
	SELECT [Nombre]
      ,[Apellidos]
      ,[Direccion]
      ,[Edad]
	  ,[FechaNacimiento]
	  ,IdDocumento
	  ,NroDocumento
  FROM [dbo].[Persona] as P
  INNER JOIN dbo.Documento as D
  ON P.IdPersona = D.IdPersona
  WHERE P.IdPersona = @IdPersona
END