/*
Final Assignment - CSCK542

Group B Team Members:
- Odalo Aimufia
- Rami Albaroudi
- Suely Argelia Bonga Pereira
- Preet Sall
- Zaid Widyan

UniversityDB
This SQL file defines the relational schema/Data Definition Language (DDL) for a university record management system. The design is normalised to 3NF.

Core Entity Tables (7 tables):
- Department - Base academic unit structure
- Programme - Degree programmes offered by departments
- Course - Course details and information
- Lecturer - Academic personnel details
- Staff - Non-academic personnel details
- Student - Student records with programme enrolment
- Research_Group - Research group information
Relationship/Junction Tables (9 tables):
- Course_Prerequisite - Course prerequisite relationships
- Programme_Course_Requirement - Maps courses to programme requirements
- Student_Advisor - Faculty-advisor assignments (one-to-one)
- Lecturer_Research_Group - Lecturer research group memberships
- Research_Project - Research activities and outcomes
- Organisation - University committees, clubs, and societies
- Student_Organisation - Student organisation memberships
- Lecturer_Organisation - Lecturer organisation memberships
- Course_Offering - Specific course instances
- Course_Offering_Lecturer - Lecturer assignments to course offerings
- Course_Offering_Student - Student enrolments in course offerings

Key Features:
- Deletion of records is restricted, using status fields to mark inactive records
- All tables prevent duplicate records through primary keys and unique constraints
- All tables include audit fields (date created, date modified) for record tracking
- Most fields are required/NOT NULL to ensure data integrity
- Entity tables support hashed password storage for authentication
- CHECK constraints validate data ranges and relationships
- This schema is designed for MySQL 8.0.16+ 
 */
-- Create schema and select it for use
CREATE SCHEMA IF NOT EXISTS universityDB;

USE universityDB;

