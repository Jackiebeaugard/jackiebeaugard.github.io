/* LAB 1 SQL*/

SELECT *
FROM employees;

/*Question 1*/
SELECT COUNT(*) 
FROM employees;

/*Question 2*/
SELECT COUNT(*)
FROM employees
WHERE ReportsTo IS NOT NULL;

/*Question 3*/
SELECT DISTINCT title
FROM employees;

/*Question 4*/
SELECT COUNT(DISTINCT title)
FROM employees;

/*Question 5*/
SELECT FirstName, LastName
FROM employees
WHERE title = 'IT Staff';

/*Question 6*/
SELECT FirstName, LastName
FROM employees
WHERE PostalCode LIKE '%T1H%' AND title = 'IT Staff' AND city = 'Lethbridge';

/*Question 7*/
SELECT COUNT(*)
FROM employees
WHERE HireDate >= '2003-10-17';

/*Question 8*/
SELECT COUNT(*)
FROM employees
WHERE HireDate BETWEEN '2002-01-10' AND '2003-01-01';

/*Question 9*/
SELECT FirstName, LastName, BirthDate
FROM employees
ORDER BY BirthDate DESC
LIMIT 1;

/*Question 10*/
SELECT FirstName, LastName, HireDate
FROM employees
ORDER BY HireDate
LIMIT 1;

/*Question 11*/
SELECT FirstName, LastName
FROM employees
WHERE substr(firstName, 1, 1) = substr(lastName, 1, 1);

/*Question 12*/
SELECT FirstName, LastName
FROM employees
WHERE city = 'Calgary' AND state = 'AB';

/*Question 13*/
SELECT COUNT(*)
FROM employees
WHERE phone LIKE '%(403)%';

/*Question 14*/
SELECT COUNT(*)
FROM employees A, employees B
WHERE A.EmployeeId <> B.EmployeeId AND A.Phone = B.Phone;
SELECT COUNT(*)
FROM employees
GROUP BY phone
HAVING COUNT(phone) > 1;

/*Question 15*/
SELECT B.FirstName, B.LastName
FROM employees A, employees B
WHERE (A.EmployeeId <> B.EmployeeId) AND 
(A.FirstName = 'Michael' AND A.LastName = 'Mitchell') AND 
(A.EmployeeId = B.ReportsTo);

/*Question 16*/
SELECT LENGTH(LastName) AS LengthOfString
FROM employees;

/*Question 17*/
SELECT LENGTH(LastName) AS LengthOfString, FirstName
FROM employees
ORDER BY FirstName DESC;

/*Question 18*/
SELECT FirstName, LastName
FROM employees
WHERE city = 'Edmonton' OR city = 'Lethbridge';

/*Question 19*/
SELECT avg((julianday('now') - julianday(BirthDate))/365.25) as "Average Age of an Employee" 
FROM employees;

/*Question 20*/
SELECT FirstName, LastName
FROM employees
WHERE title = 'Sales Support Agent'
LIMIT 2;
/* Part 2 Question 1 */
SELECT *
FROM artists A
INNER JOIN albums B
ON A.ArtistId = B.ArtistId;

/* Part 2 Question 2 */
SELECT Name, Title
FROM artists A
LEFT JOIN albums B
ON A.ArtistId = B.ArtistId;

/* Part 2 Question 3 */
SELECT Name
FROM artists
LEFT JOIN albums
USING (ArtistId)
WHERE AlbumId IS NULL;

/* Part 2 Question 4 */
SELECT DISTINCT A.City, A.FirstName, A.LastName
FROM employees A, employees B
WHERE A.EmployeeId <> B.EmployeeId AND A.City = B.City;

/* Part 3 Question 1 */
SELECT *,
CASE
    WHEN Country = 'USA' THEN 'Domestic Group'
    WHEN Country <> 'USA' THEN 'Foreign Group'
END AS Location
FROM customers;

/* Part 3 Question 2 */
SELECT *,
CASE
    WHEN Milliseconds < 60000 THEN 'short'
    WHEN Milliseconds >= 60000 AND Milliseconds <= 300000 THEN 'medium'
    WHEN Milliseconds > 300000 THEN 'long'
END AS TrackLength
FROM tracks;

/* Part 4 Question 1 */
INSERT INTO artists (Name)
VALUES ('Jake');

/* Part 4 Question 2 */
INSERT INTO artists (Name)
VALUES ('Jake'), ('Jackie'), ('Someone');

/* Part 4 Question 3 */
UPDATE employees
SET LastName = 'Smith'
WHERE employeeId = 3;

/* Part 4 Question 4 */
UPDATE employees
SET city = 'Toronto', state = 'ON', PostalCode = 'M5P 2N7'
WHERE employeeId = 4;

/* Part 4 Question 5 */
UPDATE employees
SET Email = LOWER(
    FirstName || '.' || LastName || '@chinookcorp.com'
);

/* Part 4 Question 5 */
UPDATE employees
SET Email = LOWER(
    FirstName || '.' || LastName || '@chinookcorp.com'
);

/* Part 4 Question 6 */
DELETE FROM artists 
WHERE Name = 'Azymuth';

/* Part 5 Question 1 */
BEGIN;
INSERT INTO artists (name) VALUES('Bud Powell');
INSERT INTO albums(Title, ArtistId) VALUES ('Silk Route', (SELECT artistid FROM artists WHERE name ='Bud Powell' ));
UPDATE artists SET name = 'Bud Powell Jr.' WHERE name = 'Bud Powell';
COMMIT;
ROLLBACK;

/* Part 5 Question 2 */
BEGIN;
DELETE FROM albums WHERE artistid = (SELECT artistid FROM artists WHERE name = 'Bud Powell Jr.');
INSERT INTO albums(title) VALUES ('just name');
DELETE FROM artists WHERE name = 'Bud Powell Jr.';
COMMIT;
ROLLBACK;