/*
Final Assignment - CSCK542

Group B Team Members:
- Odalo Aimufia
- Rami Albaroudi
- Suely Argelia Bonga Pereira
- Preet Sall
- Zaid Widyan

UniversityDB
This SQL file defines the indexes for a university record management system. 
Primary keys, foreign keys, and unique constraints are automatically indexed by MySQL.
 */
-- Student table indexes
CREATE INDEX idx_student_study_year ON Student (student_study_year);

CREATE INDEX idx_student_status ON Student (student_status);

CREATE INDEX idx_student_programme_year ON Student (programme_id, student_study_year, student_status);

CREATE INDEX idx_student_date_created ON Student (student_date_created);

CREATE INDEX idx_student_name_composite ON Student (student_last_name, student_first_name);

CREATE INDEX idx_student_last_name ON Student (student_last_name);

CREATE INDEX idx_student_first_name ON Student (student_first_name);

-- Lecturer table indexes
CREATE INDEX idx_lecturer_status ON Lecturer (lecturer_status);

CREATE INDEX idx_lecturer_expertise ON Lecturer (lecturer_expertise (100));

CREATE INDEX idx_lecturer_research_interests ON Lecturer (lecturer_research_interests (100));

CREATE INDEX idx_lecturer_course_load ON Lecturer (lecturer_course_load);

CREATE INDEX idx_lecturer_name_composite ON Lecturer (lecturer_last_name, lecturer_first_name);

CREATE INDEX idx_lecturer_last_name ON Lecturer (lecturer_last_name);

CREATE INDEX idx_lecturer_first_name ON Lecturer (lecturer_first_name);

-- Staff table indexes
CREATE INDEX idx_staff_status ON Staff (staff_status);

CREATE INDEX idx_staff_type ON Staff (staff_type);

CREATE INDEX idx_staff_name_composite ON Staff (staff_last_name, staff_first_name);

CREATE INDEX idx_staff_last_name ON Staff (staff_last_name);

CREATE INDEX idx_staff_first_name ON Staff (staff_first_name);

-- Course offering indexes
CREATE INDEX idx_course_offering_semester_year ON Course_Offering (course_offering_semester, course_offering_year);

CREATE INDEX idx_course_offering_status ON Course_Offering (course_offering_status);

CREATE INDEX idx_course_offering_dates ON Course_Offering (
    course_offering_start_date,
    course_offering_end_date
);

CREATE INDEX idx_course_offering_lookup ON Course_Offering (
    course_id,
    course_offering_semester,
    course_offering_year,
    course_offering_status
);

-- Course offering student indexes
CREATE INDEX idx_student_result_grade ON Course_Offering_Student (
    course_offering_student_result,
    course_offering_student_grade
);

CREATE INDEX idx_student_grade_performance ON Course_Offering_Student (course_offering_student_grade);

-- Organisation membership indexes
CREATE INDEX idx_student_org_status ON Student_Organisation (student_organisation_status);

CREATE INDEX idx_lecturer_org_status ON Lecturer_Organisation (lecturer_organisation_status);

CREATE INDEX idx_student_org_join_date ON Student_Organisation (student_organisation_join_date);

CREATE INDEX idx_lecturer_org_join_date ON Lecturer_Organisation (lecturer_organisation_join_date);

-- Research project indexes
CREATE INDEX idx_research_project_status ON Research_Project (research_project_status);

CREATE INDEX idx_research_project_group_status ON Research_Project (research_group_id, research_project_status);

-- Programme and course relationship indexes
CREATE INDEX idx_programme_course_requirement_type ON Programme_Course_Requirement (programme_course_requirement_type);

-- Organisation indexes
CREATE INDEX idx_organisation_status ON Organisation (organisation_status);

CREATE INDEX idx_organisation_type ON Organisation (organisation_type, organisation_membership_type);

-- Research group indexes
CREATE INDEX idx_research_group_status ON Research_Group (research_group_status);

-- Full-text search indexes for research and expertise queries
CREATE FULLTEXT INDEX ft_lecturer_expertise ON Lecturer (lecturer_expertise, lecturer_research_interests);

CREATE FULLTEXT INDEX ft_department_research ON Department (department_research_areas);

CREATE FULLTEXT INDEX ft_research_project_title ON Research_Project (research_project_title);