-- Department table
CREATE TABLE
    Department (
        department_id INT PRIMARY KEY AUTO_INCREMENT,
        department_name VARCHAR(100) UNIQUE NOT NULL,
        department_research_areas TEXT,
        department_notes TEXT,
        department_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        department_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Programme table
CREATE TABLE
    Programme (
        programme_id INT PRIMARY KEY AUTO_INCREMENT,
        department_id INT NOT NULL, -- FK to Department
        programme_name VARCHAR(100) UNIQUE NOT NULL,
        programme_degree_awarded VARCHAR(50) NOT NULL,
        programme_duration INT NOT NULL CHECK (programme_duration > 0),
        programme_notes TEXT,
        FOREIGN KEY (department_id) REFERENCES Department (department_id) ON DELETE RESTRICT,
        programme_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        programme_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Course table
CREATE TABLE
    Course (
        course_id INT PRIMARY KEY AUTO_INCREMENT,
        department_id INT NOT NULL, -- FK to Department
        course_code VARCHAR(10) UNIQUE NOT NULL,
        course_name VARCHAR(100) UNIQUE NOT NULL,
        course_description TEXT NOT NULL,
        course_level ENUM (
            'Preparatory',
            'Undergraduate',
            'Graduate',
            'Doctoral',
            'Continuing Education',
            'Other'
        ) NOT NULL DEFAULT 'Other',
        course_credits DECIMAL(3, 1) NOT NULL CHECK (course_credits BETWEEN 0.5 AND 2.0) DEFAULT 0.5,
        course_materials TEXT,
        course_notes TEXT,
        FOREIGN KEY (department_id) REFERENCES Department (department_id) ON DELETE RESTRICT,
        course_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        course_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Course Prerequisites relationship table
CREATE TABLE
    Course_Prerequisite (
        prerequisite_id INT PRIMARY KEY AUTO_INCREMENT,
        course_id INT NOT NULL, -- FK to Course
        prerequisite_course_id INT NOT NULL,
        UNIQUE KEY (course_id, prerequisite_course_id),
        FOREIGN KEY (course_id) REFERENCES Course (course_id),
        FOREIGN KEY (prerequisite_course_id) REFERENCES Course (course_id)
    );

-- Programme Course requirements relationship table
CREATE TABLE
    Programme_Course_Requirement (
        programme_course_requirement_id INT PRIMARY KEY AUTO_INCREMENT,
        programme_id INT NOT NULL, -- FK to Programme
        course_id INT NOT NULL, -- FK to Course
        programme_course_requirement_type ENUM ('Core', 'Elective', 'Optional') NOT NULL DEFAULT 'Core',
        programme_course_requirement_notes TEXT,
        UNIQUE (programme_id, course_id),
        FOREIGN KEY (programme_id) REFERENCES Programme (programme_id) ON DELETE RESTRICT,
        FOREIGN KEY (course_id) REFERENCES Course (course_id) ON DELETE RESTRICT,
        requirement_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        requirement_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Lecturer table
CREATE TABLE
    Lecturer (
        lecturer_id INT PRIMARY KEY AUTO_INCREMENT,
        department_id INT NOT NULL, -- FK to Department
        lecturer_first_name VARCHAR(50) NOT NULL,
        lecturer_last_name VARCHAR(50) NOT NULL,
        lecturer_email VARCHAR(255) UNIQUE NOT NULL,
        lecturer_password_hash VARCHAR(255) NOT NULL,
        lecturer_academic_qualifications TEXT NOT NULL,
        lecturer_expertise TEXT NOT NULL,
        lecturer_course_load INT CHECK (lecturer_course_load BETWEEN 0 AND 10),
        lecturer_research_interests TEXT,
        lecturer_publications TEXT,
        lecturer_status ENUM ('Active', 'On Leave', 'Suspended', 'Inactive') NOT NULL DEFAULT 'Active',
        lecturer_notes TEXT,
        FOREIGN KEY (department_id) REFERENCES Department (department_id) ON DELETE RESTRICT,
        lecturer_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        lecturer_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Research Group table
CREATE TABLE
    Research_Group (
        research_group_id INT PRIMARY KEY AUTO_INCREMENT,
        research_group_name VARCHAR(100) UNIQUE NOT NULL,
        research_group_description TEXT,
        research_group_status ENUM ('Active', 'Inactive') NOT NULL DEFAULT 'Active',
        research_group_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        research_group_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Lecturer Research Group relationship table
CREATE TABLE
    Lecturer_Research_Group (
        lecturer_research_group_id INT PRIMARY KEY AUTO_INCREMENT,
        lecturer_id INT NOT NULL, -- FK to Lecturer
        research_group_id INT NOT NULL, -- FK to Research Group
        lecturer_research_group_role VARCHAR(50) NOT NULL DEFAULT 'Member',
        UNIQUE (lecturer_id, research_group_id),
        FOREIGN KEY (lecturer_id) REFERENCES Lecturer (lecturer_id) ON DELETE RESTRICT,
        FOREIGN KEY (research_group_id) REFERENCES Research_Group (research_group_id) ON DELETE RESTRICT,
        lecturer_research_group_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        lecturer_research_group_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Research Project table
CREATE TABLE
    Research_Project (
        research_project_id INT PRIMARY KEY AUTO_INCREMENT,
        research_group_id INT NOT NULL, -- FK to Research_Group
        department_id INT NOT NULL, -- FK to Department
        research_project_title VARCHAR(255) UNIQUE NOT NULL,
        research_project_funding TEXT,
        research_project_publications TEXT,
        research_project_outcomes TEXT,
        research_project_status ENUM ('Active', 'Completed', 'Discontinued', 'Planned') NOT NULL DEFAULT 'Active',
        research_project_notes TEXT,
        UNIQUE (research_project_title, research_group_id),
        FOREIGN KEY (research_group_id) REFERENCES Research_Group (research_group_id) ON DELETE RESTRICT,
        FOREIGN KEY (department_id) REFERENCES Department (department_id) ON DELETE RESTRICT,
        research_project_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        research_project_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Non-Academic Staff table
CREATE TABLE
    Staff (
        staff_id INT PRIMARY KEY AUTO_INCREMENT,
        department_id INT NOT NULL, -- FK to Department
        staff_first_name VARCHAR(50) NOT NULL,
        staff_last_name VARCHAR(50) NOT NULL,
        staff_email VARCHAR(255) UNIQUE NOT NULL,
        staff_password_hash VARCHAR(255) NOT NULL,
        staff_title VARCHAR(100) NOT NULL,
        staff_type ENUM ('Full-time', 'Part-time', 'Contract', 'Temporary') NOT NULL,
        staff_contract_details TEXT,
        staff_salary DECIMAL(10, 2),
        staff_emergency_contact_name VARCHAR(100),
        staff_emergency_contact_phone VARCHAR(50),
        staff_emergency_contact_email VARCHAR(255),
        staff_status ENUM ('Active', 'On Leave', 'Suspended', 'Inactive') NOT NULL DEFAULT 'Active',
        staff_notes TEXT,
        FOREIGN KEY (department_id) REFERENCES Department (department_id) ON DELETE RESTRICT,
        staff_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        staff_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Student table
CREATE TABLE
    Student (
        student_id INT PRIMARY KEY AUTO_INCREMENT,
        programme_id INT NOT NULL, -- FK to Programme
        student_first_name VARCHAR(50) NOT NULL,
        student_last_name VARCHAR(50) NOT NULL,
        student_dob DATE NOT NULL,
        student_email VARCHAR(255) UNIQUE NOT NULL,
        student_password_hash VARCHAR(255) NOT NULL,
        student_contact_phone VARCHAR(20),
        student_address TEXT,
        student_study_year INT NOT NULL CHECK (student_study_year BETWEEN 1 AND 10),
        student_disciplinary_records TEXT,
        student_status ENUM (
            'Active',
            'Suspended',
            'Graduated',
            'Withdrawn',
            'Exchange Completed'
        ) NOT NULL DEFAULT 'Active',
        student_notes TEXT,
        FOREIGN KEY (programme_id) REFERENCES Programme (programme_id) ON DELETE RESTRICT,
        student_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        student_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Student Advisor relationship table
CREATE TABLE
    Student_Advisor (
        student_advisor_id INT PRIMARY KEY AUTO_INCREMENT,
        student_id INT NOT NULL UNIQUE, -- FK to Student
        lecturer_id INT NOT NULL, -- FK to Lecturer (Adivsor)
        student_advisor_notes TEXT,
        FOREIGN KEY (student_id) REFERENCES Student (student_id) ON DELETE RESTRICT,
        FOREIGN KEY (lecturer_id) REFERENCES Lecturer (lecturer_id) ON DELETE RESTRICT,
        student_advisor_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        student_advisor_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Organisation table
CREATE TABLE
    Organisation (
        organisation_id INT PRIMARY KEY AUTO_INCREMENT,
        organisation_name VARCHAR(100) UNIQUE NOT NULL,
        organisation_description TEXT NOT NULL,
        organisation_status ENUM ('Active', 'Inactive', 'Suspended') NOT NULL DEFAULT 'Active',
        organisation_membership_type ENUM ('Student', 'Lecturer', 'Staff', 'Mixed') NOT NULL DEFAULT 'Mixed',
        organisation_type ENUM ('Committee', 'Club', 'Interest Group', 'Other') NOT NULL DEFAULT 'Other',
        organisation_notes TEXT,
        organisation_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        organisation_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Student Organisation relationship table
CREATE TABLE
    Student_Organisation (
        student_organisation_id INT PRIMARY KEY AUTO_INCREMENT,
        student_id INT NOT NULL, -- FK to Student
        organisation_id INT NOT NULL, -- FK to Organisation
        student_organisation_role VARCHAR(50) DEFAULT 'Member',
        student_organisation_join_date DATE NOT NULL,
        student_organisation_status ENUM ('Active', 'Inactive', 'Suspended') NOT NULL DEFAULT 'Active',
        student_organisation_notes TEXT,
        UNIQUE (student_id, organisation_id),
        FOREIGN KEY (student_id) REFERENCES Student (student_id) ON DELETE RESTRICT,
        FOREIGN KEY (organisation_id) REFERENCES Organisation (organisation_id) ON DELETE RESTRICT,
        student_organisation_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        student_organisation_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Lecturer Organisation relationship table
CREATE TABLE
    Lecturer_Organisation (
        lecturer_organisation_id INT PRIMARY KEY AUTO_INCREMENT,
        lecturer_id INT NOT NULL, -- FK to Lecturer
        organisation_id INT NOT NULL, -- FK to Organisation
        lecturer_organisation_role VARCHAR(50) DEFAULT 'Member',
        lecturer_organisation_join_date DATE NOT NULL,
        lecturer_organisation_status ENUM ('Active', 'Inactive', 'Suspended') NOT NULL DEFAULT 'Active',
        lecturer_organisation_notes TEXT,
        UNIQUE (lecturer_id, organisation_id),
        FOREIGN KEY (lecturer_id) REFERENCES Lecturer (lecturer_id) ON DELETE RESTRICT,
        FOREIGN KEY (organisation_id) REFERENCES Organisation (organisation_id) ON DELETE RESTRICT,
        lecturer_organisation_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        lecturer_organisation_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Course Offering table
CREATE TABLE
    Course_Offering (
        course_offering_id INT PRIMARY KEY AUTO_INCREMENT,
        course_id INT NOT NULL, -- FK to Course
        course_offering_semester ENUM (
            'Fall',
            'Winter',
            'Spring',
            'Summer',
            'Special Term'
        ) NOT NULL,
        course_offering_year YEAR NOT NULL CHECK (course_offering_year BETWEEN 1881 AND 2100),
        course_offering_start_date DATE NOT NULL,
        course_offering_end_date DATE NOT NULL,
        CHECK (
            course_offering_start_date <= course_offering_end_date
        ),
        CHECK (
            YEAR (course_offering_start_date) = course_offering_year
        ),
        course_offering_notes TEXT,
        course_offering_section INT NOT NULL DEFAULT 1 CHECK (course_offering_section >= 1),
        course_offering_status ENUM ('Open', 'Closed', 'Waitlist') NOT NULL DEFAULT 'Open',
        FOREIGN KEY (course_id) REFERENCES Course (course_id) ON DELETE RESTRICT,
        -- Prevents duplication of the same course section in any given semester and year
        UNIQUE (
            course_id,
            course_offering_semester,
            course_offering_year,
            course_offering_section
        ),
        course_offering_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        course_offering_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Course Offering Lecturer relationship table
CREATE TABLE
    Course_Offering_Lecturer (
        course_offering_lecturer_id INT PRIMARY KEY AUTO_INCREMENT,
        course_offering_id INT NOT NULL, -- FK to Course Offering
        lecturer_id INT NOT NULL, -- FK to Lecturer
        UNIQUE (course_offering_id, lecturer_id),
        FOREIGN KEY (course_offering_id) REFERENCES Course_Offering (course_offering_id) ON DELETE RESTRICT,
        FOREIGN KEY (lecturer_id) REFERENCES Lecturer (lecturer_id) ON DELETE RESTRICT,
        course_offering_lecturer_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        course_offering_lecturer_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Course Offering Student relationship table
CREATE TABLE
    Course_Offering_Student (
        course_offering_student_id INT PRIMARY KEY AUTO_INCREMENT,
        course_offering_id INT NOT NULL, -- FK to Course Offering
        student_id INT NOT NULL, -- FK to Student
        UNIQUE (course_offering_id, student_id),
        course_offering_student_result ENUM (
            'Enroled',
            'Passed',
            'Failed',
            'Withdrawn',
            'Dropped'
        ) NOT NULL DEFAULT 'Enroled',
        -- Grade validation logic
        course_offering_student_grade INT NULL CHECK (
            course_offering_student_grade >= 0
            AND course_offering_student_grade <= 100
        ),
        CHECK (
            (
                course_offering_student_result = 'Passed'
                AND course_offering_student_grade >= 51
            )
            OR (
                course_offering_student_result = 'Failed'
                AND course_offering_student_grade <= 50
            )
            OR (
                course_offering_student_result IN ('Enroled', 'Withdrawn', 'Dropped')
                AND course_offering_student_grade IS NULL
            )
        ),
        FOREIGN KEY (course_offering_id) REFERENCES Course_Offering (course_offering_id) ON DELETE RESTRICT,
        FOREIGN KEY (student_id) REFERENCES Student (student_id) ON DELETE RESTRICT,
        course_offering_student_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        course_offering_student_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );