/*
Final Assignment - CSCK542

Group B Team Members:
 - Odalo Aimufia
 - Rami Albaroudi
 - Suely Argelia Bonga Pereira
 - Preet Sall
 - Zaid Widyan

UniversityDB
This SQL file includes sample data for a university record management system. 
Each of the tables contain 10 entries.
Names were created using a random name generator. 
Emails, phone numbers, addresses, and password hashes are placeholders. 
 */
-- Select schema for use
USE universityDB;

-- Insert sample data for Department table
INSERT INTO Department (department_name, department_research_areas, department_notes) VALUES
('Computer Science', 'Artificial Intelligence, Machine Learning, Cybersecurity, Software Engineering', 'Leading department in technological innovation'),
('Mathematics', 'Pure Mathematics, Applied Mathematics, Statistics, Mathematical Modelling', 'Strong focus on theoretical and applied research'),
('Physics', 'Quantum Physics, Astrophysics, Condensed Matter, Particle Physics', 'State-of-the-art laboratory facilities'),
('Chemistry', 'Organic Chemistry, Inorganic Chemistry, Physical Chemistry, Biochemistry', 'Research excellence in chemical sciences'),
('Biology', 'Molecular Biology, Ecology, Genetics, Marine Biology', 'Comprehensive biological research programmes'),
('English Literature', 'Victorian Literature, Contemporary Fiction, Poetry, Literary Theory', 'Rich tradition in literary scholarship'),
('History', 'Medieval History, Modern European History, British History, Social History', 'Extensive archival collections'),
('Economics', 'Macroeconomics, Microeconomics, Econometrics, Development Economics', 'Policy-focused research initiatives'),
('Philosophy', 'Ethics, Metaphysics, Philosophy of Mind, Political Philosophy', 'Critical thinking and analytical reasoning'),
('Psychology', 'Cognitive Psychology, Clinical Psychology, Social Psychology, Developmental Psychology', 'Human behaviour research centre');

-- Insert sample data for Programme table
INSERT INTO Programme (department_id, programme_name, programme_degree_awarded, programme_duration, programme_notes) VALUES
(1, 'Computer Science', 'BSc', 3, 'Comprehensive programme covering software development and theoretical computer science'),
(2, 'Mathematics', 'BSc', 3, 'Rigorous mathematical training with practical applications'),
(3, 'Physics', 'BSc', 3, 'Fundamental physics principles with laboratory experience'),
(4, 'Chemistry', 'BSc', 3, 'Chemical sciences with extensive practical work'),
(5, 'Biology', 'BSc', 3, 'Life sciences programme with field work opportunities'),
(6, 'English Literature', 'BA', 3, 'Literary studies with critical analysis focus'),
(7, 'History', 'BA', 3, 'Historical research and analysis programme'),
(8, 'Economics', 'BSc', 3, 'Economic theory and quantitative methods'),
(9, 'Philosophy', 'BA', 3, 'Philosophical inquiry and logical reasoning'),
(10, 'Psychology', 'BSc', 3, 'Scientific study of human behaviour and cognition');

-- Insert sample data for Course table
INSERT INTO Course (department_id, course_code, course_name, course_description, course_level, course_credits, course_materials, course_notes) VALUES
(1, 'CS101', 'Introduction to Programming', 'Fundamental programming concepts using Python and Java', 'Undergraduate', 1.0, 'Programming textbooks, online resources, development tools', 'Prerequisite for advanced CS courses'),
(2, 'MATH101', 'Calculus I', 'Differential and integral calculus fundamentals', 'Undergraduate', 1.0, 'Calculus textbook, graphing calculator', 'Foundation course for mathematics programme'),
(3, 'PHYS101', 'Classical Mechanics', 'Newtonian mechanics and motion principles', 'Undergraduate', 1.0, 'Physics textbook, laboratory manual', 'Includes practical laboratory sessions'),
(4, 'CHEM101', 'General Chemistry', 'Atomic structure, chemical bonding, and reactions', 'Undergraduate', 1.0, 'Chemistry textbook, safety equipment', 'Laboratory work required'),
(5, 'BIO101', 'Cell Biology', 'Structure and function of cellular components', 'Undergraduate', 1.0, 'Biology textbook, microscopy equipment', 'Microscopy skills development'),
(6, 'ENG101', 'Introduction to Literature', 'Survey of major literary works and genres', 'Undergraduate', 1.0, 'Literary anthology, critical essays', 'Essay writing skills emphasis'),
(7, 'HIST101', 'British History', 'Overview of British historical development', 'Undergraduate', 1.0, 'History textbooks, primary sources', 'Document analysis skills'),
(8, 'ECON101', 'Principles of Economics', 'Basic economic theory and market principles', 'Undergraduate', 1.0, 'Economics textbook, case studies', 'Mathematical applications included'),
(9, 'PHIL101', 'Introduction to Philosophy', 'Major philosophical questions and methods', 'Undergraduate', 1.0, 'Philosophy reader, classical texts', 'Critical thinking development'),
(10, 'PSYC101', 'Introduction to Psychology', 'Overview of psychological theories and research', 'Undergraduate', 1.0, 'Psychology textbook, research articles', 'Statistical methods introduction');

