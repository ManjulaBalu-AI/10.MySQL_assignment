use practice_db1;
-- 1. Basic SELECT Query
-- Fetch all columns from the students table
SELECT * 
FROM students1;

-- 2. SELECT Specific Columns
-- Fetch only first_name and email columns
SELECT first_name, email 
FROM students1;

-- 3.WHERE Clause
-- Fetch students enrolled after a specific date
SELECT first_name, last_name, enrollment_date 
FROM students1 
WHERE enrollment_date > '2024-01-01';

select * from students1;

-- 4.Logical Operators
-- Fetch students enrolled in 2024 with a specific last name
SELECT first_name, last_name, enrollment_date 
FROM students1 
WHERE enrollment_date BETWEEN '2024-01-01' AND '2024-12-31'
  AND last_name = 'Brown';

-- 5.OrderBy
-- Fetch students ordered by enrollment_date in descending order
SELECT first_name, last_name, enrollment_date 
FROM students1 
ORDER BY enrollment_date DESC;

-- 6.Limit
-- Fetch the first 5 rows
SELECT first_name, last_name 
FROM students1 
LIMIT 2;

-- 7. Aggregation with GROUP BY
-- Perform calculations on groups of rows using aggregate functions.
-- Common Aggregate Functions:
-- COUNT(): Counts the number of rows.
-- SUM(): Adds up values.
-- AVG(): Calculates the average.
-- MAX(): Finds the maximum value.
-- MIN(): Finds the minimum value.

-- Count the number of students by enrollment_date
SELECT enrollment_date, COUNT(*) AS total_students 
FROM students1 
GROUP BY enrollment_date;

ALTER TABLE students1 
ADD marks VARCHAR(3);

ALTER TABLE students1 
MODIFY marks int ;

DELETE FROM students1 WHERE student_id is null;

select * from students1;

UPDATE students1
SET marks = CASE
    WHEN student_id = 2 THEN 35
    WHEN student_id = 3 THEN 45
    WHEN student_id = 4 THEN 75
    ELSE marks
END
WHERE student_id IN (2,3, 4);

-- Count the number of students by enrollment_date
SELECT sum(marks) AS total_sumofmarks
FROM students1 ;

SELECT avg(marks) AS avergeMark
FROM students1;

SELECT min(marks) AS minMark
FROM students1 ;

SELECT max(marks) AS maxMark
FROM students1 ;

-- Combined Aggregations
SELECT 
    SUM(marks) AS total_mark,
    AVG(marks) AS average_mark,
    MIN(marks) AS min_mark,
    MAX(marks) AS max_mark
FROM students1;

SELECT 
    SUM(marks) AS total_sales,
    AVG(marks) AS average_order,
    MIN(marks) AS smallest_order,
    MAX(marks) AS largest_order
FROM students1
GROUP BY student_id;

-- HAVING Clause
-- Fetch enrollment dates with more than 5 students
SELECT enrollment_date, COUNT(*) AS total_students 
FROM students1 
GROUP BY enrollment_date 
HAVING total_students > 0;

select * from course;
select * from enrollment;
select * from students1;

INSERT INTO students1 (student_id,first_name, last_name, email, enrollment_date) 
VALUES ('1','John', 'Doe', 'john.doe@example.com', '2024-11-21');
SELECT * FROM course;
SELECT * FROM course;
SHOW CREATE TABLE enrollment;
ALTER TABLE enrollment
DROP FOREIGN KEY enrollment_ibfk_1;
ALTER TABLE enrollment
ADD CONSTRAINT enrollment_ibfk_1
FOREIGN KEY (student_id)
REFERENCES students1(student_id);
SELECT student_id, first_name, last_name
FROM students1;
INSERT INTO enrollment (student_id, course_id)
VALUES
(1, 101),-- John Doe enrolls in Mathematics
(2, 102),-- Jane Smith enrolls in Science
(3, 103);-- Alice Johnson enrolls in Computer Science
SELECT * FROM enrollment;
DELETE FROM enrollment
WHERE enrollment_id IN (4, 5, 6);
SELECT * FROM enrollment;
-- inner joins
-- Fetch students and their associated course names
SELECT students1.first_name, students1.last_name, course.course_name ,course.course_id,students1.student_id
FROM students1 
INNER JOIN enrollment ON students1.student_id = enrollment.student_id
INNER JOIN course ON enrollment.course_id = course.course_id;

-- left joins
-- Fetch all students, including those not enrolled in any course
SELECT students1.first_name, course.course_name 
FROM students1 
LEFT JOIN enrollment ON students1.student_id = enrollment.student_id 
LEFT JOIN course ON enrollment.course_id = course.course_id;

-- Right Joins
SELECT students1.student_id, first_name
FROM students1
RIGHT JOIN enrollment
ON students1.student_id = enrollment.student_id;
