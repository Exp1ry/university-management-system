# University Database Management System

**CSCK542 Final Project - Group B**

A comprehensive web-based university database management system built with Flask and MySQL.

## Team Members

- Odalo Aimufia
- Rami Albaroudi
- Suely Argelia Bonga Pereira
- Preet Sall
- Zaid Widyan

## Overview

This system provides a complete solution for managing university data including students, courses, programmes, staff, and research activities. The application features role-based authentication, interactive reports, and a web interface.

## Features

### Core Functionality

- **Student Management**: Student records, advisors, and organisation memberships
- **Course Management**: Course catalogue, prerequisites, offerings, and teaching assignments
- **Programme Management**: Academic programmes with course requirements
- **Staff Management**: Academic and non-academic staff with department organisation
- **Research Management**: Research groups, projects, and funding information
- **Interactive Reports**: Parameterised queries with dynamic results

### Security & Access Control

- Role-based authentication (Administrator/Student)
- Session management
- Data privacy protection
- SQL injection prevention

### User Interface

- Responsive design
- Combined table views
- Auto-scroll to results
- Back-to-top navigation
- Professional styling

## Technology Stack

- **Backend**: Python Flask
- **Database**: MySQL
- **Frontend**: HTML5, CSS3, JavaScript
- **Templates**: Jinja2
- **Database Connector**: mysql-connector-python

## Database Schema

The system manages 18 interconnected tables:

**Student Tables**: Student, Student_Advisor, Student_Organisation  
**Course Tables**: Course, Course_Offering, Course_Prerequisite, Course_Offering_Lecturer, Course_Offering_Student  
**Programme Tables**: Programme, Programme_Course_Requirement  
**Staff Tables**: Lecturer, Staff, Department, Lecturer_Organisation  
**Research Tables**: Research_Group, Research_Project, Lecturer_Research_Group  
**Organisation Table**: Organisation

## Installation & Setup

### Prerequisites

- Python 3.8+
- MySQL Server
- pip package manager

### Database Setup

1. Create MySQL database:

   ```sql
   CREATE DATABASE universitydb;
   ```

2. Import schema and data:
   ```bash
   mysql -u username -p universitydb 70% average in final year
   ```
3. **Student Advisor Contact**: Faculty advisor information for specific students
4. **Courses by Department**: All courses taught by department lecturers
5. **Staff by Department**: Academic and non-academic staff by department
6. **Students by Advisor**: Students advised by specific lecturers

## Usage

### Administrator Access

- View all student data including grades
- Manage staff and research information
- Generate comprehensive reports
- Access all system functionality

### Student Access

- View personal student profile
- Browse course catalogue
- View programme requirements
- Limited to non-sensitive information

## Development Notes

- Uses parameterised queries for security
- Implements session management
- Includes error handling