-- Insert sample data for Course_Prequisite table
INSERT INTO Course_Prerequisite (course_id, prerequisite_course_id) VALUES
(2, 1),
(3, 2),
(4, 2),
(5, 4),
(6, 9),
(7, 6),
(8, 2),
(9, 6),
(10, 2);


-- Insert sample data for Lecturer table
INSERT INTO Lecturer (department_id, lecturer_first_name, lecturer_last_name, lecturer_email, lecturer_password_hash, lecturer_academic_qualifications, lecturer_expertise, lecturer_course_load, lecturer_research_interests, lecturer_publications, lecturer_status, lecturer_notes) VALUES
(1, 'James', 'Thompson', 'j.thompson@university.ac.uk', 'hashed_password_1', 'PhD Computer Science, University of Cambridge', 'Artificial Intelligence, Machine Learning', 3, 'Neural networks, deep learning algorithms', '15 peer-reviewed publications in AI journals', 'Active', 'Leading AI research group'),
(2, 'Sarah', 'Williams', 's.williams@university.ac.uk', 'hashed_password_2', 'PhD Mathematics, University of Oxford', 'Pure Mathematics, Number Theory', 4, 'Prime number theory, cryptographic applications', '20 publications in mathematical journals', 'Active', 'Royal Society fellowship recipient'),
(3, 'Michael', 'Brown', 'm.brown@university.ac.uk', 'hashed_password_3', 'PhD Physics, Imperial College London', 'Quantum Physics, Condensed Matter', 2, 'Quantum computing, superconductivity', '18 publications in physics journals', 'Active', 'Quantum research laboratory director'),
(4, 'Emma', 'Davis', 'e.davis@university.ac.uk', 'hashed_password_4', 'PhD Chemistry, University of Edinburgh', 'Organic Chemistry, Drug Discovery', 3, 'Pharmaceutical compounds, synthetic methods', '12 publications in chemistry journals', 'Active', 'Industry collaboration specialist'),
(5, 'Robert', 'Wilson', 'r.wilson@university.ac.uk', 'hashed_password_5', 'PhD Biology, University of Bristol', 'Marine Biology, Ecology', 4, 'Marine ecosystems, climate change impacts', '22 publications in ecology journals', 'Active', 'Field research coordinator'),
(6, 'Catherine', 'Taylor', 'c.taylor@university.ac.uk', 'hashed_password_6', 'PhD English Literature, University of York', 'Victorian Literature, Gender Studies', 5, 'Victorian women writers, feminist literary theory', '14 publications in literary journals', 'Active', 'Victorian studies expert'),
(7, 'David', 'Anderson', 'd.anderson@university.ac.uk', 'hashed_password_7', 'PhD History, University of Durham', 'Medieval History, British History', 3, 'Medieval manuscripts, social history', '16 publications in historical journals', 'Active', 'Medieval studies specialist'),
(8, 'Rachel', 'Thomas', 'r.thomas@university.ac.uk', 'hashed_password_8', 'PhD Economics, London School of Economics', 'Macroeconomics, Economic Policy', 2, 'Monetary policy, economic forecasting', '11 publications in economics journals', 'Active', 'Government advisory committee member'),
(9, 'Peter', 'Jackson', 'p.jackson@university.ac.uk', 'hashed_password_9', 'PhD Philosophy, University of St Andrews', 'Ethics, Political Philosophy', 4, 'Applied ethics, moral philosophy', '13 publications in philosophy journals', 'Active', 'Ethics committee chair'),
(10, 'Helen', 'White', 'h.white@university.ac.uk', 'hashed_password_10', 'PhD Psychology, University of Glasgow', 'Cognitive Psychology, Neuroscience', 3, 'Memory processes, brain imaging', '19 publications in psychology journals', 'Active', 'Cognitive neuroscience laboratory head');

