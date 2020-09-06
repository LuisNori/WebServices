create database tipocambio;
use tipocambio;
create table tipodecambio(
	tipodemoneda int not null, 
	fecha varchar(12) not null,
	valor double not null,
	primary key (tipodemoneda,fecha)
);