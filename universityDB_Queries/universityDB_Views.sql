/*
Final Assignment - CSCK542

Group B Team Members:
- Odalo Aimufia
- Rami Albaroudi
- Suely Argelia Bonga Pereira
- Preet Sall
- Zaid Widyan

UniversityDB
This file contains the 5 required views for the university database management system. These views simplify queries by 
combining multi-table joins and providing clean interfaces for Python application queries.
Each view includes proper joins, filtering for active records, and formatted outputs.

Views (5 Total):
1. vw_course_enrolments - Students enroled in courses with lecturer information
2. vw_student_advisor_contacts - Student advisor contact information
3. vw_department_courses - Courses taught by lecturers in departments
4. vw_lecturer_advisees - Students advised by specific lecturers
5. vw_department_staff - Staff members by department
 */
-- Select schema for use
USE universityDB;

-- VIEW 1: Course Enrolments
-- Purpose: Find all students enroled in specific courses taught by lecturers
-- Tables: Course_Offering, Course_Offering_Lecturer, Lecturer, Course_Offering_Student, Student, Course
CREATE VIEW
    vw_course_enrolments AS
SELECT DISTINCT
    c.course_code,
    c.course_name,
    c.course_level,
    c.course_credits,
    CONCAT (l.lecturer_first_name, ' ', l.lecturer_last_name) AS lecturer_name,
    l.lecturer_email AS lecturer_email,
    CONCAT (s.student_first_name, ' ', s.student_last_name) AS student_name,
    s.student_email,
    s.student_study_year,
    co.course_offering_semester,
    co.course_offering_year,
    co.course_offering_section,
    cos.course_offering_student_result,
    cos.course_offering_student_grade
FROM
    Course_Offering co
    -- Join to get lecturer information
    JOIN Course_Offering_Lecturer col ON co.course_offering_id = col.course_offering_id
    JOIN Lecturer l ON col.lecturer_id = l.lecturer_id
    -- Join to get student enrolment information
    JOIN Course_Offering_Student cos ON co.course_offering_id = cos.course_offering_id
    JOIN Student s ON cos.student_id = s.student_id
    -- Join to get course details
    JOIN Course c ON co.course_id = c.course_id
WHERE
    -- Filter out dropped students and inactive records
    cos.course_offering_student_result != 'Dropped'
    AND l.lecturer_status = 'Active'
    AND s.student_status = 'Active'
    AND co.course_offering_status IN ('Open', 'Closed');

-- VIEW 2: Student Advisor Contacts
-- Purpose: Retrieve contact information for faculty advisors of students
-- Tables: Student_Advisor, Student, Lecturer, Department
CREATE VIEW
    vw_student_advisor_contacts AS
SELECT
    sa.student_id,
    CONCAT (s.student_first_name, ' ', s.student_last_name) AS student_name,
    s.student_email AS student_email,
    sa.lecturer_id AS advisor_id,
    CONCAT (l.lecturer_first_name, ' ', l.lecturer_last_name) AS advisor_name,
    l.lecturer_email AS advisor_email,
    d.department_name AS advisor_department,
    sa.student_advisor_notes,
    sa.student_advisor_date_created AS advisor_assignment_date
FROM
    Student_Advisor sa
    -- Join to get student information
    JOIN Student s ON sa.student_id = s.student_id
    -- Join to get lecturer (advisor) information
    JOIN Lecturer l ON sa.lecturer_id = l.lecturer_id
    -- Join to get department information
    JOIN Department d ON l.department_id = d.department_id
WHERE
    -- Only show active students and lecturers
    s.student_status = 'Active'
    AND l.lecturer_status = 'Active';

-- VIEW 3: Department Courses
-- Purpose: List all courses taught by lecturers in specific departments
-- Tables: Department, Lecturer, Course_Offering_Lecturer, Course_Offering, Course
CREATE VIEW
    vw_department_courses AS
SELECT DISTINCT
    d.department_name,
    d.department_research_areas,
    c.course_code,
    c.course_name,
    c.course_description,
    c.course_level,
    c.course_credits,
    CONCAT (l.lecturer_first_name, ' ', l.lecturer_last_name) AS lecturer_name,
    l.lecturer_expertise,
    co.course_offering_semester,
    co.course_offering_year,
    co.course_offering_section,
    co.course_offering_status
FROM
    Department d
    -- Join to get lecturers in the department
    JOIN Lecturer l ON d.department_id = l.department_id
    -- Join to get course offerings taught by lecturers
    JOIN Course_Offering_Lecturer col ON l.lecturer_id = col.lecturer_id
    JOIN Course_Offering co ON col.course_offering_id = co.course_offering_id
    -- Join to get course details
    JOIN Course c ON co.course_id = c.course_id
WHERE
    -- Only show active lecturers and open/closed courses
    l.lecturer_status = 'Active'
    AND co.course_offering_status IN ('Open', 'Closed')
ORDER BY
    d.department_name,
    c.course_code,
    co.course_offering_year DESC;

-- VIEW 4: Lecturer Advisees
-- Purpose: Retrieve names of students advised by specific lecturers
-- Tables: Student_Advisor, Lecturer, Student, Programme
CREATE VIEW
    vw_lecturer_advisees AS
SELECT
    sa.lecturer_id,
    CONCAT (l.lecturer_first_name, ' ', l.lecturer_last_name) AS lecturer_name,
    l.lecturer_email AS lecturer_email,
    l.department_id,
    sa.student_id,
    CONCAT (s.student_first_name, ' ', s.student_last_name) AS student_name,
    s.student_email,
    s.student_contact_phone,
    p.programme_name,
    p.programme_degree_awarded,
    s.student_study_year,
    p.programme_duration,
    sa.student_advisor_notes,
    sa.student_advisor_date_created AS advisory_start_date
FROM
    Student_Advisor sa
    -- Join to get lecturer information
    JOIN Lecturer l ON sa.lecturer_id = l.lecturer_id
    -- Join to get student information
    JOIN Student s ON sa.student_id = s.student_id
    -- Join to get programme information
    JOIN Programme p ON s.programme_id = p.programme_id
WHERE
    -- Only show active students and lecturers
    s.student_status = 'Active'
    AND l.lecturer_status = 'Active'
ORDER BY
    l.lecturer_last_name,
    l.lecturer_first_name,
    s.student_last_name,
    s.student_first_name;

-- VIEW 5: Department Staff
-- Purpose: Find all staff members employed in specific departments
-- Tables: Staff, Department
CREATE VIEW
    vw_department_staff AS
SELECT
    st.staff_id,
    CONCAT (st.staff_first_name, ' ', st.staff_last_name) AS staff_name,
    st.staff_email,
    st.staff_title,
    st.staff_type,
    st.staff_contract_details,
    st.staff_salary,
    st.staff_emergency_contact_name,
    st.staff_emergency_contact_phone,
    st.staff_emergency_contact_email,
    d.department_id,
    d.department_name,
    d.department_research_areas,
    st.staff_status,
    st.staff_date_created AS employment_start_date,
    st.staff_notes
FROM
    Staff st
    -- Join to get department information
    JOIN Department d ON st.department_id = d.department_id
WHERE
    -- Only show active staff members
    st.staff_status = 'Active'
ORDER BY
    d.department_name,
    st.staff_last_name,
    st.staff_first_name;