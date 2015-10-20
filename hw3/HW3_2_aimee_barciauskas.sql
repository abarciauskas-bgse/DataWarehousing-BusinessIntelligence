
-- Problem set week 3 number 2.

-- Please load music-store database

-- Please add the proper SQL query to follow the instructions below
-- Answer at least to 12 out of the 18 questions provided


------------------------------------------------
use musicstore;
------------------------------------------------

-- 1.Show the Number of tracks whose composer is F. Baltes
-- (Note: there can be more than one composers or each track)
select count(*) from Track where composer like '%F. Baltes%';


-- 2.Show the Number of invoices, and the number of invoices with a total amount =0
select
  (select count(*) from Invoice) as total_number_invoices,
  (select count(*) from invoice where total = 0) as invoices_with_zero_total;

-- 3.Show the Album title and Artist name of the first five Albums sorted alphabetically
select Album.Title, Artist.name as items
  from Album
  join Artist on (Album.ArtistId = Artist.ArtistId)
  order by Title limit 5;

-- 4.Show the Id, first name, and last name of the 10 first customers
-- alphabetically ordered. Include the id, first name and last name
-- of their support representative (employee)
-- QUESTION: sort by first or last name of Customer?
select Customer.CustomerId, Customer.FirstName, Customer.LastName, Employee.EmployeeId, Employee.FirstName, Employee.LastName
  from Customer
  join Employee on (Customer.SupportRepId = Employee.EmployeeId)
order by Customer.LastName limit 10;

-- 5.Show the Track name, duration, Album title, Artist name,
--  media name, and genre name for the five longest tracks
select Track.Name, Track.Milliseconds, Album.Title, Artist.Name, MediaType.Name, Genre.Name
  from Track
  join Album on (Album.AlbumId = Track.AlbumId)
  join Artist on (Album.ArtistId = Artist.ArtistId)
  join MediaType on (Track.MediaTypeId = MediaType.MediaTypeId)
  join Genre on (Track.GenreId = Genre.GenreId)
order by Milliseconds desc limit 5;


-- 6.Show Employees' first name and last name
-- together with their supervisor's first name and last name
-- Sort the result by employee last name
select Employee.FirstName, Employee.LastName, ReportsTo.FirstName, ReportsTo.LastName
  from Employee as Employee
  join Employee as ReportsTo on (Employee.ReportsTo = ReportsTo.EmployeeId)
order by Employee.LastName;


-- 7.Show the Five most expensive Albums
--  (Those with the highest cumulated unit price)
--  together with the average price per track
-- sum Invoice Line unit price
select Album.*, avg(Track.UnitPrice) as price_per_track
  from Track
  join Album on (Track.AlbumId = Album.AlbumId)
group by Album.AlbumId order by price_per_track desc limit 5;

-- 8. Show the Five most expensive Albums
--  (Those with the highest cumulated unit price)
-- but only if the average price per track is above 1
-- QUESTION: Should this result be different?
select * from
  (select Album.*, avg(Track.UnitPrice) as price_per_track
    from Track
    join Album on (Track.AlbumId = Album.AlbumId)
  group by Album.AlbumId order by price_per_track desc limit 5)
as result where price_per_track > 1;


-- 9.Show the Album Id and number of different genres
-- for those Albums with more than one genre
-- (tracks contained in an Album must be from at least two different genres)
-- Show the result sorted by the number of different genres from the most to the least eclectic



-- 10.Show the total number of Albums that you get from the previous result (hint: use a nested query)



-- 11.Show the	number of tracks that were ever in some invoice



-- 12.Show the Customer id and total amount of money billed to the five best customers
-- (Those with the highest cumulated billed imports)




-- 13.Add the customer's first name and last name to the previous result
-- (hint:use a nested query)



-- 14.Check that the total amount of money in each invoice
-- is equal to the sum of unit price x quantity
-- of its invoice lines.



-- 15.We are interested in those employees whose customers have generated
-- the highest amount of invoices
-- Show first_name, last_name, and total amount generated



-- 16.Show the following values: Average expense per customer, average expense per invoice,
-- and average invoices per customer.
-- Consider just active customers (customers that generated at least one invoice)



-- 17.We want to know the number of customers that are above the average expense level per customer. (how many?)


-- 18.We want to know who is the most purchased Artist (considering the number of purchased tracks),
-- who is the most profitable Artist (considering the total amount of money generated).
-- and who is the most listened Artist (considering purchased song minutes).
-- Show the results in 3 rows in the following format:
-- ArtistName, Concept('Total Quantity','Total Amount','Total Time (in seconds)'), Value
-- (hint:use the UNION statement)
