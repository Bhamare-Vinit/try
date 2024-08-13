show databases;
use workbench;
show tables;
CREATE TABLE student_data (
    roll_number INT PRIMARY KEY,
    name VARCHAR(100),
    marks_in_maths INT,
    marks_in_science INT,
    marks_in_english INT
);
select * from student_data;
INSERT INTO student_data (roll_number, name, marks_in_maths, marks_in_science,marks_in_english,total_marks)
VALUES
	(6,'Girish',90,90,90,1);
	(7,'NoOne', 99, 95, 100,294),
	(1, 'Vinit', 99, 95, 89),
	(2, 'Devendra', 78, 85, 85),
	(3, 'Rakesh', 92, 88, 90),
	(4, 'Shreyas', 75, 82, 55);

SET SQL_SAFE_UPDATES = 0;
DELETE FROM student_data
WHERE roll_number IS NULL
   OR name IS NULL
   OR marks_in_maths IS NULL
   OR marks_in_science IS NULL;
   
CREATE TABLE student_info (
    roll_number INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    language VARCHAR(100)
);

INSERT INTO student_info (roll_number, name, department, language)
VALUES
(1, 'Vinit', 'It', 'Marathi'),
(2, 'Devendra', 'Cmps', 'Hindi'),
(3, 'Rakesh', 'Extc', 'Panjabi'),
(4, 'Shreyas', 'It', 'Tamil');

select * from student_info;

ALTER TABLE student_data
ADD COLUMN total_marks INT;

UPDATE student_data
SET total_marks = marks_in_maths + marks_in_science + marks_in_english
WHERE marks_in_maths IS NOT NULL AND marks_in_science IS NOT NULL AND marks_in_english IS NOT NULL;

ALTER TABLE student_info
ADD COLUMN grade varchar(100);

UPDATE student_info as si
JOIN student_data as sd ON si.name = sd.name
SET si.grade = CASE
    WHEN sd.total_marks >= 275 THEN 'A'
    WHEN sd.total_marks >= 250 THEN 'B'
    WHEN sd.total_marks >= 225 THEN 'C'
    WHEN sd.total_marks >= 200 THEN 'D'
    ELSE 'F'
END;

delete from student_data where name='Shreyas';
delete from student_info where name='Shreyas';








