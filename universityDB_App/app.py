'''
Final Assignment - CSCK542

Group B Team Members:
 - Odalo Aimufia
 - Rami Albaroudi
 - Suely Argelia Bonga Pereira
 - Preet Sall
 - Zaid Widyan

UniversityDB - Flask Web Application

This module implements the university database management system using Flask.
The application provides a web-based interface for managing university data including
students, courses, programmes, staff, and research information.

Key Features:
- Role-based authentication (Administrator and Student access levels)
- Combined table views showing related data in single interfaces
- Interactive reports with parameterised queries

'''

from flask import Flask, render_template, request, redirect, url_for, flash, session
import mysql.connector
from mysql.connector import Error
from config import db_config, DEMO_USERS

app = Flask(__name__)
app.secret_key = 'university-db-secret-key-csck542'


class DatabaseManager:
    """
    Manages database connections and queries for the University Management System.

    This class handles all database operations including student data retrieval,
    course management, staff information, research data, and report generation.
    """

    def __init__(self):
        """Initialize DatabaseManager with configuration from config.py"""
        self.config = db_config

    def get_connection(self):
        """
        Establish connection to MySQL database.

        Returns:
            mysql.connector.connection: Database connection object if successful
            None: If connection fails
        """
        try:
            return mysql.connector.connect(**self.config)
        except Error as e:
            print(f"Database error: {e}")
            return None

    def get_student_own_data(self, username):
        """Get data for a specific student only (for student users)"""
        try:
            connection = self.get_connection()
            if not connection:
                return {'students': []}

            cursor = connection.cursor(dictionary=True)

            # Get only the logged-in student's data
            # Assuming username matches student email or you have a mapping
            student_query = """
                SELECT DISTINCT
                    s.student_id,
                    s.student_first_name,
                    s.student_last_name,
                    s.student_email,
                    s.student_dob,
                    s.student_contact_phone,
                    s.student_address,
                    s.student_study_year,
                    s.student_disciplinary_records,
                    s.student_status,
                    p.programme_name,
                    p.programme_degree_awarded,
                    p.programme_duration,
                    d.department_name,
                    
                    -- Faculty advisor
                    CONCAT(l.lecturer_first_name, ' ', l.lecturer_last_name) AS faculty_advisor,
                    l.lecturer_email AS advisor_email,
                    sa.student_advisor_notes,
                    
                    -- Current enrolments (without grades for privacy)
                    GROUP_CONCAT(DISTINCT CONCAT(
                        c.course_code, ' (', c.course_name, ')'
                    ) SEPARATOR ', ') AS current_enrolments,
                    
                    -- Organisation memberships
                    GROUP_CONCAT(DISTINCT CONCAT(
                        o.organisation_name, ' (', so.student_organisation_role, ')'
                    ) SEPARATOR ', ') AS organisation_memberships,
                    
                    s.student_date_created
                    
                FROM Student s
                JOIN Programme p ON s.programme_id = p.programme_id
                JOIN Department d ON p.department_id = d.department_id
                
                LEFT JOIN Student_Advisor sa ON s.student_id = sa.student_id
                LEFT JOIN Lecturer l ON sa.lecturer_id = l.lecturer_id
                LEFT JOIN Course_Offering_Student cos ON s.student_id = cos.student_id
                LEFT JOIN Course_Offering co ON cos.course_offering_id = co.course_offering_id
                LEFT JOIN Course c ON co.course_id = c.course_id
                LEFT JOIN Student_Organisation so ON s.student_id = so.student_id
                LEFT JOIN Organisation o ON so.organisation_id = o.organisation_id
                
                WHERE s.student_email = %s OR LOWER(CONCAT(s.student_first_name, s.student_last_name)) = LOWER(%s)
                
                GROUP BY s.student_id, s.student_first_name, s.student_last_name, 
                        s.student_email, s.student_dob, s.student_contact_phone, s.student_address,
                        s.student_study_year, s.student_disciplinary_records, s.student_status,
                        p.programme_name, p.programme_degree_awarded, p.programme_duration, d.department_name,
                        l.lecturer_first_name, l.lecturer_last_name, l.lecturer_email, sa.student_advisor_notes, s.student_date_created
            """

            cursor.execute(
                student_query, (username, username.replace(' ', '')))
            students = cursor.fetchall() # pylint: disable=locally-disabled, redefined-outer-name

            cursor.close()
            connection.close()

            return {'students': students}
        except Error as e:
            print(f"Query error: {e}")
            return {'students': []}

    def get_students_data(self):
        """Students: Combined view of Student, Course_Offering_Student, 
        Student_Advisor, Student_Organisation"""
        try:
            connection = self.get_connection()
            if not connection:
                return {'students': []}

            cursor = connection.cursor(dictionary=True)

            # Combined students query with all related information
            students_query = """
                SELECT DISTINCT
                    s.student_id,
                    s.student_first_name,
                    s.student_last_name,
                    s.student_email,
                    s.student_dob,
                    s.student_contact_phone,
                    s.student_address,
                    s.student_study_year,
                    s.student_disciplinary_records,
                    s.student_status,
                    p.programme_name,
                    p.programme_degree_awarded,
                    p.programme_duration,
                    d.department_name,
                    
                    -- Faculty advisor (concatenated)
                    CONCAT(l.lecturer_first_name, ' ', l.lecturer_last_name) AS faculty_advisor,
                    l.lecturer_email AS advisor_email,
                    sa.student_advisor_notes,
                    
                    -- Current enrolments with grades (concatenated)
                    GROUP_CONCAT(DISTINCT CONCAT(
                        c.course_code, ' (', 
                        COALESCE(cos.course_offering_student_grade, 'No Grade'), 
                        ' - ', cos.course_offering_student_result, ')'
                    ) SEPARATOR ', ') AS current_enrolments,
                    
                    -- Organisation memberships (concatenated)
                    GROUP_CONCAT(DISTINCT CONCAT(
                        o.organisation_name, ' (', so.student_organisation_role, ')'
                    ) SEPARATOR ', ') AS organisation_memberships,
                    
                    s.student_date_created
                    
                FROM Student s
                JOIN Programme p ON s.programme_id = p.programme_id
                JOIN Department d ON p.department_id = d.department_id
                
                -- Left join for advisor
                LEFT JOIN Student_Advisor sa ON s.student_id = sa.student_id
                LEFT JOIN Lecturer l ON sa.lecturer_id = l.lecturer_id
                
                -- Left join for current enrolments
                LEFT JOIN Course_Offering_Student cos ON s.student_id = cos.student_id
                LEFT JOIN Course_Offering co ON cos.course_offering_id = co.course_offering_id
                LEFT JOIN Course c ON co.course_id = c.course_id
                
                -- Left join for organisation memberships
                LEFT JOIN Student_Organisation so ON s.student_id = so.student_id
                LEFT JOIN Organisation o ON so.organisation_id = o.organisation_id
                
                GROUP BY s.student_id, s.student_first_name, s.student_last_name, 
                        s.student_email, s.student_dob, s.student_contact_phone, s.student_address,
                        s.student_study_year, s.student_disciplinary_records, s.student_status,
                        p.programme_name, p.programme_degree_awarded, p.programme_duration, d.department_name,
                        l.lecturer_first_name, l.lecturer_last_name, l.lecturer_email, sa.student_advisor_notes, s.student_date_created
                ORDER BY s.student_last_name, s.student_first_name
            """
            cursor.execute(students_query)
            students = cursor.fetchall() # pylint: disable=locally-disabled, redefined-outer-name

            cursor.close()
            connection.close()

            return {'students': students}
        except Error as e:
            print(f"Query error: {e}")
            return {'students': []}

    def get_programmes_data(self):
        """Programmes: Combined view of Programme and Programme_Course_Requirement"""
        try:
            connection = self.get_connection()
            if not connection:
                return {'programmes': []}

            cursor = connection.cursor(dictionary=True)

            # Combined programmes query with course requirements
            programmes_query = """
                SELECT DISTINCT
                    p.programme_id,
                    p.programme_name,
                    p.programme_degree_awarded,
                    p.programme_duration,
                    p.programme_notes,
                    d.department_name,
                    
                    -- Core requirements (concatenated)
                    GROUP_CONCAT(DISTINCT 
                        CASE WHEN pcr.programme_course_requirement_type = 'Core' 
                        THEN CONCAT(c.course_code, ' (', c.course_name, ')') 
                        END SEPARATOR ', '
                    ) AS core_requirements,
                    
                    -- Elective requirements (concatenated)
                    GROUP_CONCAT(DISTINCT 
                        CASE WHEN pcr.programme_course_requirement_type = 'Elective' 
                        THEN CONCAT(c.course_code, ' (', c.course_name, ')') 
                        END SEPARATOR ', '
                    ) AS elective_requirements,
                    
                    -- Optional requirements (concatenated)
                    GROUP_CONCAT(DISTINCT 
                        CASE WHEN pcr.programme_course_requirement_type = 'Optional' 
                        THEN CONCAT(c.course_code, ' (', c.course_name, ')') 
                        END SEPARATOR ', '
                    ) AS optional_requirements,
                    
                    -- Total requirement count
                    COUNT(DISTINCT pcr.programme_course_requirement_id) AS total_requirements,
                    
                    p.programme_date_created
                    
                FROM Programme p
                JOIN Department d ON p.department_id = d.department_id
                
                -- Left join for course requirements
                LEFT JOIN Programme_Course_Requirement pcr ON p.programme_id = pcr.programme_id
                LEFT JOIN Course c ON pcr.course_id = c.course_id
                
                GROUP BY p.programme_id, p.programme_name, p.programme_degree_awarded, 
                        p.programme_duration, p.programme_notes, d.department_name, p.programme_date_created
                ORDER BY d.department_name, p.programme_name
            """
            cursor.execute(programmes_query)
            programmes = cursor.fetchall() # pylint: disable=locally-disabled, redefined-outer-name

            cursor.close()
            connection.close()

            return {'programmes': programmes}
        except Error as e:
            print(f"Query error: {e}")
            return {'programmes': []}

    def get_courses_data(self):
        """Courses: Combined view of Course, Course_Offering, 
        Course_Offering_Lecturer, Course_Prerequisite"""
        try:
            connection = self.get_connection()
            if not connection:
                return {'courses': []}

            cursor = connection.cursor(dictionary=True)

            # Combined courses query with all related information
            courses_query = """
                SELECT DISTINCT
                    c.course_id,
                    c.course_code,
                    c.course_name,
                    c.course_description,
                    c.course_level,
                    c.course_credits,
                    c.course_materials,
                    d.department_name,
                    
                    -- Prerequisites (concatenated)
                    GROUP_CONCAT(DISTINCT CONCAT(cp_course.course_code, ' (', cp_course.course_name, ')') SEPARATOR ', ') AS prerequisites,
                    
                    -- Current offerings (concatenated)
                    GROUP_CONCAT(DISTINCT CONCAT(
                        co.course_offering_semester, ' ', 
                        co.course_offering_year, 
                        ' - Section ', co.course_offering_section,
                        ' (', co.course_offering_status, ')'
                    ) SEPARATOR ', ') AS current_offerings,
                    
                    -- Assigned lecturers (concatenated)
                    GROUP_CONCAT(DISTINCT CONCAT(
                        l.lecturer_first_name, ' ', l.lecturer_last_name
                    ) SEPARATOR ', ') AS assigned_lecturers,
                    
                    c.course_date_created
                    
                FROM Course c
                JOIN Department d ON c.department_id = d.department_id
                
                -- Left join for prerequisites
                LEFT JOIN Course_Prerequisite cp ON c.course_id = cp.course_id
                LEFT JOIN Course cp_course ON cp.prerequisite_course_id = cp_course.course_id
                
                -- Left join for current offerings
                LEFT JOIN Course_Offering co ON c.course_id = co.course_id 
                    AND co.course_offering_status IN ('Open', 'Closed')
                
                -- Left join for lecturer assignments
                LEFT JOIN Course_Offering_Lecturer col ON co.course_offering_id = col.course_offering_id
                LEFT JOIN Lecturer l ON col.lecturer_id = l.lecturer_id
                
                GROUP BY c.course_id, c.course_code, c.course_name, c.course_description, 
                        c.course_level, c.course_credits, c.course_materials, d.department_name, c.course_date_created
                ORDER BY c.course_code
            """
            cursor.execute(courses_query)
            courses = cursor.fetchall() # pylint: disable=locally-disabled, redefined-outer-name

            cursor.close()
            connection.close()

            return {'courses': courses}
        except Error as e:
            print(f"Query error: {e}")
            return {'courses': []}

    def get_staff_data(self):
        """Staff: Combined view of Lecturer, Staff, Department, Lecturer_Organisation"""
        try:
            connection = self.get_connection()
            if not connection:
                return {'departments': [], 'academic_staff': [], 'non_academic_staff': []}

            cursor = connection.cursor(dictionary=True)

            # Departments with staff counts
            departments_query = """
                SELECT 
                    d.department_id,
                    d.department_name,
                    d.department_research_areas,
                    d.department_notes,
                    COUNT(DISTINCT l.lecturer_id) AS lecturer_count,
                    COUNT(DISTINCT s.staff_id) AS staff_count,
                    d.department_date_created,
                    d.department_date_modified
                FROM Department d
                LEFT JOIN Lecturer l ON d.department_id = l.department_id AND l.lecturer_status = 'Active'
                LEFT JOIN Staff s ON d.department_id = s.department_id AND s.staff_status = 'Active'
                GROUP BY d.department_id, d.department_name, d.department_research_areas, 
                        d.department_notes, d.department_date_created, d.department_date_modified
                ORDER BY d.department_name
            """
            cursor.execute(departments_query)
            departments = cursor.fetchall()

            # Academic staff (lecturers) with research groups and organisations
            academic_staff_query = """
                SELECT DISTINCT
                    l.lecturer_id,
                    l.lecturer_first_name,
                    l.lecturer_last_name,
                    l.lecturer_email,
                    l.lecturer_academic_qualifications,
                    l.lecturer_expertise,
                    l.lecturer_course_load,
                    l.lecturer_research_interests,
                    l.lecturer_publications,
                    l.lecturer_status,
                    d.department_name,
                    
                    -- Research group memberships (concatenated)
                    GROUP_CONCAT(DISTINCT CONCAT(
                        rg.research_group_name, ' (', lrg.lecturer_research_group_role, ')'
                    ) SEPARATOR ', ') AS research_groups,
                    
                    -- Organisation memberships (concatenated)
                    GROUP_CONCAT(DISTINCT CONCAT(
                        o.organisation_name, ' (', lo.lecturer_organisation_role, ')'
                    ) SEPARATOR ', ') AS organisations,
                    
                    l.lecturer_date_created
                    
                FROM Lecturer l
                JOIN Department d ON l.department_id = d.department_id
                
                -- Left join for research groups
                LEFT JOIN Lecturer_Research_Group lrg ON l.lecturer_id = lrg.lecturer_id
                LEFT JOIN Research_Group rg ON lrg.research_group_id = rg.research_group_id
                
                -- Left join for organisations
                LEFT JOIN Lecturer_Organisation lo ON l.lecturer_id = lo.lecturer_id
                LEFT JOIN Organisation o ON lo.organisation_id = o.organisation_id
                
                GROUP BY l.lecturer_id, l.lecturer_first_name, l.lecturer_last_name, 
                        l.lecturer_email, l.lecturer_academic_qualifications, l.lecturer_expertise,
                        l.lecturer_course_load, l.lecturer_research_interests, l.lecturer_publications,
                        l.lecturer_status, d.department_name, l.lecturer_date_created
                ORDER BY l.lecturer_last_name, l.lecturer_first_name
            """
            cursor.execute(academic_staff_query)
            academic_staff = cursor.fetchall()

            # Non-academic staff
            non_academic_staff_query = """
                SELECT 
                    st.staff_id,
                    st.staff_first_name,
                    st.staff_last_name,
                    st.staff_email,
                    st.staff_title,
                    st.staff_type,
                    st.staff_contract_details,
                    st.staff_salary,
                    st.staff_emergency_contact_name,
                    st.staff_emergency_contact_phone,
                    st.staff_emergency_contact_email,
                    st.staff_status,
                    d.department_name,
                    st.staff_date_created
                FROM Staff st
                JOIN Department d ON st.department_id = d.department_id
                ORDER BY st.staff_last_name, st.staff_first_name
            """
            cursor.execute(non_academic_staff_query)
            non_academic_staff = cursor.fetchall()

            cursor.close()
            connection.close()

            return {
                'departments': departments,
                'academic_staff': academic_staff,
                'non_academic_staff': non_academic_staff
            }
        except Error as e:
            print(f"Query error: {e}")
            return {'departments': [], 'academic_staff': [], 'non_academic_staff': []}

    def get_research_data(self):
        """Research: Combined view of Research_Group, Research_Project, Lecturer_Research_Group"""
        try:
            connection = self.get_connection()
            if not connection:
                return {'research_groups': [], 'research_projects': []}

            cursor = connection.cursor(dictionary=True)

            # Research groups with member counts and projects
            research_groups_query = """
                SELECT DISTINCT
                    rg.research_group_id,
                    rg.research_group_name,
                    rg.research_group_description,
                    rg.research_group_status,
                    
                    -- Member count
                    COUNT(DISTINCT lrg.lecturer_id) AS member_count,
                    
                    -- Project count
                    COUNT(DISTINCT rp.research_project_id) AS project_count,
                    
                    -- Group members (concatenated)
                    GROUP_CONCAT(DISTINCT CONCAT(
                        l.lecturer_first_name, ' ', l.lecturer_last_name, ' (', lrg.lecturer_research_group_role, ')'
                    ) SEPARATOR ', ') AS group_members,
                    
                    -- Active projects (concatenated)
                    GROUP_CONCAT(DISTINCT CONCAT(
                        rp.research_project_title, ' (', rp.research_project_status, ')'
                    ) SEPARATOR ', ') AS group_projects,
                    
                    rg.research_group_date_created
                    
                FROM Research_Group rg
                
                -- Left join for group members
                LEFT JOIN Lecturer_Research_Group lrg ON rg.research_group_id = lrg.research_group_id
                LEFT JOIN Lecturer l ON lrg.lecturer_id = l.lecturer_id
                
                -- Left join for projects
                LEFT JOIN Research_Project rp ON rg.research_group_id = rp.research_group_id
                
                GROUP BY rg.research_group_id, rg.research_group_name, rg.research_group_description, 
                        rg.research_group_status, rg.research_group_date_created
                ORDER BY rg.research_group_name
            """
            cursor.execute(research_groups_query)
            research_groups = cursor.fetchall()

            # Research projects with group and department info
            research_projects_query = """
                SELECT 
                    rp.research_project_id,
                    rp.research_project_title,
                    rg.research_group_name,
                    rg.research_group_id,
                    d.department_name,
                    rp.research_project_funding,
                    rp.research_project_status,
                    rp.research_project_date_created,
                    
                    -- Project team members from the research group
                    GROUP_CONCAT(DISTINCT CONCAT(
                        l.lecturer_first_name, ' ', l.lecturer_last_name
                    ) SEPARATOR ', ') AS project_team
                    
                FROM Research_Project rp
                JOIN Research_Group rg ON rp.research_group_id = rg.research_group_id
                JOIN Department d ON rp.department_id = d.department_id
                
                -- Get team members from research group
                LEFT JOIN Lecturer_Research_Group lrg ON rg.research_group_id = lrg.research_group_id
                LEFT JOIN Lecturer l ON lrg.lecturer_id = l.lecturer_id
                
                GROUP BY rp.research_project_id, rp.research_project_title, rg.research_group_name,
                        rg.research_group_id, d.department_name, rp.research_project_funding,
                        rp.research_project_status, rp.research_project_date_created
                ORDER BY rp.research_project_title
            """
            cursor.execute(research_projects_query)
            research_projects = cursor.fetchall()

            cursor.close()
            connection.close()

            return {
                'research_groups': research_groups,
                'research_projects': research_projects
            }
        except Error as e:
            print(f"Query error: {e}")
            return {'research_groups': [], 'research_projects': []}

    def execute_report_query(self, query_type, **params):
        """Execute predefined report queries with parameters"""
        try:
            connection = self.get_connection()
            if not connection:
                return []

            cursor = connection.cursor(dictionary=True)

            queries = {
                'high_grade_final_year': """
                    SELECT 
                        s.student_id,
                        CONCAT(s.student_first_name, ' ', s.student_last_name) AS student_name,
                        s.student_email,
                        s.student_contact_phone,
                        s.student_study_year,
                        p.programme_name,
                        p.programme_duration,
                        AVG(cos.course_offering_student_grade) AS average_grade
                    FROM Student s
                    JOIN Programme p ON s.programme_id = p.programme_id
                    JOIN Course_Offering_Student cos ON s.student_id = cos.student_id
                    WHERE s.student_study_year = p.programme_duration
                        AND cos.course_offering_student_grade IS NOT NULL
                    GROUP BY s.student_id, s.student_first_name, s.student_last_name, 
                            s.student_email, s.student_contact_phone, s.student_study_year,
                            p.programme_name, p.programme_duration
                    HAVING AVG(cos.course_offering_student_grade) > 70
                    ORDER BY average_grade DESC
                """,

                'student_advisor': """
                    SELECT 
                        s.student_id,
                        CONCAT(s.student_first_name, ' ', s.student_last_name) AS student_name,
                        s.student_email,
                        s.student_contact_phone,
                        s.student_address,
                        CONCAT(l.lecturer_first_name, ' ', l.lecturer_last_name) AS advisor_name,
                        l.lecturer_email AS advisor_email,
                        d.department_name AS advisor_department,
                        sa.student_advisor_notes
                    FROM Student s
                    JOIN Student_Advisor sa ON s.student_id = sa.student_id
                    JOIN Lecturer l ON sa.lecturer_id = l.lecturer_id
                    JOIN Department d ON l.department_id = d.department_id
                    WHERE s.student_id = %s
                """,

                'courses_by_department': """
                    SELECT 
                        c.course_code,
                        c.course_name,
                        c.course_level,
                        c.course_credits,
                        CONCAT(l.lecturer_first_name, ' ', l.lecturer_last_name) AS lecturer_name,
                        co.course_offering_semester,
                        co.course_offering_year
                    FROM Course c
                    JOIN Department d ON c.department_id = d.department_id
                    JOIN Course_Offering co ON c.course_id = co.course_id
                    JOIN Course_Offering_Lecturer col ON co.course_offering_id = col.course_offering_id
                    JOIN Lecturer l ON col.lecturer_id = l.lecturer_id
                    WHERE d.department_name = %s
                    ORDER BY c.course_code, co.course_offering_year DESC
                """,

                'staff_by_department': """
                    SELECT 
                        'Lecturer' AS staff_type,
                        l.lecturer_id AS staff_id,
                        CONCAT(l.lecturer_first_name, ' ', l.lecturer_last_name) AS staff_name,
                        l.lecturer_email AS staff_email,
                        'Academic Staff' AS staff_title,
                        l.lecturer_status AS staff_status,
                        d.department_name
                    FROM Lecturer l
                    JOIN Department d ON l.department_id = d.department_id
                    WHERE d.department_name = %s
                    
                    UNION ALL
                    
                    SELECT 
                        'Non-Academic Staff' AS staff_type,
                        st.staff_id,
                        CONCAT(st.staff_first_name, ' ', st.staff_last_name) AS staff_name,
                        st.staff_email,
                        st.staff_title,
                        st.staff_status,
                        d.department_name
                    FROM Staff st
                    JOIN Department d ON st.department_id = d.department_id
                    WHERE d.department_name = %s
                    
                    ORDER BY staff_type, staff_name
                """,

                'students_by_advisor': """
                    SELECT 
                        s.student_id,
                        CONCAT(s.student_first_name, ' ', s.student_last_name) AS student_name,
                        s.student_email,
                        s.student_study_year,
                        p.programme_name,
                        sa.student_advisor_notes
                    FROM Student s
                    JOIN Student_Advisor sa ON s.student_id = sa.student_id
                    JOIN Lecturer l ON sa.lecturer_id = l.lecturer_id
                    JOIN Programme p ON s.programme_id = p.programme_id
                    WHERE CONCAT(l.lecturer_first_name, ' ', l.lecturer_last_name) = %s
                    ORDER BY s.student_last_name, s.student_first_name
                """,
            }

            if query_type not in queries:
                return []

            query = queries[query_type]

            if params:
                cursor.execute(query, list(params.values()))
            else:
                cursor.execute(query)

            results = cursor.fetchall()
            cursor.close()
            connection.close()

            return results

        except Error as e:
            print(f"Report query error: {e}")
            return []

    def get_departments_list(self):
        """Get list of departments for dropdown"""
        try:
            connection = self.get_connection()
            if not connection:
                return []

            cursor = connection.cursor(dictionary=True)
            cursor.execute(
                "SELECT department_name FROM Department ORDER BY department_name")
            results = cursor.fetchall()
            cursor.close()
            connection.close()

            return [dept['department_name'] for dept in results]
        except Error as e:
            print(f"Query error: {e}")
            return []

    def get_lecturers_list(self):
        """Get list of lecturers for dropdown"""
        try:
            connection = self.get_connection()
            if not connection:
                return []

            cursor = connection.cursor(dictionary=True)
            cursor.execute("""
                SELECT CONCAT(lecturer_first_name, ' ', lecturer_last_name) AS lecturer_name 
                FROM Lecturer 
                ORDER BY lecturer_last_name, lecturer_first_name
            """)
            results = cursor.fetchall()
            cursor.close()
            connection.close()

            return [lect['lecturer_name'] for lect in results]
        except Error as e:
            print(f"Query error: {e}")
            return []


db = DatabaseManager()

# Simple login check


def is_logged_in():
    """Check if user has valid session (any role)."""
    return 'user' in session


def is_admin():
    """Check if current user has administrator privileges."""
    return session.get('user', {}).get('access_all', False)


# Routes
@app.route('/login', methods=['GET', 'POST'])
def login():
    """Login page for user authentication."""
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')

        if username in DEMO_USERS and DEMO_USERS[username]['password'] == password:
            session['user'] = DEMO_USERS[username]
            session['user']['username'] = username
            return redirect(url_for('index'))
        else:
            flash('Invalid login')

    return render_template('login.html')


@app.route('/logout')
def logout():
    """Clear user session and redirect to login page."""
    session.clear()
    return redirect(url_for('login'))


@app.route('/')
def index():
    """Display main dashboard for authenticated users."""
    if not is_logged_in():
        return redirect(url_for('login'))
    return render_template('dashboard.html')


@app.route('/students')
def students():
    """
    Display student data with role-based filtering.
    Admins see all students, students see only their own data.
    """
    if not is_logged_in():
        return redirect(url_for('login'))

    # Students can only see their own data, admins see all
    if is_admin():
        data = db.get_students_data()  # All students
    else:
        # Get only current student's data
        data = db.get_student_own_data(session['user']['username'])

    return render_template('students.html', **data)


