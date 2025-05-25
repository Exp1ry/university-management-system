'''
Final Assignment - CSCK542

Group B Team Members:
 - Odalo Aimufia
 - Rami Albaroudi
 - Suely Argelia Bonga Pereira
 - Preet Sall
 - Zaid Widyan

UniversityDB
'''

from flask import Flask, render_template, request, redirect, url_for, flash
import mysql.connector
from mysql.connector import Error
from config import db_config

app = Flask(__name__)


class DatabaseManager:
    def __init__(self):
        self.config = db_config

    def get_connection(self):
        try:
            return mysql.connector.connect(**self.config)
        except Error as e:
            print(f"Database error: {e}")
            return None

    def get_all_departments(self):
        try:
            connection = self.get_connection()
            if not connection:
                return []

            cursor = connection.cursor(dictionary=True)
            query = """
                SELECT 
                    department_id,
                    department_name,
                    department_research_areas,
                    department_notes,
                    department_date_created,
                    department_date_modified
                FROM Department
                ORDER BY department_name
            """
            cursor.execute(query)
            results = cursor.fetchall()
            cursor.close()
            connection.close()
            return results
        except Error as e:
            print(f"Query error: {e}")
            return []

    def get_all_programmes(self):
        try:
            connection = self.get_connection()
            if not connection:
                return []

            cursor = connection.cursor(dictionary=True)
            query = """
                SELECT 
                    p.programme_id,
                    p.programme_name,
                    p.programme_degree_awarded,
                    p.programme_duration,
                    p.programme_notes,
                    d.department_name,
                    p.programme_date_created,
                    p.programme_date_modified
                FROM Programme p
                JOIN Department d ON p.department_id = d.department_id
                ORDER BY d.department_name, p.programme_name
            """
            cursor.execute(query)
            results = cursor.fetchall()
            cursor.close()
            connection.close()
            return results
        except Error as e:
            print(f"Query error: {e}")
            return []

    def get_all_courses(self):
        try:
            connection = self.get_connection()
            if not connection:
                return []

            cursor = connection.cursor(dictionary=True)
            query = """
                SELECT 
                    c.course_id,
                    c.course_code,
                    c.course_name,
                    c.course_description,
                    c.course_level,
                    c.course_credits,
                    c.course_materials,
                    c.course_notes,
                    d.department_name,
                    c.course_date_created,
                    c.course_date_modified
                FROM Course c
                JOIN Department d ON c.department_id = d.department_id
                ORDER BY c.course_code
            """
            cursor.execute(query)
            results = cursor.fetchall()
            cursor.close()
            connection.close()
            return results
        except Error as e:
            print(f"Query error: {e}")
            return []

    def get_all_lecturers(self):
        try:
            connection = self.get_connection()
            if not connection:
                return []

            cursor = connection.cursor(dictionary=True)
            query = """
                SELECT 
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
                    l.lecturer_date_created,
                    l.lecturer_date_modified
                FROM Lecturer l
                JOIN Department d ON l.department_id = d.department_id
                ORDER BY l.lecturer_last_name, l.lecturer_first_name
            """
            cursor.execute(query)
            results = cursor.fetchall()
            cursor.close()
            connection.close()
            return results
        except Error as e:
            print(f"Query error: {e}")
            return []

    def get_all_staff(self):
        try:
            connection = self.get_connection()
            if not connection:
                return []

            cursor = connection.cursor(dictionary=True)
            query = """
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
                    st.staff_date_created,
                    st.staff_date_modified
                FROM Staff st
                JOIN Department d ON st.department_id = d.department_id
                ORDER BY st.staff_last_name, st.staff_first_name
            """
            cursor.execute(query)
            results = cursor.fetchall()
            cursor.close()
            connection.close()
            return results
        except Error as e:
            print(f"Query error: {e}")
            return []

    def get_all_students(self):
        try:
            connection = self.get_connection()
            if not connection:
                return []

            cursor = connection.cursor(dictionary=True)
            query = """
                SELECT 
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
                    s.student_date_created,
                    s.student_date_modified
                FROM Student s
                JOIN Programme p ON s.programme_id = p.programme_id
                JOIN Department d ON p.department_id = d.department_id
                ORDER BY s.student_last_name, s.student_first_name
            """
            cursor.execute(query)
            results = cursor.fetchall()
            cursor.close()
            connection.close()
            return results
        except Error as e:
            print(f"Query error: {e}")
            return []

    def get_all_research_groups(self):
        try:
            connection = self.get_connection()
            if not connection:
                return []

            cursor = connection.cursor(dictionary=True)
            query = """
                SELECT 
                    research_group_id,
                    research_group_name,
                    research_group_description,
                    research_group_status,
                    research_group_date_created,
                    research_group_date_modified
                FROM Research_Group
                ORDER BY research_group_name
            """
            cursor.execute(query)
            results = cursor.fetchall()
            cursor.close()
            connection.close()
            return results
        except Error as e:
            print(f"Query error: {e}")
            return []


db = DatabaseManager()

# Routes


@app.route('/')
def index():
    return render_template('dashboard.html')


@app.route('/table/department')
def view_departments():
    departments = db.get_all_departments()
    return render_template('departments.html', departments=departments)


@app.route('/table/programme')
def view_programmes():
    programmes = db.get_all_programmes()
    return render_template('programmes.html', programmes=programmes)


@app.route('/table/course')
def view_courses():
    courses = db.get_all_courses()
    return render_template('courses.html', courses=courses)


@app.route('/table/lecturer')
def view_lecturers():
    lecturers = db.get_all_lecturers()
    return render_template('lecturers.html', lecturers=lecturers)


@app.route('/table/staff')
def view_staff():
    staff = db.get_all_staff()
    return render_template('staff.html', staff=staff)


@app.route('/table/student')
def view_students():
    students = db.get_all_students()
    return render_template('students.html', students=students)


@app.route('/table/research_group')
def view_research_groups():
    research_groups = db.get_all_research_groups()
    return render_template('research_groups.html', research_groups=research_groups)


@app.route('/table/<table_name>')
def view_table(table_name):
    # For now, just redirect to dashboard for unimplemented tables
    return render_template('generic_table.html', table_name=table_name.replace('_', ' ').title(), data=[], raw_table_name=table_name)


if __name__ == '__main__':
    app.run(debug=True)
