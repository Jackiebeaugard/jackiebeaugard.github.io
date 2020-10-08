/*LAB 2 SQL */

 

 
/* Part 1 Question 1*/
CREATE TABLE groups (
group_id int PRIMARY KEY,
name varchar(50)
);
CREATE TABLE contacts (
contact_id int PRIMARY KEY,
first_name varchar(50),
last_name varchar(50),
email varchar(100) UNIQUE,
phone varchar(50) UNIQUE
);

 

 

 
CREATE TABLE contacts_groups(
contact_id int,
group_id int,
PRIMARY KEY (contact_id, group_id),
FOREIGN KEY (contact_id)
REFERENCES contacts (contact_id)
ON DELETE CASCADE
ON UPDATE NO ACTION,

 
FOREIGN KEY (group_id)
REFERENCES groups (group_id)
ON DELETE CASCADE
ON UPDATE NO ACTION
);

 

 

 
/* Part 2 Question 1*/
CREATE VIEW v_tracks AS
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

 

 

 
/* Part 2 Question 2*/
CREATE VIEW album_tracks AS
SELECT
albums.Title,
tracks.Milliseconds AS time
FROM
albums
INNER JOIN tracks ON tracks.AlbumId = albums.AlbumId;

 
SELECT * FROM album_tracks;

 
SELECT SUM(time)/60000 AS album_duration_minutes
FROM album_tracks;

 

 

 

 
/* Part 3 Question 1*/
CREATE TABLE contacts (
first_name text NOT NULL,
last_name text NOT NULL,
email text NOT NULL
);
CREATE UNIQUE INDEX idx_contacts_email
ON contacts (email);

 
INSERT INTO contacts (first_name, last_name, email)
VALUES('John','Doe','john.doe@mccneb.edu'); -- should insert without errors.

 
INSERT INTO contacts (first_name, last_name, email)
VALUES('Johny','Doe','john.doe@mccneb.edu'); -- this should prevent us from inserting this record as the email is taken/in use.

 
INSERT INTO contacts (first_name, last_name, email)
VALUES('David','Brown','david.brown@mccneb.edu'),
('Lisa','Smith','lisa.smith@mccneb.edu');

 

 

 
/* Part 3 Question 2*/
EXPLAIN QUERY PLAN
SELECT email
FROM contacts
WHERE email = 'lisa.smith@mccneb.edu';

 

 

 
/* Part 4 Question 1*/
CREATE TABLE leads (
id int,
first_name text NOT NULL,
last_name text NOT NULL,
phone text NOT NULL,
email text NOT NULL,
source text NOT NULL
);
-- validate email
CREATE TRIGGER validate_email
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

 

 
/* Part 4 Question 2*/
DROP TRIGGER validate_email;