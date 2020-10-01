### Lab overview.

This lab is intended to teach how to use SQL effectively. In this lab, you will learn the most commonly used SQL commands through extensive hands-on practice.

SQL in itself is very vast and the intend of this lab is to approach learn SQL from a developer's perspective. We will explore concepts such as simple queries, sorting rows, filtering data, joining tables, grouping data, changing data, and transactions.

Perform the lab on your own. The answers are provided but are hidden so that you have a chance to solve them on your own. Do not worry if your SQL does not exactly match the SQL provided in the answer. Just like the programming languages, how you choose to form your SQL may differ from person to person.

You can view the answer by clicking the collapse icon next to the steps. Writing the query on your own is the fastest way to learn. Learning SQL by reading SQL has not proven to be effective. I hope you will enjoy the lab excercises.

### Lab prerequisites.
- Access to MCC's GitLab repository : https://gitlab.mccinfo.net/code-school-2020/sql-jdbc.git
- SQLite Studio installed and running

### Submission requirements.
- All sections of the lab need to be completed. 
- At the end of the lab, save your editor contents to a file with an extension .sql (see a how-to demo [here](https://youtu.be/_N0ZeE7XEzQ))
- All your work will need to be checked-in into GitLab.
- Create a merge request to send your work for review (see a how-to demo [here](https://youtu.be/8mT7a6R9Jd4))
- Lab will be graded for **50 points**. You get half the points for just attempting the question. Full credit if you get it right. 

### Lab objectives.
- [Asking for data](#asking-for-data)
- [Asking for data from two or more tables](#asking-for-data-from-two-or-more-tables)
- [Asking for data based on conditions](#asking-for-data-based-on-conditions)
- [Add or modify data](#add-or-modify-data)
- [Transaction](#transaction)
- [Interacting with database using JDBC API](#interacting-with-database-using-jdbc-api)

## Asking for data. (20 points)

> **Summary**: In this section of the lab, you will learn how to use the SELECT statement to query data from a single table. The ***SELECT*** statement is one of the most commonly used statements in SQL. We will use the ***EMPLOYEE*** table from the sample database.

<p>
<details><summary><b>1. Find how many employees are in the employees table.</b></summary>
<p>

```sql
select count(1) as "Number of Employees" from employees;
```

</p>
</details>
<details><summary><b>2. Find how many employees report to other employees.</b></summary>
<p>

```sql
select count(1) "Have Supervisors" from employees where ReportsTo is not null;
```

</p>
</details>
<details><summary><b>3. Find what are the distinct job titles in the employees table.</b></summary>
<p>

```sql
select distinct(Title) "distinct titles"  from employees;
```

</p>
</details>
<details><summary><b>4. Find how many (number) distinct job titles are in the employees table. </b></summary>
<p>

```sql
select count(distinct(Title)) "distinct titles"  from employees;
```

</p>
</details>
<details><summary><b>5. Find  which employees have the title of 'IT Staff'.</b></summary>
<p>

```sql
select firstname || ' ' || lastname as Name  from employees where title = 'IT Staff';
```

</p>
</details>
<details><summary><b>6. Find which employe has the title of IT Staff, lives in city Lethbridge and has the postal code T1H.</b></summary>
<p>

```sql

select FirstName || ' ' || LastName as Name  from employees where title = 'IT Staff' and City = 'Lethbridge' and PostalCode ='T1H 1Y8';
```

</p>
</details>
<details><summary><b>7. Find how many employees were hired on or after 2003-10-17.</b></summary>
<p>

```sql
select * from employees where HireDate >= date('2003-10-17 00:00:00');
```

</p>
</details>
<details><summary><b>8. Find  how many employess were hired after 2002-01-10 but before 2003-01-01.</b></summary>
<p>

```sql
select * from employees where HireDate between '2002-01-10' and '2003-01-01';
```

</p>
</details>
<details><summary><b>9. Find the youngest employee (by age).</b></summary>
<p>

```sql

select max(birthdate), firstname || ' ' || lastname as "Youngest Employee" from employees;
```

</p>
</details>

<details><summary><b>10. Find the most senior employee by years in service (use hire date).</b></summary>
<p>

```sql

select min (HireDate), firstname || ' ' || lastname as "Has served the longest" from employees;
```

</p>
</details>
<details><summary><b>
11. Find  employees that have  firstname and lastname starting with the same alphabet.</b></summary>
<p>

```sql

select firstname || ' ' || lastname  as Name from employees where  substr(firstname, 1, 1) =  substr(lastname, 1, 1);
 ```

</p>
</details>
<details><summary><b>12. Find which employees live in Calgary, AB.</b></summary>
<p>

```sql

select firstname || ' ' || lastname  as Name from employees where city = 'Calgary' and state = 'AB';
```

</p>
</details>
<details><summary><b>
13. Find how many employees have phone numbers with area code 403.</b></summary>
<p>

```sql
select firstname || ' ' || lastname  as Name from employees where Phone like '%403%';
```

</p>
</details>
<details><summary><b>14. THere are duplicates of a phone number. Find out how many rows have duplicate phone numbers. 
</b></summary>
<p>

```sql
SELECT firstname || ' ' || lastname  as Name, phone, COUNT(*) c FROM employees GROUP BY phone HAVING c > 1;
```

</p>
</details>
<details><summary><b>15. Find which employees report to Mitchell Michael.</b></summary>
<p>

```sql
select firstname || ' ' || lastname  as Name from employees where ReportsTo in (select EmployeeId from employees where firstname = 'Michael' and LastName = 'Mitchell')
```

</p>
</details>
<details><summary><b>16. Find the length of the lastname's of each employee. </b></summary>
<p>

```sql
select firstname || ' '  || lastname as name, length(lastname) from employees;
```

</p>
</details>
<details><summary><b>17. Find the length of the lastname of each employee and order the results by first names in descending order.</b></summary>
<p>

```sql
select length(lastname), firstname from employees order by firstname desc;
```

</p>
</details>
<details><summary><b>18. Find employes that live in the city of Edmonton or Lethbridge.</b></summary><p>

```sql
select firstname || ' ' || lastname  as Name from employees where city in ('Edmonton','Lethbridge');;
```

</p>
</details>
 <details><summary><b>Find out average age of the employees.</b></summary>
<p>

```sql
select avg((julianday('now') - julianday(birthdate))/365.25) as "Average Age of an Employee" from employees;
```

</p>
</details>
<details><summary><b>20. Find which employess  have the title of 'Sales Support Agent' and limit the query result to 2 rows only.</b></summary>
<p>

```sql
select firstname || ' ' || lastname  as Name  from employees where title ='Sales Support Agent' limit 2;
```

</p>
</details>

## Asking for data from two or more tables. (4 points)

> **Summary**: In this section of the lab, you will learn about various kinds of joins to query data from two or more tables. We will use the ***ARTISTS*** and ***ALBUMS*** & ***EMPLOYEES*** tables from the sample database.


<details><summary><b>1. Find all rows from both, artists and albums tables,  as long as there is a match on artistId. </b></summary>
<p>

```sql
SELECT title, name
FROM albums
INNER JOIN
artists ON artists.ArtistId = albums.ArtistId
ORDER BY Name;

or 

SELECT title,
name
FROM albums
INNER JOIN
artists using (artistid);
``` 
</p>
</details>

<details><summary><b>2. Join artists and album tables on ArtistId such that all rows from artists table are returned even if there is no match
 found in the albums table.  
</b></summary>
<p>

```sql
SELECT
Name, 
Title
FROM
artists
LEFT JOIN albums USING (ArtistId)
ORDER BY
Name;
```
</p>
</details>

<details><summary><b>3. Find artists who don't have any albums. </b>
<b>Hint</b>: The Title will be null. 
</summary>
<p>

```sql
SELECT
Name,
Title
FROM
artists
LEFT JOIN albums ON
artists.ArtistId = albums.ArtistId
WHERE Title IS NULL   
ORDER BY Name;
```
</p>
</details>

<details><summary><b>4. Find the employees located in the same city.</b>
<b>Hint</b>: You can join a table to itself.

</summary>
<p>

```sql
SELECT DISTINCT
e1.city,
e1.firstName || ' ' || e1.lastname AS fullname
FROM
employees e1
INNER JOIN employees e2 ON e2.city = e1.city 
AND (e1.firstname <> e2.firstname AND e1.lastname <> e2.lastname)
ORDER BY
e1.city;
```
</p>
</details>

## Asking for data based on conditions. (2 points)

>**Summary**: In this section of the lab, you will learn about the **CASE** expression to add the conditional logic to a query.
The **CASE** expression evaluates a list of conditions and returns an expression based on the result of the evaluation.


<details><summary><b>
1. Using <i>CUSTOMERS</i> table, arrange customers into 2 groups. If a customer lives in the USA, this customer belongs to the domestic group,
 otherwise the customer belongs to the foreign group.
</b></summary>
<p>

```sql
SELECT customerid,
firstname,
lastname,
CASE country 
WHEN 'USA' 
THEN 'Domestic' 
ELSE 'Foreign' 
END CustomerGroup
FROM 
customers
ORDER BY 
LastName,
FirstName;

```

</p>
</details>
<details><summary><b>2. Using <i>TRACKS</i> table, classify the tracks into 3 groups based on its length. 
If the duration is less a minute, the track is short; between 1 and 5 minutes, the track is medium; greater than 5 minutes, the track is long.
 otherwise the customer belongs to the foreign group.
</b></summary>
<p>

```sql
SELECT
trackid,
name,
CASE
WHEN milliseconds < 60000 THEN 'short'
WHEN milliseconds > 60000 AND milliseconds < 300000 THEN 'medium'
ELSE 'long'
END category
FROM
tracks;
``` 

</p>
</details>


## Add or modify data. (6 points)

> **Summary**: In this section of the lab, you will learn how to use INSERT, UPDATE & DELETE statement to manipulate data in a table.


<details><summary><b>1. Insert a new row into the artists table.</b></summary>
<p>

```sql
INSERT INTO artists (name)
VALUES('Bud Powell');

-- You can verify the insert operation by using the following SELECT statement. 


SELECT ArtistId, Name
FROM Artists
ORDER BY ArtistId DESC
LIMIT 1;
``` 

</p>
</details>


<details><summary><b>2. Insert 3 new rows into the artists table using a single insert statement. </b></summary>

<p>

```sql
INSERT INTO artists (name)
VALUES  ("Buddy Rich"), ("Candido"),("Charlie Byrd");

-- You can verify the insert operation by using the following SELECT statement. 

SELECT ArtistId, Name
FROM artists
ORDER BY ArtistId DESC
LIMIT 3;
``` 

</p>
</details>

<details><summary><b>3. Employee Jane got married and she wants to change her last name to her husband’s last name. 
Update Jane's last name to 'Smith' in the employees table.</b></summary>

```sql
UPDATE employees
SET lastname = 'Smith'
WHERE employeeid = 3;

-- To verify the UPDATE, you use the following statement
SELECT
    employeeid,
    firstname,
    lastname,
    title,
    email
FROM
    employees
WHERE
    employeeid = 3;

```
</p>
</details>


<details><summary><b>4. Employee Park Margaret locates in Calgary and you want to change her address, city, and state information. New address details are as follows. The city is Toronto, the state is ON and the postal code is M5P 2N7. Update his record in the employees table. 
</b></summary>

<p>

```sql
UPDATE employees
SET city = 'Toronto',
    state = 'ON',
    postalcode = 'M5P 2N7'
WHERE
    employeeid = 4;
    
-- To verify the UPDATE, you use the following statement.

SELECT
    employeeid,
    firstname,
    lastname,
    state,
    city,
    PostalCode
FROM
    employees
WHERE
    employeeid = 4;
```
</p>
</details>


<details><summary><b>5. According to a new email policy, all employee email id's need to be formatted as follows - firstname.lastname@chinookcorp.com. Update all the employee records in the employees table to match the new naming convention for email. 
</b></summary>
<p>

```sql
UPDATE employees
SET email = LOWER(
    firstname || "." || lastname || "@chinookcorp.com"
);
```
</p>
</details>

<details><summary><b>Azymuth records are not being sold anymore. Remove Azymuth from the artists table. 
</b></summary>
<p>

```sql 
delete from artists
where name = 'Azymuth' 
```
</p>
</details>

## Transaction (2 points)
>**Summary**: In this section of the lab, you will learn how to use the transaction boundaries to ensure the integrity and reliability of the data.

<details><summary><b>1. All of the below actions must commit as a single unit. i.e. the changes to the tables must be committed only if all SQL statements succeed. 
- Add 'Bud Powell' to the artists table
- Add a new Album 'Silk Route' by Bud Powel
- update the name of the Artist Bud Powell to Bud Powell Jr.
</b></summary>
<p>

```sql 
begin transaction ;
INSERT INTO artists (name) VALUES('Bud Powell');
insert into albums(Title, ArtistId) values ('Silk Route', (select artistid from artists where name ='Bud Powell' ));
update artists set name = 'Bud Powell Jr.' where name = 'Bud Powell';
commit transaction;

-- confirm records have been created

select * from albums where  artistid = (select artistid from artists where name = 'Bud Powell Jr.');
select * from artists where name = 'Bud Powell Jr.';

```
</p>
</details>

<details><summary><b>2. Create a scenario where one of the statements would fail. Then use rollback to restore the database to 
the previous state. E.g. Consider doing the below</b>

<code>
  begin transaction;
  delete from albums where artistid = (select artistid from artists where name = 'Bud Powell Jr.'); -- will succeed
  insert into albums(title) values ('just name'); -- will fail.
  delete from artists where name = 'Bud Powell Jr.'; -- will not get executed because of the above statement.
  commit transaction; -- will commit first statement only  
</code>
</summary>
<p>

```sql 
-- confirm the above using the statements below. 
select * from albums where  artistid = (select artistid from artists where name = 'Bud Powell Jr.');
select * from artists where name = 'Bud Powell Jr.';
-- since we demarcated our transaction unit with a begin statement, we can rollback the changes until that point. 
rollback;
-- confirm that the state prior to the unit of transaction that was rolled-back has been restored. 
select * from albums where  artistid = (select artistid from artists where name = 'Bud Powell Jr.');
```
</p>
</details>

## Interacting with database using JDBC API
>**Summary**: In this section of the lab, you will learn to use JDBC API to connect and interact with a database. For the lab excercises we will use the chinook sample database that we have been using so far. 


**1. Using JDBC API write a program using Java to connect to the chinook.db database.(6 points)**
  
The solution must use Gradle to build the solution.   
**Hint 1** :   
You will need to add the dependency below to your build.gradle file to download the SQLite database driver.   
 ```
 compile group:'org.xerial', name:'sqlite-jdbc', version:'3.8.11.2'
 ```
   
**Hint 2** :  
SQLite database is a file on disk. The connection URL will look like below.   

 ```java   
               String url = "jdbc:sqlite:C:/mcc/sql/sql-jdbc/chinook.db";  
                // create a connection to the database  
                conn = DriverManager.getConnection(url);  
  // This is the path to the db file on my PC - C:/mcc/sql/sql-jdbc/chinook.db
 ``` 
 
 **2. Extend the java program in the step 1 above to query and display (console log) all the records in the **artists** table. (5 points)**
 
 **3. Extend the java program in step 2 above to write a query the tracks table and find the tracks that have a unitprice > 1.50. Make the query parameterized so that 1.50 is not hard coded into the query string itself. (5 points)**
 
 **Hint**
 ```java 
     String sql = "SELECT trackid, name, unitprice, composer FROM tracks WHERE UnitPrice > ?";
```

# END OF LAB1. Congratulations!! YOU MADE IT. 