-- Insert sample data for Student table
INSERT INTO Student (programme_id, student_first_name, student_last_name, student_dob, student_email, student_password_hash, student_contact_phone, student_address, student_study_year, student_disciplinary_records, student_status, student_notes) VALUES
(1, 'Oliver', 'Smith', '2002-03-15', 'o.smith@university.ac.uk', 'student_hash_1', '+44 7123456789', '123 University Road, Manchester M13 9PL', 2, NULL, 'Active', 'Excellent programming skills'),
(2, 'Emily', 'Johnson', '2001-07-22', 'e.johnson@university.ac.uk', 'student_hash_2', '+44 7234567890', '456 College Street, Birmingham B15 2TT', 3, NULL, 'Active', 'Mathematics society president'),
(3, 'Harry', 'Williams', '2003-01-08', 'h.williams@university.ac.uk', 'student_hash_3', '+44 7345678901', '789 Campus Lane, Leeds LS2 9JT', 1, NULL, 'Active', 'Physics laboratory assistant'),
(4, 'Sophie', 'Brown', '2002-11-30', 's.brown@university.ac.uk', 'student_hash_4', '+44 7456789012', '321 Student Gardens, Newcastle NE1 7RU', 2, NULL, 'Active', 'Chemistry research volunteer'),
(5, 'George', 'Jones', '2001-09-14', 'g.jones@university.ac.uk', 'student_hash_5', '+44 7567890123', '654 Academic Close, Liverpool L69 3BX', 3, NULL, 'Active', 'Marine biology field trip leader'),
(6, 'Charlotte', 'Miller', '2002-05-03', 'c.miller@university.ac.uk', 'student_hash_6', '+44 7678901234', '987 Literature Avenue, Edinburgh EH8 9YL', 2, NULL, 'Active', 'Creative writing award winner'),
(7, 'William', 'Davis', '2003-04-18', 'w.davis@university.ac.uk', 'student_hash_7', '+44 7789012345', '147 History House, Oxford OX1 2JD', 1, NULL, 'Active', 'Historical society member'),
(8, 'Grace', 'Wilson', '2001-12-07', 'g.wilson@university.ac.uk', 'student_hash_8', '+44 7890123456', '258 Economics Court, Cambridge CB2 1TN', 3, NULL, 'Active', 'Economics journal contributor'),
(9, 'Jack', 'Moore', '2002-08-25', 'j.moore@university.ac.uk', 'student_hash_9', '+44 7901234567', '369 Philosophy Plaza, York YO10 5DD', 2, NULL, 'Active', 'Debate society champion'),
(10, 'Amelia', 'Taylor', '2003-02-11', 'a.taylor@university.ac.uk', 'student_hash_10', '+44 7012345678', '741 Psychology Park, Bath BA2 7AY', 1, NULL, 'Active', 'Research methods tutor');

-- Insert sample data for Research_Group table
INSERT INTO Research_Group (research_group_name, research_group_description, research_group_status) VALUES
('Artificial Intelligence Laboratory', 'Advanced AI research focusing on machine learning and neural networks', 'Active'),
('Mathematical Modelling Centre', 'Applied mathematics research for real-world problem solving', 'Active'),
('Quantum Physics Research Group', 'Cutting-edge quantum mechanics and computing research', 'Active'),
('Green Chemistry Initiative', 'Sustainable chemistry research and environmental applications', 'Active'),
('Marine Conservation Unit', 'Research focused on marine ecosystem preservation', 'Active'),
('Digital Humanities Project', 'Technology applications in literary and historical research', 'Active'),
('Social History Archive', 'Preservation and analysis of historical social documents', 'Active'),
('Economic Policy Institute', 'Research on contemporary economic challenges and solutions', 'Active'),
('Applied Ethics Centre', 'Practical applications of philosophical ethics in modern society', 'Active'),
('Cognitive Neuroscience Lab', 'Brain imaging and cognitive function research', 'Active');

