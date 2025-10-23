-- Online Quiz System Database Schema
CREATE DATABASE IF NOT EXISTS quiz_system;
USE quiz_system;

-- Users table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    salt VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    user_type ENUM('ADMIN', 'STUDENT') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE
);

-- Subjects table
CREATE TABLE subjects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- Questions table
CREATE TABLE questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    subject_id INT NOT NULL,
    question_text TEXT NOT NULL,
    question_type ENUM('MULTIPLE_CHOICE', 'TRUE_FALSE') NOT NULL,
    option_a VARCHAR(255),
    option_b VARCHAR(255),
    option_c VARCHAR(255),
    option_d VARCHAR(255),
    option_true BOOLEAN,
    option_false BOOLEAN,
    correct_answer VARCHAR(10) NOT NULL,
    marks INT NOT NULL DEFAULT 1,
    explanation TEXT,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- Quizzes table
CREATE TABLE quizzes (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    subject_id INT NOT NULL,
    description TEXT,
    total_marks INT NOT NULL,
    time_limit_minutes INT NOT NULL,
    number_of_questions INT NOT NULL,
    pass_percentage DECIMAL(5,2) DEFAULT 60.00,
    is_active BOOLEAN DEFAULT TRUE,
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    shuffle_questions BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (subject_id) REFERENCES subjects(id),
    FOREIGN KEY (created_by) REFERENCES users(id)
);

-- Quiz-Questions mapping
CREATE TABLE quiz_questions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    quiz_id INT NOT NULL,
    question_id INT NOT NULL,
    display_order INT NOT NULL,
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id),
    FOREIGN KEY (question_id) REFERENCES questions(id),
    UNIQUE KEY unique_quiz_question (quiz_id, question_id)
);

-- Quiz results table
CREATE TABLE quiz_results (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    quiz_id INT NOT NULL,
    score DECIMAL(10,2) NOT NULL,
    total_marks INT NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    pass_fail ENUM('PASS', 'FAIL') NOT NULL,
    time_taken_seconds INT NOT NULL,
    completed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES users(id),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
);

-- Quiz result details
CREATE TABLE quiz_result_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    quiz_result_id INT NOT NULL,
    question_id INT NOT NULL,
    selected_answer VARCHAR(10),
    correct_answer VARCHAR(10) NOT NULL,
    marks_awarded DECIMAL(5,2) NOT NULL,
    is_correct BOOLEAN NOT NULL,
    FOREIGN KEY (quiz_result_id) REFERENCES quiz_results(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

-- Sample Data
INSERT INTO users (username, password_hash, salt, email, first_name, last_name, user_type) 
VALUES (
    'admin', 
    '8c6976e5b5410415bde908bd4dee15dfb167a9c873fc4bb8a81f6f2ab448a918',
    'somesalt',
    'admin@quizsystem.com',
    'System',
    'Administrator',
    'ADMIN'
);

INSERT INTO users (username, password_hash, salt, email, first_name, last_name, user_type) 
VALUES 
(
    'student1', 
    'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f',
    'somesalt',
    'student1@university.edu',
    'John',
    'Doe',
    'STUDENT'
),
(
    'student2', 
    'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f',
    'somesalt',
    'student2@university.edu',
    'Jane',
    'Smith',
    'STUDENT'
);

INSERT INTO subjects (name, description, created_by) 
VALUES 
('Mathematics', 'Basic mathematics and algebra', 1),
('Science', 'General science knowledge', 1);

INSERT INTO questions (subject_id, question_text, question_type, option_a, option_b, option_c, option_d, correct_answer, marks, explanation, created_by) 
VALUES 
(1, 'What is 2 + 2?', 'MULTIPLE_CHOICE', '3', '4', '5', '6', 'B', 1, 'Basic addition: 2 + 2 = 4', 1),
(1, 'What is 5 × 3?', 'MULTIPLE_CHOICE', '8', '15', '10', '12', 'B', 1, '5 multiplied by 3 equals 15', 1);

INSERT INTO quizzes (title, subject_id, description, total_marks, time_limit_minutes, number_of_questions, pass_percentage, created_by, shuffle_questions) 
VALUES 
('Basic Math Quiz', 1, 'Test your basic mathematics knowledge', 5, 10, 4, 60.00, 1, TRUE);

INSERT INTO quiz_questions (quiz_id, question_id, display_order) 
VALUES 
(1, 1, 1),
(1, 2, 2);