@app.route('/courses')
def courses():
    """Display course catalogue with prerequisites and offerings. All users."""
    if not is_logged_in():
        return redirect(url_for('login'))
    # Both admins and students can access courses
    data = db.get_courses_data()
    return render_template('courses.html', **data)


@app.route('/programmes')
def programmes():
    """Display academic programmes with course requirements. All users."""
    if not is_logged_in():
        return redirect(url_for('login'))
    # Both admins and students can access programmes
    data = db.get_programmes_data()
    return render_template('programmes.html', **data)


@app.route('/staff')
def staff():
    """Display staff management page. Admin access only."""
    if not is_logged_in():
        return redirect(url_for('login'))
    # Only admins can access staff
    if not is_admin():
        flash('Access denied. Admin access required.', 'error')
        return redirect(url_for('index'))

    data = db.get_staff_data()
    return render_template('staff.html', **data)


@app.route('/research')
def research():
    """Display research groups and projects. Admin access only."""
    if not is_logged_in():
        return redirect(url_for('login'))
    # Only admins can access research
    if not is_admin():
        flash('Access denied. Admin access required.', 'error')
        return redirect(url_for('index'))

    data = db.get_research_data()
    return render_template('research.html', **data)


@app.route('/reports', methods=['GET', 'POST'])
def reports():
    """
    Generate database reports with user parameters. Admin access only.
    GET: Show report forms. POST: Execute queries and display results.
    """
    if not is_logged_in():
        return redirect(url_for('login'))
    # Only admins can access reports
    if not is_admin():
        flash('Access denied. Admin access required.', 'error')
        return redirect(url_for('index'))
    results = []
    query_executed = None
    report_title = None

    if request.method == 'POST':
        query_type = request.form.get('query_type')

        if query_type == 'high_grade_final_year':
            results = db.execute_report_query('high_grade_final_year')
            query_executed = 'high_grade_final_year'
            report_title = 'High-Performing Final Year Students'

        elif query_type == 'student_advisor':
            student_id = request.form.get('student_id')
            if student_id:
                results = db.execute_report_query(
                    'student_advisor', student_id=student_id)
                query_executed = 'student_advisor'
                report_title = f'Faculty Advisor for Student ID: {student_id}'

        elif query_type == 'courses_by_department':
            department = request.form.get('department')
            if department:
                results = db.execute_report_query(
                    'courses_by_department', department=department)
                query_executed = 'courses_by_department'
                report_title = f'Courses in {department} Department'

        elif query_type == 'staff_by_department':
            department = request.form.get('department')
            if department:
                results = db.execute_report_query(
                    'staff_by_department', department=department, department2=department)
                query_executed = 'staff_by_department'
                report_title = f'All Staff in {department} Department'

        elif query_type == 'students_by_advisor':
            lecturer_name = request.form.get('lecturer_name')
            if lecturer_name:
                results = db.execute_report_query(
                    'students_by_advisor', lecturer_name=lecturer_name)
                query_executed = 'students_by_advisor'
                report_title = f'Students Advised by {lecturer_name}'

    # Get dropdown data
    departments = db.get_departments_list()
    lecturers = db.get_lecturers_list()

    return render_template('reports.html',
                           results=results,
                           query_executed=query_executed,
                           report_title=report_title,
                           departments=departments,
                           lecturers=lecturers)


if __name__ == '__main__':
    app.run(debug=True)
