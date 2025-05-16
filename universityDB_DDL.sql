/*
University Record Management System - 2025

This SQL file defines a comprehensive university database schema. The design is normalised to 3NF.
 */
-- Create schema and select it for use
CREATE SCHEMA IF NOT EXISTS universityDB;

USE universityDB;

-- Department table (needed before related entities)
CREATE TABLE
    Department (
        department_id INT PRIMARY KEY AUTO_INCREMENT,
        department_name VARCHAR(100) UNIQUE NOT NULL,
        faculty VARCHAR(100) NOT NULL,
        research_areas TEXT,
        department_notes TEXT,
        department_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        department_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Program table
CREATE TABLE
    Program (
        program_id INT PRIMARY KEY AUTO_INCREMENT,
        program_name VARCHAR(100) UNIQUE NOT NULL,
        degree_awarded VARCHAR(50) NOT NULL,
        duration INT NOT NULL CHECK (duration > 0),
        course_requirements TEXT NOT NULL,
        enrollment_details TEXT,
        department_id INT NOT NULL,
        program_notes TEXT,
        FOREIGN KEY (department_id) REFERENCES Department (department_id) ON DELETE RESTRICT,
        program_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        program_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Student table
CREATE TABLE
    Student (
        student_id INT PRIMARY KEY AUTO_INCREMENT,
        student_first_name VARCHAR(50) NOT NULL,
        student_last_name VARCHAR(50) NOT NULL,
        student_dob DATE NOT NULL,
        student_email VARCHAR(255) UNIQUE NOT NULL,
        student_password_hash VARCHAR(255) NOT NULL,
        student_contact_phone VARCHAR(20),
        student_address TEXT,
        program_id INT NOT NULL,
        year_of_study INT NOT NULL CHECK (year_of_study BETWEEN 1 AND 10),
        graduation_status ENUM ('Not Graduated', 'Graduated', 'In Progress') NOT NULL DEFAULT 'In Progress',
        disciplinary_records TEXT,
        student_status ENUM (
            'Active',
            'Suspended',
            'Graduated',
            'Withdrawn',
            'Exchange Completed'
        ) NOT NULL DEFAULT 'Active',
        student_notes TEXT,
        FOREIGN KEY (program_id) REFERENCES Program (program_id) ON DELETE RESTRICT,
        student_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        student_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Lecturer table
CREATE TABLE
    Lecturer (
        lecturer_id INT PRIMARY KEY AUTO_INCREMENT,
        lecturer_first_name VARCHAR(50) NOT NULL,
        lecturer_last_name VARCHAR(50) NOT NULL,
        lecturer_email VARCHAR(255) UNIQUE NOT NULL,
        lecturer_password_hash VARCHAR(255) NOT NULL,
        department_id INT NOT NULL,
        academic_qualifications TEXT NOT NULL,
        areas_of_expertise TEXT NOT NULL,
        course_load INT CHECK (course_load >= 0),
        research_interests TEXT,
        publications TEXT,
        lecturer_status ENUM ('Active', 'On Leave', 'Inactive') NOT NULL DEFAULT 'Active',
        lecturer_notes TEXT,
        FOREIGN KEY (department_id) REFERENCES Department (department_id) ON DELETE RESTRICT,
        lecturer_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        lecturer_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Non-Academic Staff table
CREATE TABLE
    Non_Academic_Staff (
        staff_id INT PRIMARY KEY AUTO_INCREMENT,
        staff_first_name VARCHAR(50) NOT NULL,
        staff_last_name VARCHAR(50) NOT NULL,
        staff_email VARCHAR(255) UNIQUE NOT NULL,
        staff_password_hash VARCHAR(255) NOT NULL,
        job_title VARCHAR(100) NOT NULL,
        department_id INT NOT NULL,
        employment_type ENUM ('Full-time', 'Part-time', 'Contract', 'Temporary') NOT NULL,
        contract_details TEXT,
        salary_information DECIMAL(10, 2),
        emergency_contact_name VARCHAR(100),
        emergency_contact_phone VARCHAR(20),
        staff_status ENUM ('Active', 'On Leave', 'Inactive') NOT NULL DEFAULT 'Active',
        staff_notes TEXT,
        FOREIGN KEY (department_id) REFERENCES Department (department_id) ON DELETE RESTRICT,
        staff_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        staff_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Course table
CREATE TABLE
    Course (
        course_id INT PRIMARY KEY AUTO_INCREMENT,
        course_code VARCHAR(10) UNIQUE NOT NULL,
        course_name VARCHAR(100) UNIQUE NOT NULL,
        course_description TEXT NOT NULL,
        department_id INT NOT NULL,
        course_level INT NOT NULL CHECK (course_level BETWEEN 1 AND 10),
        credits INT NOT NULL CHECK (credits > 0),
        prerequisites TEXT,
        schedule TEXT,
        course_materials TEXT,
        course_notes TEXT,
        FOREIGN KEY (department_id) REFERENCES Department (department_id) ON DELETE RESTRICT,
        course_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        course_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Research Project table
CREATE TABLE
    Research_Project (
        project_id INT PRIMARY KEY AUTO_INCREMENT,
        project_title VARCHAR(255) NOT NULL,
        principal_investigator_id INT NOT NULL,
        funding_sources TEXT,
        publications TEXT,
        outcomes TEXT,
        project_status ENUM ('Active', 'Completed', 'Discontinued', 'Planned') NOT NULL DEFAULT 'Active',
        project_notes TEXT,
        FOREIGN KEY (principal_investigator_id) REFERENCES Lecturer (lecturer_id) ON DELETE RESTRICT,
        project_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        project_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Committee table
CREATE TABLE
    Committee (
        committee_id INT PRIMARY KEY AUTO_INCREMENT,
        committee_name VARCHAR(100) UNIQUE NOT NULL,
        committee_purpose TEXT NOT NULL,
        committee_notes TEXT,
        committee_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        committee_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Student Organisation table
CREATE TABLE
    Student_Organisation (
        organisation_id INT PRIMARY KEY AUTO_INCREMENT,
        organisation_name VARCHAR(100) UNIQUE NOT NULL,
        organisation_description TEXT NOT NULL,
        organisation_notes TEXT,
        organisation_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        organisation_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Research Group table
CREATE TABLE
    Research_Group (
        research_group_id INT PRIMARY KEY AUTO_INCREMENT,
        research_group_name VARCHAR(100) UNIQUE NOT NULL,
        research_group_focus TEXT NOT NULL,
        head_lecturer_id INT UNIQUE,
        department_id INT NOT NULL,
        research_group_notes TEXT,
        FOREIGN KEY (head_lecturer_id) REFERENCES Lecturer (lecturer_id) ON DELETE RESTRICT,
        FOREIGN KEY (department_id) REFERENCES Department (department_id) ON DELETE RESTRICT,
        research_group_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        research_group_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Course_Lecturer relationship table
CREATE TABLE
    Course_Lecturer (
        course_id INT NOT NULL,
        lecturer_id INT NOT NULL,
        academic_year YEAR NOT NULL CHECK (academic_year BETWEEN 1881 AND 2100),
        semester ENUM (
            'Fall',
            'Winter',
            'Spring',
            'Summer',
            'Special Term'
        ) NOT NULL,
        section_number INT NOT NULL DEFAULT 1 CHECK (section_number >= 1),
        course_lecturer_notes TEXT,
        PRIMARY KEY (
            course_id,
            lecturer_id,
            academic_year,
            semester,
            section_number
        ),
        FOREIGN KEY (course_id) REFERENCES Course (course_id) ON DELETE RESTRICT,
        FOREIGN KEY (lecturer_id) REFERENCES Lecturer (lecturer_id) ON DELETE RESTRICT,
        course_lecturer_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        course_lecturer_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Course_Student relationship table
CREATE TABLE
    Course_Student (
        course_id INT NOT NULL,
        student_id INT NOT NULL,
        lecturer_id INT NOT NULL,
        enrollment_year YEAR NOT NULL CHECK (enrollment_year BETWEEN 1881 AND 2100),
        enrollment_semester ENUM (
            'Fall',
            'Winter',
            'Spring',
            'Summer',
            'Special Term'
        ) NOT NULL,
        grade INT NULL CHECK (
            grade IS NULL
            OR (
                grade >= 0
                AND grade <= 100
            )
        ),
        enrollment_status ENUM ('Enrolled', 'Withdrawn', 'Completed', 'Failed') NOT NULL DEFAULT 'Enrolled',
        course_student_notes TEXT,
        PRIMARY KEY (
            course_id,
            student_id,
            lecturer_id,
            enrollment_year,
            enrollment_semester
        ),
        FOREIGN KEY (course_id) REFERENCES Course (course_id) ON DELETE RESTRICT,
        FOREIGN KEY (student_id) REFERENCES Student (student_id) ON DELETE RESTRICT,
        FOREIGN KEY (lecturer_id) REFERENCES Lecturer (lecturer_id) ON DELETE RESTRICT,
        course_student_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        course_student_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Student_Advisor relationship table
CREATE TABLE
    Student_Advisor (
        student_id INT UNIQUE NOT NULL,
        advisor_id INT NOT NULL,
        assignment_date DATE NOT NULL,
        advisor_notes TEXT,
        PRIMARY KEY (student_id),
        FOREIGN KEY (student_id) REFERENCES Student (student_id) ON DELETE RESTRICT,
        FOREIGN KEY (advisor_id) REFERENCES Lecturer (lecturer_id) ON DELETE RESTRICT,
        student_advisor_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        student_advisor_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Student_Organisation_Membership relationship table
CREATE TABLE
    Student_Organisation_Membership (
        student_id INT NOT NULL,
        organisation_id INT NOT NULL,
        role VARCHAR(50) DEFAULT 'Member',
        join_date DATE NOT NULL,
        membership_notes TEXT,
        PRIMARY KEY (student_id, organisation_id),
        FOREIGN KEY (student_id) REFERENCES Student (student_id) ON DELETE RESTRICT,
        FOREIGN KEY (organisation_id) REFERENCES Student_Organisation (organisation_id) ON DELETE RESTRICT,
        membership_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        membership_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Lecturer_Committee relationship table
CREATE TABLE
    Lecturer_Committee (
        lecturer_id INT NOT NULL,
        committee_id INT NOT NULL,
        role VARCHAR(50) DEFAULT 'Member',
        appointment_date DATE NOT NULL,
        committee_notes TEXT,
        PRIMARY KEY (lecturer_id, committee_id),
        FOREIGN KEY (lecturer_id) REFERENCES Lecturer (lecturer_id) ON DELETE RESTRICT,
        FOREIGN KEY (committee_id) REFERENCES Committee (committee_id) ON DELETE RESTRICT,
        lecturer_committee_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        lecturer_committee_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Research_Project_Member relationship table
CREATE TABLE
    Research_Project_Member (
        project_id INT NOT NULL,
        member_id INT NOT NULL,
        member_type ENUM ('Lecturer', 'Student') NOT NULL,
        role VARCHAR(100) NOT NULL,
        join_date DATE NOT NULL,
        member_notes TEXT,
        PRIMARY KEY (project_id, member_id, member_type),
        FOREIGN KEY (project_id) REFERENCES Research_Project (project_id) ON DELETE RESTRICT,
        project_member_date_created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        project_member_date_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Indexes for performance optimisation
CREATE INDEX idx_student_name ON Student (student_first_name, student_last_name);

CREATE INDEX idx_student_program ON Student (program_id);

CREATE INDEX idx_lecturer_name ON Lecturer (lecturer_first_name, lecturer_last_name);

CREATE INDEX idx_lecturer_department ON Lecturer (department_id);

CREATE INDEX idx_staff_name ON Non_Academic_Staff (staff_first_name, staff_last_name);

CREATE INDEX idx_staff_department ON Non_Academic_Staff (department_id);

CREATE INDEX idx_course_department ON Course (department_id);

CREATE INDEX idx_course_student_lecturer ON Course_Student (lecturer_id);

CREATE INDEX idx_course_student_year_sem ON Course_Student (enrollment_year, enrollment_semester);

CREATE INDEX idx_course_lecturer_year_sem ON Course_Lecturer (academic_year, semester);

CREATE INDEX idx_research_project_pi ON Research_Project (principal_investigator_id);