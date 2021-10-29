--CREACION DE LA BASE DE DATOS BDFacturaOveniSofSur2
------------------------------------------------------------------------------------------------------------
use master
go
------------------------------------------------------------------------------------------------------------
if exists(select name from sysdatabases where name in('BDFACTURACIONOVENI'))
	drop database BDFACTURACIONOVENI
go
------------------------------------------------------------------------------------------------------------
create database BDFACTURACIONOVENI
go
------------------------------------------------------------------------------------------------------------
use BDFACTURACIONOVENI
go
------------------------------------------------------------------------------------------------------------
-- CREACION DE TABLAS DE LA BASE DE DATOS
------------------------------------------------------------------------------------------------------------
create table TClienteNatural(
 ID_N				int not null IDENTITY(1,1)primary key,
 IdClienteNatural  AS ('N' + RIGHT('0000' + CONVERT(VARCHAR,ID_N),(4))),
 Nombres 			varchar(50)not null,
 Apellidos			varchar(50)not null,
 DNI_CN				varchar(8)not null,
 Telefono			varchar(9)not null,
 Direccion			varchar(50)not null,
 Genero				Char(1)not null
)
go
DROP table TClienteNatural
SELECT * FROM TClienteNatural
GO
------------------------------------------------------------------------------------------------------------
-- CREACION DE TABLAS DE LA BASE DE DATOS
------------------------------------------------------------------------------------------------------------
create table TClienteJuridicos( 
 ID_J	int not null identity (1,1)primary key ,
 Id_ClienteJuridico AS ('J' + RIGHT('0000' + CONVERT(VARCHAR,ID_J),(4))),
 Razon_Social		varchar(50)not null,
 RUC				varchar(8)not null,
 Telefono			varchar(9)not null,
 Direccion			varchar(50)not null,
 )
go
------------------------------------------------------------------------------------------------------------
-- CREACION DE TABLAS DE LA BASE DE DATOS
------------------------------------------------------------------------------------------------------------
create table TUsuario(
 Id_Usuario		varchar(8) not null primary key,
 Contraseña		varchar(8)not null,

 )
go


------------------------------------------------------------------------------------------------------------
create table TTrabajador(
 ID_T	int not null identity (1,1) primary key,
 Id_Trabajador AS ('T' + RIGHT('0000' + CONVERT(VARCHAR,ID_T),(4))),
 Apellidos			varchar(30)not null,
 Nombres			varchar(30)not null,
 DNI_T				varchar(8)not null,
 Rol_T				varchar(50)not null,
 Telefono			varchar(9)not null,
 Direccion			varchar(50)not null,
 Genero				Char(1)not null,
 Id_Usuario		varchar(8) not null
  foreign key 		(Id_Usuario) references TUsuario,
)
go
------------------------------------------------------------------------------------------------------------
create table TLocal(
 ID_L	int NOT NULL  identity (1,1)primary key,
 Id_Local AS ('L' + RIGHT('0000' + CONVERT(VARCHAR,ID_L),(4))),
  NombreLocal 	varchar(50)not null,
 telefono		varchar(9)not null,
 direccion 		varchar(50)not null,
 )
go
------------------------------------------------------------------------------------------------------------
create table TCategoria(
 ID_C	int NOT NULL identity (1,1)primary key,
 Id_Categoria AS ('C' + RIGHT('0000' + CONVERT(VARCHAR,ID_C),(4))),
 Nombre_Categoria	varchar(50)not null,
 Descripcion 		varchar(50)not null,
 )
go
------------------------------------------------------------------------------------------------------------
create table TProducto(
 ID_P  int NOT NULL identity (1,1)primary key,
 Id_Producto AS ('C' + RIGHT('0000' + CONVERT(VARCHAR,ID_P),(4))),
 Nombre 			varchar(50)not null,
 Descripcion		varchar(50)not null,
 Precio 			real not null check (Precio > 0),
 ID_C		int not null,
 foreign key 		(ID_C) references TCategoria,
 )
go
------------------------------------------------------------------------------------------------------------
create table TFactura(
 Id_Factura			varchar(6)not null primary key,
 Id_ClienteNatural	INT not null,
 Id_ClienteJuridico	INT not null,
 Id_Trabajador		INT NOT null,
 Id_Local			varchar(4)not null, 
 Fecha 				datetime not null, 
 SubTotal			decimal(6,2)not null,
 Total				decimal(6,2)not null,
 Descuento			decimal(6,2)not null,
 Porcentaje_Desc	decimal(6,2)not null,
 ID_N				int not null,
 ID_J				int not null,
 ID_T				int not null,
 ID_L				int not null,
 foreign key 		(ID_N) references TClienteNatural,
 foreign key 		(ID_J) references TClienteJuridicos,
 foreign key 		(ID_T) references TTrabajador,
 foreign key 		(ID_L) references TLocal
)
go
------------------------------------------------------------------------------------------------------------
create table TDetalle(
 Id_Factura			varchar(6)not null,
 ID_P				int not null, 
 Cantidad  			real not null check (Cantidad > 0),
 primary key 		(Id_Factura,ID_P),
 foreign key 		(Id_Factura) references TFactura,
 foreign key 		(ID_P) references TProducto
)
go
select * from TLocal
go
insert into TLocal values ('lc sicuani',930559546,'sicuani')