-- Insert sample data for Staff table
INSERT INTO Staff (department_id, staff_first_name, staff_last_name, staff_email, staff_password_hash, staff_title, staff_type, staff_contract_details, staff_salary, staff_emergency_contact_name, staff_emergency_contact_phone, staff_emergency_contact_email, staff_status, staff_notes) VALUES
(1, 'Mark', 'Roberts', 'm.roberts@university.ac.uk', 'staff_hash_1', 'IT Support Specialist', 'Full-time', 'Permanent contract, 37.5 hours per week', 28000.00, 'Linda Roberts', '+44 7111222333', 'l.roberts@email.com', 'Active', 'Network administration specialist'),
(2, 'Lisa', 'Evans', 'l.evans@university.ac.uk', 'staff_hash_2', 'Administrative Assistant', 'Full-time', 'Permanent contract, 37.5 hours per week', 24000.00, 'John Evans', '+44 7222333444', 'j.evans@email.com', 'Active', 'Student services coordinator'),
(3, 'Andrew', 'Clarke', 'a.clarke@university.ac.uk', 'staff_hash_3', 'Laboratory Technician', 'Full-time', 'Permanent contract, 37.5 hours per week', 26000.00, 'Mary Clarke', '+44 7333444555', 'm.clarke@email.com', 'Active', 'Physics laboratory specialist'),
(4, 'Jennifer', 'Lewis', 'j.lewis@university.ac.uk', 'staff_hash_4', 'Research Administrator', 'Full-time', 'Permanent contract, 37.5 hours per week', 30000.00, 'Paul Lewis', '+44 7444555666', 'p.lewis@email.com', 'Active', 'Grant application coordinator'),
(5, 'Simon', 'Walker', 's.walker@university.ac.uk', 'staff_hash_5', 'Field Station Manager', 'Full-time', 'Permanent contract, 37.5 hours per week', 32000.00, 'Susan Walker', '+44 7555666777', 's.walker@email.com', 'Active', 'Marine station operations'),
(6, 'Karen', 'Hall', 'k.hall@university.ac.uk', 'staff_hash_6', 'Library Assistant', 'Part-time', 'Permanent contract, 20 hours per week', 16000.00, 'David Hall', '+44 7666777888', 'd.hall@email.com', 'Active', 'Special collections specialist'),
(7, 'Richard', 'Young', 'r.young@university.ac.uk', 'staff_hash_7', 'Archive Curator', 'Full-time', 'Permanent contract, 37.5 hours per week', 29000.00, 'Helen Young', '+44 7777888999', 'h.young@email.com', 'Active', 'Historical documents expert'),
(8, 'Michelle', 'King', 'm.king@university.ac.uk', 'staff_hash_8', 'Finance Officer', 'Full-time', 'Permanent contract, 37.5 hours per week', 31000.00, 'Robert King', '+44 7888999000', 'r.king@email.com', 'Active', 'Budget management specialist'),
(9, 'Christopher', 'Wright', 'c.wright@university.ac.uk', 'staff_hash_9', 'Events Coordinator', 'Full-time', 'Permanent contract, 37.5 hours per week', 27000.00, 'Sarah Wright', '+44 7999000111', 's.wright@email.com', 'Active', 'Academic conference organiser'),
(10, 'Amanda', 'Green', 'a.green@university.ac.uk', 'staff_hash_10', 'Student Counsellor', 'Full-time', 'Permanent contract, 37.5 hours per week', 33000.00, 'James Green', '+44 7000111222', 'j.green@email.com', 'Active', 'Mental health support specialist');

-- Insert sample data for Organisation table
INSERT INTO Organisation (organisation_name, organisation_description, organisation_status, organisation_membership_type, organisation_type, organisation_notes) VALUES
('Student Union', 'Representative body for all university students', 'Active', 'Student', 'Committee', 'Democratic student representation'),
('Academic Standards Committee', 'Oversight of academic quality and standards', 'Active', 'Mixed', 'Committee', 'Quality assurance focus'),
('Computer Science Society', 'Student society for CS programme participants', 'Active', 'Student', 'Club', 'Programming competitions and workshops'),
('Mathematics Club', 'Mathematics enthusiasts and students', 'Active', 'Student', 'Club', 'Problem-solving sessions'),
('Environmental Action Group', 'Sustainability and environmental awareness', 'Active', 'Mixed', 'Interest Group', 'Campus sustainability initiatives'),
('Drama Society', 'Theatre and performance group', 'Active', 'Student', 'Club', 'Annual theatrical productions'),
('Research Ethics Committee', 'Ethical oversight of university research', 'Active', 'Mixed', 'Committee', 'Research ethics approval'),
('International Students Association', 'Support network for international students', 'Active', 'Student', 'Interest Group', 'Cultural exchange programmes'),
('Staff Social Club', 'Social activities for university staff', 'Active', 'Staff', 'Club', 'Staff welfare and social events'),
('Alumni Network', 'Connection between graduates and university', 'Active', 'Mixed', 'Interest Group', 'Career networking and mentorship');

