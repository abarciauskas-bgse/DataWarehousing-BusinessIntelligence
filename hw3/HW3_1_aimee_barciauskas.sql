
-- Problem set week 3

-- Please add the proper SQL query to follow the instructions below

-- 1) Select ecommerce as your default database
use ecommerce;

-- 2) Show the PK, name, and quantity per unit from all products in stock
select ProductId, ProductName, QuantityPerUnit from products where UnitsInStock > 0;

-- 3) Show the number of products ever on sale in our stores
# QUESTION: There are no order details with a Discount greater than zero,
#   am I intepreting "ever on sale" correctly?
select count(distinct(ProductId)) from order_details where Discount > 0;

-- 4) Show the number of products in stock (available right now) in our store
# QUESTION: Do we need discontinued here to understand what is available?
select count(distinct(ProductId)) from products where UnitsInStock > 0 and Discontinued = 0;

--  5) Show the number of products with more orders than stock.
select count(*) from products where UnitsOnOrder > UnitsInStock;


-- 6) List all products available in the store and order them alphabetically from a to z
-- Show just the first ten products
select * from products where UnitsInStock > 0 order by ProductName limit 10;

--  7) Create a new table in a separated schema. Call it Products2 with the same content of table products
drop database if exists ecommerce2;
create database ecommerce2;
use ecommerce2;
create table Products2 as select * from ecommerce.products limit 0;

--  8) Delete the previously created table
drop table Products2;
drop database if exists ecommerce2;
use ecommerce;

--  9) Show how many customer the store has from Mexico
select count(*) from customers where Country = "Mexico";

-- 10) Show how many different countries our customers come from
select count(distinct(Country)) from customers;

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
select DATE_FORMAT(NOW(), '%Y-%m-%d') - DATE_FORMAT(BirthDate, '%Y-%m-%d') as age
  from employees order by age desc limit 1;

--  15) Show the number of products whose quantity per unit is measured in bottles
select count(*) from products where QuantityPerUnit like '%bottles';

-- 16) Show the number of customers with a Spanish or British common surname
--  (a surname that ends with -on or -ez)
-- select count(*) from customers where (ContactName like '%on' or ContactName like '%ez');
select count(*) from customers where ContactName regexp '^.*(on|ez)$';

--  17) Show how many distinct countries our
--  customers with a Spanish or British common surname come from
--  (a surname that ends with -on or -ez)
select count(distinct(Country)) from customers where ContactName regexp '^.*(on|ez)$';

--  18) Show the number of products whose names do not contain the letter 'a'
--  (Note: patterns are not case sensitive)
select count(*) from products where ProductName not like '%a%';

--  19) Get the total number of single items sold ever
-- From email: Items sold at least once
select count(distinct(ProductId)) from order_details;

--  20) Get the id of all products sold at least one time
select distinct(ProductId) from order_details;

--  21) Is there any product that was never sold?
-- QUESTION: How should this be answered? Is a comment or sufficent?
-- NO. PROOF:
-- select count(*) from products;
-- select count(distinct(ProductId)) from order_details;
-- both equal 77

--  22) Get the list of products sorted by category on the following way:
--  2,4,6,7,3,1,5,8
--  i.e. first all products of category 2, then all products of
--  category 4, and so on.
--  Sort alphabetically by ProductName inside one category (hint: use CASE WHEN)
select CategoryId, ProductName from products order by
  case
    when CategoryId = 2 then 8
    when CategoryId = 4 then 7
    when CategoryId = 6 then 6
    when CategoryId = 7 then 5
    when CategoryId = 3 then 4
    when CategoryId = 1 then 3
    when CategoryId = 5 then 2
    when CategoryId = 8 then 1
  end desc, ProductName asc;

------------------------------------------------------------------------------
