
select * from students1;
-- Start a transaction
START TRANSACTION;

-- Insert a new student
INSERT INTO students1 (first_name, last_name, email, enrollment_date) 
VALUES ('Anna', 'Taylor', 'anna.taylor@example.com', '2024-11-16');

-- Savepoint before update
SAVEPOINT before_update;

-- Update email of a student
UPDATE students1
SET email = 'invalid.email@example.com' 
WHERE student_id = 2;

-- Rollback to the savepoint
ROLLBACK TO before_update;

-- Commit the remaining changes
COMMIT;

select * from students1;

-- 2) set constraints
SET FOREIGN_KEY_CHECKS = 0;

-- Perform operations that violate constraints
DELETE FROM students1 WHERE student_id = 1;

SET FOREIGN_KEY_CHECKS = 1;