-- Insert sample data for Programme_Course_Requirement table
INSERT INTO Programme_Course_Requirement (programme_id, course_id, programme_course_requirement_type, programme_course_requirement_notes) VALUES
(1, 1, 'Core', 'Essential foundation course for Computer Science programme'),
(2, 2, 'Core', 'Fundamental mathematics requirement'),
(3, 3, 'Core', 'Basic physics principles course'),
(4, 4, 'Core', 'General chemistry foundation'),
(5, 5, 'Core', 'Cell biology fundamentals'),
(6, 6, 'Core', 'Literature programme foundation'),
(7, 7, 'Core', 'Historical methods introduction'),
(8, 8, 'Core', 'Economic principles foundation'),
(9, 9, 'Core', 'Philosophy programme introduction'),
(10, 10, 'Core', 'Psychology programme foundation');

-- Insert sample data for Student_Advisor table
INSERT INTO Student_Advisor (student_id, lecturer_id, student_advisor_notes) VALUES
(1, 1, 'Regular meetings scheduled for academic guidance'),
(2, 2, 'Mathematics programme academic support'),
(3, 3, 'Physics laboratory supervision'),
(4, 4, 'Chemistry research project guidance'),
(5, 5, 'Marine biology field work supervision'),
(6, 6, 'Literature dissertation supervision'),
(7, 7, 'Historical research methods guidance'),
(8, 8, 'Economics programme academic support'),
(9, 9, 'Philosophy dissertation supervision'),
(10, 10, 'Psychology research project guidance');

-- Insert sample data for Lecturer_Research_Group table
INSERT INTO Lecturer_Research_Group (lecturer_id, research_group_id, lecturer_research_group_role) VALUES
(1, 1, 'Principal Investigator'),
(2, 2, 'Principal Investigator'),
(3, 3, 'Principal Investigator'),
(4, 4, 'Principal Investigator'),
(5, 5, 'Principal Investigator'),
(6, 6, 'Principal Investigator'),
(7, 7, 'Principal Investigator'),
(8, 8, 'Principal Investigator'),
(9, 9, 'Principal Investigator'),
(10, 10, 'Principal Investigator');

-- Insert sample data for Research_Project table
INSERT INTO Research_Project (research_group_id, department_id, research_project_title, research_project_funding, research_project_publications, research_project_outcomes, research_project_status, research_project_notes) VALUES
(1, 1, 'Deep Learning for Medical Diagnosis', 'EPSRC Grant £250,000', '5 conference papers, 2 journal articles', 'Improved diagnostic accuracy by 15%', 'Active', 'Collaboration with NHS trusts'),
(2, 2, 'Mathematical Models for Climate Change', 'NERC Grant £180,000', '3 journal articles', 'Policy recommendations submitted', 'Active', 'Government advisory input'),
(3, 3, 'Quantum Computing Algorithms', 'Royal Society Grant £200,000', '4 journal articles', 'Patent application filed', 'Active', 'Industry partnership potential'),
(4, 4, 'Sustainable Chemical Processes', 'Innovate UK Grant £150,000', '6 journal articles', 'Green chemistry protocols developed', 'Active', 'Environmental impact reduction'),
(5, 5, 'Marine Biodiversity Assessment', 'Marine Conservation Grant £120,000', '8 journal articles', 'Species conservation recommendations', 'Active', 'International collaboration'),
(6, 6, 'Digital Archive Development', 'Arts Council Grant £80,000', '2 book chapters', 'Online archive platform created', 'Completed', 'Public access achieved'),
(7, 7, 'Social History Documentation', 'Heritage Lottery Grant £100,000', '3 journal articles', 'Historical database compiled', 'Active', 'Community engagement focus'),
(8, 8, 'Economic Impact Analysis', 'Treasury Research Grant £90,000', '4 policy papers', 'Economic forecasting model developed', 'Active', 'Government policy influence'),
(9, 9, 'Ethics in Technology', 'Wellcome Trust Grant £110,000', '5 journal articles', 'Ethical guidelines published', 'Active', 'Technology sector adoption'),
(10, 10, 'Cognitive Function Mapping', 'MRC Grant £300,000', '7 journal articles', 'Brain imaging protocols established', 'Active', 'Clinical applications developed');

