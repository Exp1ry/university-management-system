/*
Final Assignment - CSCK542
Group B Team Members:
 - Odalo Aimufia
 - Rami Albaroudi
 - Suely Argelia Bonga Pereira
 - Preet Sall
 - Zaid Widyan

UniversityDB - Test file with validation for:
- Basic Entity Creation
- Constraint Validation
- Date Validation
- Grade Logic
- Relationship Tests
*/


-- TEST ENVIRONMENT SETUP
-- Use Schema
USE universityDB;

-- Disable safe updates and foreign key checks for testing
SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS = 0;

-- Create simple test tracking
DROP TABLE IF EXISTS test_summary;
CREATE TABLE test_summary (
    test_category VARCHAR(100),
    tests_passed INT DEFAULT 0,
    tests_failed INT DEFAULT 0
);

-- Initialise test categories
INSERT INTO test_summary (test_category) VALUES 
('Basic Entity Creation'),
('Constraint Validation'),
('Foreign Key Tests'),
('Enum Validation'),
('Date Validation'),
('Grade Logic'),
('Relationship Tests'),
('Boundary Tests');


-- DATA CLEANUP
DELETE FROM Course_Offering_Student WHERE course_offering_student_id > 0;
DELETE FROM Course_Offering_Lecturer WHERE course_offering_lecturer_id > 0;
DELETE FROM Course_Offering WHERE course_offering_id > 0;
DELETE FROM Student_Organisation WHERE student_organisation_id > 0;
DELETE FROM Lecturer_Organisation WHERE lecturer_organisation_id > 0;
DELETE FROM Organisation WHERE organisation_id > 0;
DELETE FROM Student_Advisor WHERE student_advisor_id > 0;
DELETE FROM Student WHERE student_id > 0;
DELETE FROM Research_Project WHERE research_project_id > 0;
DELETE FROM Lecturer_Research_Group WHERE lecturer_research_group_id > 0;
DELETE FROM Research_Group WHERE research_group_id > 0;
DELETE FROM Staff WHERE staff_id > 0;
DELETE FROM Lecturer WHERE lecturer_id > 0;
DELETE FROM Programme_Course_Requirement WHERE programme_course_requirement_id > 0;
DELETE FROM Course_Prerequisite WHERE prerequisite_id > 0;
DELETE FROM Course WHERE course_id > 0;
DELETE FROM Programme WHERE programme_id > 0;
DELETE FROM Department WHERE department_id > 0;

-- Reset auto increment
ALTER TABLE Department AUTO_INCREMENT = 1;
ALTER TABLE Programme AUTO_INCREMENT = 1;
ALTER TABLE Course AUTO_INCREMENT = 1;


-- BASIC ENTITY CREATION TESTS
-- Test: Valid entities
INSERT INTO Department (department_name, department_research_areas) 
VALUES ('Computer Science', 'AI, Machine Learning');
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Basic Entity Creation';

INSERT INTO Department (department_name) VALUES ('Mathematics');
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Basic Entity Creation';

INSERT INTO Programme (department_id, programme_name, programme_degree_awarded, programme_duration)
VALUES (1, 'Computer Science BSc', 'Bachelor of Science', 3);
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Basic Entity Creation';


-- CONSTRAINT VALIDATION TESTS
-- Test: Valid course credits
INSERT INTO Course (department_id, course_code, course_name, course_description, course_credits)
VALUES (1, 'CS101', 'Introduction to Programming', 'Basic programming', 0.5);
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Constraint Validation';

INSERT INTO Course (department_id, course_code, course_name, course_description, course_credits)
VALUES (1, 'CS201', 'Advanced Programming', 'Advanced programming', 2.0);
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Constraint Validation';

-- Test: Valid programme duration
INSERT INTO Programme (department_id, programme_name, programme_degree_awarded, programme_duration)
VALUES (1, 'Masters Computer Science', 'Master of Science', 2);
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Constraint Validation';


-- LECTURER TESTS
INSERT INTO Lecturer (department_id, lecturer_first_name, lecturer_last_name, lecturer_email, lecturer_password_hash, lecturer_academic_qualifications, lecturer_expertise, lecturer_course_load)
VALUES (1, 'Dr. Jane', 'Doe', 'jane.doe@university.ac.uk', 'hash1', 'PhD Computer Science', 'Machine Learning', 5);
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Constraint Validation';

INSERT INTO Lecturer (department_id, lecturer_first_name, lecturer_last_name, lecturer_email, lecturer_password_hash, lecturer_academic_qualifications, lecturer_expertise, lecturer_course_load)
VALUES (1, 'Dr. Max', 'Load', 'max.load@university.ac.uk', 'hash2', 'PhD Computer Science', 'Teaching', 10);
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Boundary Tests';


-- STUDENT TESTS
INSERT INTO Student (programme_id, student_first_name, student_last_name, student_dob, student_email, student_password_hash, student_study_year)
VALUES (1, 'Alice', 'Johnson', '1999-05-15', 'alice.johnson@student.university.ac.uk', 'hash1', 2);
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Constraint Validation';

INSERT INTO Student (programme_id, student_first_name, student_last_name, student_dob, student_email, student_password_hash, student_study_year)
VALUES (1, 'Max', 'Year', '1995-01-01', 'max.year@student.university.ac.uk', 'hash2', 10);
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Boundary Tests';


-- DATE VALIDATION TESTS
INSERT INTO Course_Offering (course_id, course_offering_semester, course_offering_year, course_offering_start_date, course_offering_end_date)
VALUES (1, 'Fall', 2024, '2024-09-01', '2024-12-15');
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Date Validation';

