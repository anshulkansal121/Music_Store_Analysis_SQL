-- MUSIC STORE DATA ANALYSIS 
-- QUESTION SET 1 - EASY
USE music_store;


-- Q1: Who is the senior most employee based on job title? 
-- Approach: Job Titles and levels are directly relateable
SELECT title, firstName, lastName
FROM Employee
ORDER BY levels DESC
LIMIT 1;


-- Q2: Which countries have the most Invoices? 
SELECT billingCountry, COUNT(invoiceId) AS "Number of Invoices"
FROM invoice
GROUP BY billingCountry
ORDER BY 2 DESC;

-- Q3: What are top 3 values of total invoice? 
SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;


-- Q4: Which city has the best customers? We would like to throw a promotional Music 
-- Festival in the city we made the most money. Write a query that returns one city that 
-- has the highest sum of invoice totals. Return both the city name & sum of all invoice 
-- totals
SELECT billingCity, SUM(total) AS "Invoice Total"
FROM invoice
GROUP BY billingCity
ORDER BY 2 DESC
LIMIT 1; 

-- Q5: Who is the best customer? The customer who has spent the most money will be 
-- declared the best customer. Write a query that returns the person who has spent the 
-- most money 
SELECT c.customerId, CONCAT(c.firstName," ", c.lastName) AS Name, SUM(total)
FROM customer c 
JOIN invoice i ON c.customerId = i.customerId
GROUP BY c.customerId
ORDER BY 3 DESC
LIMIT 1;


-- QUESTION SET 2 - MODERATE
-- Q1: Write query to return the email, first name, last name, of all Rock Music 
-- listeners. Return your list ordered alphabetically by email starting with A 
SELECT DISTINCT c.email, c.firstName, c.lastName
FROM customer c 
JOIN invoice i ON c.customerId = i.customerId 
JOIN invoiceline il ON i.invoiceId = il.invoiceId
WHERE il.trackId IN (
	SELECT trackId FROM track t 
	JOIN genre g ON t.genreId = g.genreId 
    WHERE g.name = 'Rock')
ORDER BY email;


-- Q2: Let's invite the artists who have written the most rock music in our dataset. Write a 
-- query that returns the Artist name and total track count of the top 10 rock bands 
SELECT a.artistId, a.name, COUNT(t.name) as "Number of Songs"
FROM artist a JOIN album ab ON  ab.artistId = a.artistId
JOIN track t on  t.albumId = ab.albumId
WHERE trackId IN (
	SELECT trackId FROM track 
	JOIN genre ON track.genreId = genre.genreId 
    WHERE genre.name ='ROCK')
GROUP BY a.artistId
ORDER BY 3 DESC
LIMIT 10;

-- Q3: Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the 
-- longest songs listed first  
SELECT t.name, t.milliseconds
FROM track t
WHERE t.milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY 2 DESC;


-- QUESTION SET 3 ADVANCE
-- Q1: Find how much amount spent by each customer on artists? Write a query to return 
-- customer name, artist name and total spent 
-- Breking down the problem : Finding each artist's best selling song

-- SELECT 
-- 	a.name AS "Artist Name", 
-- 	t.name AS "Song Name", 
-- 	SUM(il.unitPrice * il.quantity) AS "Total Sales"
-- FROM artist a 
-- JOIN album ab ON a.artistId = ab.artistId
-- JOIN track t ON t.albumId = ab.albumId
-- JOIN invoiceline il ON t.trackId = il.trackId
-- GROUP BY 1,2
-- ORDER BY 3 DESC;


SELECT
	c.customerId AS "ID",
	CONCAT(c.firstName, " ",c.lastName) AS "Customer Name",
	a.name AS "Artist Name", 
	SUM(il.unitPrice * il.quantity) AS "Amount Spent"
FROM artist a 
JOIN album ab ON a.artistId = ab.artistId
JOIN track t ON t.albumId = ab.albumId
JOIN invoiceline il ON t.trackId = il.trackId
JOIN invoice i ON i.invoiceId = il.invoiceId 
JOIN customer c ON c.customerId = i.customerId
GROUP BY 1,2,3
ORDER BY 4 DESC;

-- Q2: We want to find out the most popular music Genre for each country. We determine the 
-- most popular genre as the genre with the highest amount of purchases. Write a query 
-- that returns each country along with the top Genre. For countries where the maximum 
-- number of purchases is shared return all Genres 
-- Breaking down the Problem: Total sales per country and then link it to genre
WITH popular_genre AS(
	SELECT billingCountry, g.name AS "Genre_Name", sum(il.quantity * il.unitPrice) as "Total_Sales",
    DENSE_RANK() OVER(PARTITION BY billingCountry ORDER BY sum(il.quantity * il.unitPrice) DESC) AS "RANKING"
	FROM invoice i 
	JOIN invoiceline il ON  i.invoiceId = il.invoiceId
	JOIN track t ON t.trackId = il.trackId
	JOIN genre g ON t.genreId = g.genreId 
	GROUP BY 1,2
)
SELECT billingCountry, Genre_Name, Total_Sales
FROM popular_genre WHERE RANKING = 1;

-- Q3: Write a query that determines the customer that has spent the most on music for each 
-- country. Write a query that returns the country along with the top customer and how 
-- much they spent. For countries where the top amount spent is shared, provide all 
-- customers who spent this amount

-- first find the most spent on music for each country and second filter the data for respective customers.
WITH Customer_Country AS (
	SELECT CONCAT(c.firstName," ",c.lastName) AS Name, billingCountry as Country, SUM(total) AS "Total_Spend",
	DENSE_RANK() OVER(PARTITION BY billingCountry ORDER BY SUM(Total) DESC) AS Ranking
	FROM customer c JOIN invoice i ON c.customerId = i.customerId
	GROUP BY 1,2
	ORDER BY 3 DESC
)
SELECT Name, Country, Total_Spend 
FROM Customer_Country 
WHERE Ranking=1 
ORDER BY 2;