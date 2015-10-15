drop database if exists ecommerce;

create database ecommerce;

use ecommerce;

create table if not exists categories (
  CategoryId int(11) not null,
  primary key (CategoryId),
  CategoryName varchar(15),
  Description text,
  Picture varchar(40)
);

create table if not exists suppliers (
  SupplierId int(11) not null,
  primary key (SupplierId),
  CompanyName varchar(40),
  ContactName varchar(30),
  ContactTitle varchar(30),
  Address varchar(60),
  City varchar(15),
  Region varchar(15),
  PostalCode varchar(10),
  Country varchar(15),
  Phone varchar(24),
  Fax varchar(24),
  Homepage text
);

create table if not exists products (
  ProductId int(11) not null,
  primary key (ProductId),
  ProductName varchar(40),
  SupplierId int(11),
  CategoryId int(11), 
  foreign key (SupplierId) references suppliers(SupplierId),
  foreign key (CategoryId) references categories(CategoryId),
  QuantityPerUnit varchar(20),
  UnitPrice double,
  UnitsInStock smallint,
  UnitsOnOrder smallint,
  ReorderLevel smallint,
  Discontinued tinyint
);

create table if not exists employees (
  EmployeeId int(11) not null,
  primary key (EmployeeId),
  LastName varchar(20),
  FirstName varchar(10),
  Title varchar(30),
  TitleOfCourtesy varchar(25),
  BirthDate datetime,
  HireDate datetime,
  Address varchar(60),
  City varchar(15),
  Region varchar(15),
  PostalCode varchar(10),
  Country varchar(15),
  HomePhone varchar(24),
  Extension varchar(4),
  Photo varchar(40),
  Notes text,
  ReportsTo int,
  foreign key (ReportsTo) references employees(EmployeeId)
);

create table if not exists customers (
  CustomerId char(5) not null,
  primary key (CustomerId),
  CompanyName varchar(40),
  ContactName varchar(30),
  ContactTitle varchar(30),
  Address varchar(60),
  City varchar(15),
  Region varchar(15),
  PostalCode varchar(10),
  Country varchar(15),
  Phone varchar(24),
  Fax varchar(24)
);

create table if not exists shippers (
  ShipperId int(11) not null,
  primary key (ShipperId),
  CompanyName varchar(40),
  Phone varchar(24)
);

create table if not exists orders (
  OrderId int(11) not null,
  primary key (OrderId),
  CustomerId char(5),
  EmployeeId int(11),
  foreign key (CustomerId) references customers(CustomerId),
  foreign key (EmployeeId) references employees(EmployeeId),
  OrderDate datetime,
  RequiredDate datetime,
  ShippedDate datetime,
  ShipVia int(11),
  foreign key (ShipVia) references shippers(ShipperId),
  Freight double,
  ShipName varchar(40),
  ShipAddress varchar(60),
  ShipCity varchar(15),
  ShipRegion varchar(15),
  ShipPostalCode varchar(10),
  ShipCountry varchar(15)
);

create table if not exists order_details (
  odId int(10) not null,
  primary key (odID),
  OrderId int(11),
  ProductId int(11),
  foreign key (OrderId) references orders(OrderId),
  foreign key (ProductId) references products(ProductId),
  UnitPrice double,
  Quantity smallint,
  Discount double
);