-- Insert sample data for Course_Offering table
INSERT INTO Course_Offering (course_id, course_offering_semester, course_offering_year, course_offering_start_date, course_offering_end_date, course_offering_notes, course_offering_section, course_offering_status) VALUES
(1, 'Fall', 2024, '2024-09-15', '2024-12-15', 'Introduction to Programming - Autumn term', 1, 'Open'),
(2, 'Fall', 2024, '2024-09-15', '2024-12-15', 'Calculus I - Autumn term', 1, 'Open'),
(3, 'Fall', 2024, '2024-09-15', '2024-12-15', 'Classical Mechanics - Autumn term', 1, 'Open'),
(4, 'Fall', 2024, '2024-09-15', '2024-12-15', 'General Chemistry - Autumn term', 1, 'Open'),
(5, 'Fall', 2024, '2024-09-15', '2024-12-15', 'Cell Biology - Autumn term', 1, 'Open'),
(6, 'Fall', 2024, '2024-09-15', '2024-12-15', 'Introduction to Literature - Autumn term', 1, 'Open'),
(7, 'Fall', 2024, '2024-09-15', '2024-12-15', 'British History - Autumn term', 1, 'Open'),
(8, 'Fall', 2024, '2024-09-15', '2024-12-15', 'Principles of Economics - Autumn term', 1, 'Open'),
(9, 'Fall', 2024, '2024-09-15', '2024-12-15', 'Introduction to Philosophy - Autumn term', 1, 'Open'),
(10, 'Fall', 2024, '2024-09-15', '2024-12-15', 'Introduction to Psychology - Autumn term', 1, 'Open');

-- Insert sample data for Course_Offering_Lecturer table
INSERT INTO Course_Offering_Lecturer (course_offering_id, lecturer_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);

-- Insert sample data for Course_Offering_Student table
INSERT INTO Course_Offering_Student (course_offering_id, student_id, course_offering_student_result, course_offering_student_grade) VALUES
(1, 1, 'Passed', 78),
(2, 2, 'Passed', 85),
(3, 3, 'Enroled', NULL),
(4, 4, 'Passed', 72),
(5, 5, 'Passed', 88),
(6, 6, 'Passed', 91),
(7, 7, 'Enroled', NULL),
(8, 8, 'Passed', 76),
(9, 9, 'Passed', 83),
(10, 10, 'Enroled', NULL);

-- Insert sample data for Student_Organisation table
INSERT INTO Student_Organisation (student_id, organisation_id, student_organisation_role, student_organisation_join_date, student_organisation_status, student_organisation_notes) VALUES
(1, 3, 'President', '2023-09-01', 'Active', 'Leading programming workshops'),
(2, 4, 'Secretary', '2022-09-01', 'Active', 'Organising mathematics competitions'),
(3, 5, 'Member', '2024-01-15', 'Active', 'Environmental awareness campaigns'),
(4, 6, 'Vice President', '2023-09-01', 'Active', 'Theatre production coordinator'),
(5, 8, 'Treasurer', '2022-09-01', 'Active', 'International student support'),
(6, 6, 'Member', '2023-09-01', 'Active', 'Creative writing workshops'),
(7, 1, 'Representative', '2024-01-15', 'Active', 'Student union representative'),
(8, 10, 'Member', '2022-09-01', 'Active', 'Alumni networking events'),
(9, 5, 'Committee Member', '2023-09-01', 'Active', 'Sustainability projects'),
(10, 8, 'Member', '2024-01-15', 'Active', 'Cultural exchange programmes');

-- Insert sample data for Lecturer_Organisation table
INSERT INTO Lecturer_Organisation (lecturer_id, organisation_id, lecturer_organisation_role, lecturer_organisation_join_date, lecturer_organisation_status, lecturer_organisation_notes) VALUES
(1, 2, 'Chair', '2020-09-01', 'Active', 'Academic standards oversight'),
(2, 7, 'Member', '2019-09-01', 'Active', 'Research ethics review'),
(3, 2, 'Member', '2021-09-01', 'Active', 'Quality assurance committee'),
(4, 7, 'Vice Chair', '2020-09-01', 'Active', 'Ethics committee leadership'),
(5, 5, 'Advisor', '2018-09-01', 'Active', 'Environmental policy guidance'),
(6, 10, 'Member', '2019-09-01', 'Active', 'Alumni engagement activities'),
(7, 2, 'Member', '2020-09-01', 'Active', 'Academic policy development'),
(8, 7, 'Member', '2021-09-01', 'Active', 'Research ethics evaluation'),
(9, 2, 'Member', '2019-09-01', 'Active', 'Academic standards review'),
(10, 7, 'Member', '2020-09-01', 'Active', 'Psychology research ethics');
