CREATE TABLE IF NOT EXISTS course (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50),
    number_credits INTEGER,
    description TEXT
);
CREATE TABLE IF NOT EXISTS department (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    course_id BIGINT UNIQUE NOT NULL,
    CONSTRAINT department_course_fk FOREIGN KEY (course_id) REFERENCES course(id)
);
CREATE TABLE IF NOT EXISTS student (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(15),
    email VARCHAR(255),
    date_of_birth TIMESTAMP
);
CREATE TABLE IF NOT EXISTS enrollment (
    student_id BIGINT NOT NULL,
    course_id BIGINT NOT NULL,
    PRIMARY KEY (student_id, course_id),
    CONSTRAINT enrollment_student_fk FOREIGN KEY (student_id) REFERENCES student(id),
    CONSTRAINT enrollment_course_fk FOREIGN KEY (course_id) REFERENCES course(id)
);