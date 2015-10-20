
-- Problem set week 3

-- Please add the proper SQL query to follow the instructions below

-- 1) Select ecommerce as your default database

use ecommerce;

-- 2) Show the PK, name, and quantity per unit from all products in stock
select ProductId, ProductName, QuantityPerUnit from products where UnitsInStock > 0;

-- 3) Show the number of products ever on sale in our stores
-- QUESTION: Total items or type of product?
select count(distinct(ProductId)) from order_details where Discount > 0;

-- 4) Show the number of products in stock (available right now) in our store
-- QUESTION: Total items in stock or type of product?
select sum(UnitsInStock) from products;

--  5) Show the number of products with more orders than stock
-- for all order details, join products, don't care about products with no orders, so we can
-- do a left join
-- create table products_order_quantities as
-- select products.ProductId, odId, Quantity, UnitsInStock from order_details join products on order_details.ProductId = products.ProductId;
-- select count(*) from products_order_quantities where UnitsInStock < Quantity;

-- whoops... but this is different so which is right?
select count(*) from products where UnitsOnOrder > UnitsInStock;


-- 6) List all products available in the store and order them alphabetically from a to z
-- Show just the first ten products
select * from products where UnitsInStock > 0 order by ProductName limit 10;

--  7) Create a new table in a separated schema. Call it Products2 with the same content of table products

create table Products2 as select * from products;

--  8) Delete the previously created table

drop table Products2;

--  9) Show how many customer the store has from Mexico

select count(*) from customers where Country = "Mexico";

-- 10) Show how many different countries our customers come from

select count(distinct(Country)) from customers;;

--  11) Define a new table and call it ReportAlpha
--  Show all fields from table "categories"
--  Add a field FullName as the concatenation of Category Name and Description
--  if field Picture is NULL Replace it by the 'NULL' string, and
--  if field Picture is the empty string replace it by 'No picture'
--  (hint: use the CONCAT function and the CASE WHEN statement)

create table ReportAlpha as
select CategoryId, CategoryName, Description,
  case
    when Picture is NULL then 'NULL'
    when Picture = '' then 'No Picture'
    else NULL
    end as Picture,
concat_ws(': ', CategoryName, Description) as FullName
from categories;

--  12) Show how many customers are from Mexico, Argentina, or Brazil
--  whose contact title is  aSales Representative or a Sales Manager

select count(*) from customers
  where Country in ('Mexico', 'Argentina', 'Brazil') and ContactTitle in ('Sales Representative', 'Sales Manager');

--  13) Show the number of employees that are 50 years old or more
--  as at 2014-10-06 (you will probably need to use the DATE_FORMAT function)

select count(*) from employees where DATE_FORMAT(BirthDate, '%Y-%m-%d') < DATE_FORMAT('1964-10-06', '%Y-%m-%d');

--  14) Show the age of the oldest employee of the company
--  (hint: use the YEAR and DATE_FORMAT functions)
select DATE_FORMAT(NOW(), '%Y-%m-%d') - YEAR(DATE_FORMAT(BirthDate, '%Y-%m-%d')) as age from employees order by age desc limit 1;

--  15) Show the number of products whose quantity per unit is measured in bottles
select count(*) from products where QuantityPerUnit like '%bottles';

-- 16) Show the number of customers with a Spanish or British common surname
--  (a surname that ends with -on or -ez)
select count(*) from customers where ContactName regexp '^.*(on|ez)$';

--  17) Show how many distinct countries our
--  customers with a Spanish or British common surname come from
--  (a surname that ends with -on or -ez)
select count(distinct(Country)) from customers where ContactName regexp '^.*(on|ez)$';

--  18) Show the number of products whose names do not contain the letter 'a'
--  (Note: patterns are not case sensitive)
-- QUESTION: Should the query should be case sensitive?
--   Are we looking for a count of all products without the letter 'a' or without the character 'a'?
select count(*) from products where ProductName not like '%a%';

--  19) Get the total number of single items sold ever
-- QUESTION: We want orders of one item or total items sold?
-- Orders of one item: select count(*) from order_details where Quantity = 1;
-- Total items sold:
select sum(Quantity) from order_details;

--  20) Get the id of all products sold at least one time
select distinct(ProductId) from order_details;

--  21) Is there any product that was never sold?
-- NO. PROOF:
-- select count(*) from products;
-- select count(distinct(ProductId)) from order_details;
-- both equal 77

--  22) Get the list of products sorted by category on the following way:
--  2,4,6,7,3,1,5,8
--  i.e. first all products of category 2, then all products of
--  category 4, and so on.
--  Sort alphabetically by ProductName inside one category (hint: use CASE WHEN)
-- QUESTION: WHY / HOW would you use case when? Especially if you can do:
select * from products order by CategoryId, ProductName asc;



------------------------------------------------------------------------------