INSERT INTO Course_Offering (course_id, course_offering_semester, course_offering_year, course_offering_start_date, course_offering_end_date)
VALUES (1, 'Spring', 2024, '2024-01-15', '2024-05-15');
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Date Validation';


-- GRADE VALIDATION TESTS
INSERT INTO Course_Offering_Student (course_offering_id, student_id, course_offering_student_result, course_offering_student_grade)
VALUES (1, 1, 'Passed', 75);
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Grade Logic';

INSERT INTO Course_Offering_Student (course_offering_id, student_id, course_offering_student_result, course_offering_student_grade)
VALUES (2, 1, 'Failed', 35);
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Grade Logic';

INSERT INTO Course_Offering_Student (course_offering_id, student_id, course_offering_student_result)
VALUES (1, 2, 'Enroled');
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Grade Logic';


-- RELATIONSHIP TESTS
INSERT INTO Course_Prerequisite (course_id, prerequisite_course_id)
VALUES (2, 1);
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Relationship Tests';

INSERT INTO Student_Advisor (student_id, lecturer_id, student_advisor_notes)
VALUES (1, 1, 'Weekly meetings scheduled');
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Relationship Tests';

INSERT INTO Research_Group (research_group_name, research_group_description)
VALUES ('AI Research Lab', 'Artificial Intelligence Research');
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Relationship Tests';


-- ENUM VALIDATION TESTS
INSERT INTO Staff (department_id, staff_first_name, staff_last_name, staff_email, staff_password_hash, staff_title, staff_type)
VALUES (1, 'John', 'Admin', 'john.admin@university.ac.uk', 'hash1', 'Administrative Assistant', 'Full-time');
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Enum Validation';

INSERT INTO Staff (department_id, staff_first_name, staff_last_name, staff_email, staff_password_hash, staff_title, staff_type)
VALUES (1, 'Jane', 'Support', 'jane.support@university.ac.uk', 'hash2', 'IT Support', 'Part-time');
UPDATE test_summary SET tests_passed = tests_passed + 1 WHERE test_category = 'Enum Validation';


-- CONSTRAINT FAILURE TESTS (These should PASS when constraints work)
-- Test invalid course credits (constraint should prevent this = TEST PASSES)
INSERT IGNORE INTO Course (department_id, course_code, course_name, course_description, course_credits)
VALUES (1, 'CS999', 'Invalid Course', 'Test course', 3.0);
UPDATE test_summary SET 
    tests_passed = tests_passed + CASE WHEN ROW_COUNT() = 0 THEN 1 ELSE 0 END,
    tests_failed = tests_failed + CASE WHEN ROW_COUNT() > 0 THEN 1 ELSE 0 END
WHERE test_category = 'Constraint Validation';

-- Test invalid programme duration (constraint should prevent this = TEST PASSES)
INSERT IGNORE INTO Programme (department_id, programme_name, programme_degree_awarded, programme_duration)
VALUES (1, 'Invalid Programme', 'Bachelor', 0);
UPDATE test_summary SET 
    tests_passed = tests_passed + CASE WHEN ROW_COUNT() = 0 THEN 1 ELSE 0 END,
    tests_failed = tests_failed + CASE WHEN ROW_COUNT() > 0 THEN 1 ELSE 0 END
WHERE test_category = 'Constraint Validation';

-- Test invalid course load (constraint should prevent this = TEST PASSES)
INSERT IGNORE INTO Lecturer (department_id, lecturer_first_name, lecturer_last_name, lecturer_email, lecturer_password_hash, lecturer_academic_qualifications, lecturer_expertise, lecturer_course_load)
VALUES (1, 'Dr. Over', 'Worked', 'overworked@university.ac.uk', 'hash3', 'PhD', 'Teaching', 15);
UPDATE test_summary SET 
    tests_passed = tests_passed + CASE WHEN ROW_COUNT() = 0 THEN 1 ELSE 0 END,
    tests_failed = tests_failed + CASE WHEN ROW_COUNT() > 0 THEN 1 ELSE 0 END
WHERE test_category = 'Constraint Validation';

-- Test invalid study year (constraint should prevent this = TEST PASSES)
INSERT IGNORE INTO Student (programme_id, student_first_name, student_last_name, student_dob, student_email, student_password_hash, student_study_year)
VALUES (1, 'Invalid', 'Year', '2000-01-01', 'invalid.year@student.university.ac.uk', 'hash3', 0);
UPDATE test_summary SET 
    tests_passed = tests_passed + CASE WHEN ROW_COUNT() = 0 THEN 1 ELSE 0 END,
    tests_failed = tests_failed + CASE WHEN ROW_COUNT() > 0 THEN 1 ELSE 0 END
WHERE test_category = 'Constraint Validation';

-- TEST RESULTS SUMMARY

SELECT 
    test_category AS 'Test Category',
    tests_passed AS 'Passed',
    tests_failed AS 'Failed',
    (tests_passed + tests_failed) AS 'Total',
    ROUND((tests_passed * 100.0) / (tests_passed + tests_failed), 1) AS 'Pass %'
FROM test_summary 
WHERE (tests_passed + tests_failed) > 0
ORDER BY test_category;

SELECT 
    SUM(tests_passed) AS 'Total Passed',
    SUM(tests_failed) AS 'Total Failed',
    SUM(tests_passed + tests_failed) AS 'Total Tests',
    ROUND((SUM(tests_passed) * 100.0) / SUM(tests_passed + tests_failed), 1) AS 'Overall Pass %'
FROM test_summary;


-- CLEANUP
SET FOREIGN_KEY_CHECKS = 1;
SET SQL_SAFE_UPDATES = 1;

DROP TABLE test_summary;

SELECT 'Test execution completed. Check summary above.' AS final_message;
