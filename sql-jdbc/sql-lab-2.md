### Lab overview

This lab is intended to teach how to use SQL effectively. In this lab, you will learn the most commonly used SQL commands through extensive hands-on practice.  

SQL in itself is very vast and the intend of this lab is to approach learn SQL from a developer's perspective. We will explore concepts such as creating tables, indexes, views, and triggers.

### Lab prerequisites.
- Access to MCC's GitLab repository :

    https://gitlab.mccinfo.net/code-school-2020/sql-jdbc.git

    and 

    https://gitlab.mccinfo.net/code-school-2020/sql-java-jdbc.git
- SQLite Studio installed and running

### Submission requirements.
- All sections of the lab need to be completed. 
- At the end of the lab, save your editor contents to a file with an extension .sql (see a how-to demo [here](https://youtu.be/_N0ZeE7XEzQ))
- All your work will need to be checked-in into GitLab.
- Create a merge request to send your work for review (see a how-to demo [here](https://youtu.be/8mT7a6R9Jd4))
- Lab will be graded for **50 points**. You get half the points for just attempting the question. Full credit if you get it right. 

You will be creating branch from this repo for submitting SQL part of the Lab  - https://gitlab.mccinfo.net/code-school-2020/sql-jdbc.git

You will be creating branch from this repo for submitting Java part of the Lab - https://gitlab.mccinfo.net/code-school-2020/sql-java-jdbc.git
 

### Lab objectives
- [Tables and constraints](#tables-and-constraints)
- [Views](#views)
- [Indexes](#indexes)
- [Triggers](#triggers)
- [Java Excercies](#java-excercies)

## Tables and constraints (5 points)

> **Summary**: In this section of the lab, you will learn how to create new tables using the CREATE TABLE statement using various options.

<details><summary>1 . Consider the diagram below that illustrates two tables contacts and groups and the relationships.

![contacts in groups](https://cdn.sqlitetutorial.net/wp-content/uploads/2015/12/SQLite-CREATE-TABLE-example.jpg)


- The contacts table stores contact information.
- The groups table stores group information.
- The contact_groups table stores the relationship between contacts and groups.

Implement this design with the requirements below -
- The email and phone must be unique in the contacts table. 
- Each contact belongs to one or many groups, and each group can have zero or many contacts.

</summary>

<p>

```sql 
-- create contacts table with phone and email to be unique.
-- fist name and last name made to be not null since it would not make sense to create a contact with no name. 
CREATE TABLE contacts (
   contact_id INTEGER PRIMARY KEY,
   first_name TEXT NOT NULL,
   last_name TEXT NOT NULL,
   email TEXT NOT NULL UNIQUE,
   phone TEXT NOT NULL UNIQUE
);

-- creates the groups table.
-- name defined to be not null.


CREATE TABLE groups (
   group_id INTEGER PRIMARY KEY,
   name TEXT NOT NULL
);

-- create the relationship table contact_groups

CREATE TABLE contact_groups(
   contact_id INTEGER,
   group_id INTEGER,
   PRIMARY KEY (contact_id, group_id), -- primary key a combination of two columns, so that there is always one combination allowed.
   FOREIGN KEY (contact_id) 
      REFERENCES contacts (contact_id) -- foreign key mapped to contacts table.
         ON DELETE CASCADE  -- clean up this table when the contact does not exist anymore in the contacts table. 
         ON UPDATE NO ACTION, -- no action is needed when a contact in the contacts table is updated. 
   FOREIGN KEY (group_id) 
      REFERENCES groups (group_id) -- foreign key mapped to groups table.
         ON DELETE CASCADE  -- clean up this table when a group is deleted.
         ON UPDATE NO ACTION -- no action is needed when a group in the groups table is updated. 
);


```
</p>
</details>



## Views (5 points each, total 10 points)

> **Summary**: In this section of the lab, you will learn how to use the CREATE VIEW statement to create a new view in the database.

<details><summary>1. Consider the complex query below. Using this query, create a view named v_tracks. 

```

SELECT
   trackid,
   tracks.name,
   albums.Title AS album,
   media_types.Name AS media,
   genres.Name AS genres
FROM
   tracks
INNER JOIN albums ON Albums.AlbumId = tracks.AlbumId
INNER JOIN media_types ON media_types.MediaTypeId = tracks.MediaTypeId
INNER JOIN genres ON genres.GenreId = tracks.GenreId;

-- This query gets data from the tracks, albums, media_types, and genres tables.
-- As you can see adding more operations to this query makes it difficult to read and open to defects. 
-- This is where views can come to the rescue. 

```

</summary>
<p>

```sql
CREATE VIEW v_tracks 
AS 
SELECT
   trackid,
   tracks.name,
   albums.Title AS album,
   media_types.Name AS media,
   genres.Name AS genres
FROM
   tracks
INNER JOIN albums ON Albums.AlbumId = tracks.AlbumId
INNER JOIN media_types ON media_types.MediaTypeId = tracks.MediaTypeId
INNER JOIN genres ON genres.GenreId = tracks.GenreId;

SELECT * FROM v_albums; -- this would return the same results as the complex query. 
```
</p>
</details>

<details><summary>2. Using  albums and tracks tables, create a view with two columns

- **AlbumTitle**: Shows the title of the album. (From the Album table)
- **Minutes**: Total album duration in minutes i.e. sum of the duration of all the tracks in the album. (milliseconds from the tracks table)

**Hint**: Use sum(milliseconds)/60000 to get the total duration in minutes. 

</summary>
<p>

```sql
CREATE VIEW v_albums (
    AlbumTitle,
    Minutes
)
AS
    SELECT albums.title,
           SUM(milliseconds) / 60000
      FROM tracks
           INNER JOIN
           albums USING (
               AlbumId
           )
     GROUP BY AlbumTitle;

```
</p>
</details>

## Indexes ( 5 points each, total 10 points)

>**Summary**: In this section of the lab,  you will learn how to use **indexes** to query data faster, speed up sort operation, and enforce unique constraints. We will also look at **trigger**, which is a database object fired automatically when the data in a table is changed.

<details><summary>1. Create a table named **contacts** with 3 columns - **first_name, last_name and email**. None of these can be null (blank). Create an unique index that will enforce that email is unique. </summary>

<p>

``` sql

-- create the table with not nullable fields. 
CREATE TABLE contacts (
   first_name text NOT NULL,
   last_name text NOT NULL,
   email text NOT NULL
);

-- create unique index idx_contacts_email 
CREATE UNIQUE INDEX idx_contacts_email 
ON contacts (email);

-- let's test it out. 

INSERT INTO contacts (first_name, last_name, email)
VALUES('John','Doe','john.doe@mccneb.edu'); -- should insert without errors. 

INSERT INTO contacts (first_name, last_name, email)
VALUES('Johny','Doe','john.doe@mccneb.edu'); -- this should prevent us from inserting this record as the email is taken/in use. 

INSERT INTO contacts (first_name, last_name, email)
VALUES('David','Brown','david.brown@mccneb.edu'),
      ('Lisa','Smith','lisa.smith@mccneb.edu'); -- should be fine since there is not unique index contraint violation. 

```

</p>
</details>

<details><summary>2.  We saw how indexes can provide a way to define constraints. But aren't indexes supposed to help with performance? Yes, that too. Let's check it out. 

Write a query to find the contact from **contacts** table that has **email = 'lisa.smith@sqlitetutorial.net'**. 
To see if this query used the index you have defined, prefix the query with  "EXPLAIN QUERY PLAN". 

Try it out. </summary>

<p>

```sql
EXPLAIN QUERY PLAN 
SELECT
   first_name,
   last_name,
   email
FROM
   contacts
WHERE
   email = 'lisa.smith@sqlitetutorial.net';

-- Observe the detail column, to check if the index was used while executing the query. 

-- let's drop the index and then explain the query to see if anything changes. 

drop index idx_contacts_email;

-- let's run the explain query again. 

EXPLAIN QUERY PLAN 
SELECT
   first_name,
   last_name,
   email
FROM
   contacts
WHERE
   email = 'lisa.smith@sqlitetutorial.net';

-- Observe the detail column, to check if the index was used while executing the query.

```

</p>
</details>

## Triggers (5 points each, total 10)
>**Summary**: In this section of the lab, you will learn about **trigger** named database object that is executed automatically when an INSERT, UPDATE or DELETE statement is issued against the associated table.

<details><summary>1. Create a new table called **leads** to store all business leads of the company. The table will have the following columns - **id, first_name, last_name, phone, email, and source**. None of these columns can be null. 

Create a **before insert** trigger that will validate the email address before a new row is added to the table.  
</summary>

<p>

``` sql

CREATE TRIGGER validate_email_before_insert_leads 
   BEFORE INSERT ON leads
BEGIN
   SELECT
      CASE
   WHEN NEW.email NOT LIKE '%_@__%.__%' THEN
        RAISE (ABORT,'Invalid email address')
       END;
END;

-- test it with an invalid email id 
INSERT INTO leads (first_name,last_name,email,phone,source)
VALUES('John','Doe','jjj','4089009334','www');

-- test it with a valid email id 
INSERT INTO leads (first_name, last_name, email, phone, source)
VALUES ('John', 'Doe', 'john.doe@mccneb.edu', '4089009334','www');


```

</p>
</details>

<details><summary>2. Drop the trigger created in the step above. </summary>

<p>

```sql 
DROP TRIGGER validate_email_before_insert_leads;
```

</p>
</details>

## Java exercises (15 points)
>**Please use your solution to Lab 1 Java project or the instructor's solution to Lab 1(Link [here](#https://gitlab.mccinfo.net/code-school-2020/sql-java-jdbc.git)) and build on top of it for the solutions below.**

### Problem 1 : (5 points)
The relationship between tables **artists, albums, and tracks** can be described using the model diagram below -

![tracks-albums-artists](https://cdn.sqlitetutorial.net/wp-content/uploads/2018/11/artists_albums_tracks.png)

Observations based on the diagram are - 

- One track belongs to one album and one album have many tracks. The tracks table is associated with the albums table via albumid column.

- One album belongs to one artist and one artist has one or many albums. The albums table links to the artists table via artistid column.

**Write a java program that will generate a report (console log) that will list the following**
- Track id
- Track Name
- The album name that the track belongs to
- The Artist of the track. 

Below is an example of the report. 

![tracks-albums-artists-example](https://cdn.sqlitetutorial.net/wp-content/uploads/2015/12/SQLite-Inner-Join-3-tables.jpg)


**Hint**

<details>
<summary>Use only if you are stuck.</summary>

<p>

```sql
SELECT
    trackid,
    tracks.name AS track,
    albums.title AS album,
    artists.name AS artist
FROM
    tracks
    INNER JOIN albums ON albums.albumid = tracks.albumid
    INNER JOIN artists ON artists.artistid = albums.artistid;
```

</p>
</details>

### Problem 2 : (10 points)

**Develop a java solution to find out which genre is the most popular amongst the customers. Display (console log) which genre is the most popular.**

The following tables will help you derive the answer 
- customers
- invoices 
- invoice_items
- tacks
- genres 


You can use a single query using several joins to arrive at the solution. Or you can break the problem down into one or more simple queries and use java parametrized queries to chain them.

# END OF LAB2. Congratulations!! YOU MADE IT.