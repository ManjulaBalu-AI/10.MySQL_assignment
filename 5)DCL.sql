-- create a MySQL user named student_user
CREATE USER 'student_user'@'localhost'
IDENTIFIED BY 'Student@123';
-- give the user all privileges on all tables in practice_db1
GRANT ALL PRIVILEGES
ON practice_db1.*
TO 'student_user'@'localhost';
-- Instead of giving all permissions, you can give only permission to read data
GRANT SELECT
ON practice_db1.*
TO 'student_user'@'localhost';

SELECT * FROM students1;
SELECT * FROM course;
SELECT * FROM enrollment;

-- insert records into enrollment
GRANT INSERT
ON practice_db1.enrollment
TO 'student_user'@'localhost';
INSERT INTO enrollment (student_id, course_id)
VALUES (1, 102);
-- give several permissions together
GRANT SELECT, INSERT, UPDATE
ON practice_db1.enrollment
TO 'student_user'@'localhost';
-- checking what permissions the user has
SHOW GRANTS FOR 'student_user'@'localhost';
-- to remove INSERT permission
REVOKE INSERT
ON practice_db1.enrollment
FROM 'student_user'@'localhost';
-- Remove all privileges
REVOKE ALL PRIVILEGES
ON practice_db1.*
FROM 'student_user'@'localhost';
-- allow the user to read the course table
GRANT SELECT
ON practice_db1.course
TO 'student_user'@'localhost';
-- Remove the user
DROP USER 'student_user'@'localhost';
