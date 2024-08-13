show databases;
create database covid_problem;
use covid_problem;
show tables;
create table CountryWiseLatest(
	Country varchar(50),
    Confirmed int,
    Deaths int,
    Recovered int,
    Active int,
    Newcases int,
    Newdeaths int,
    Newrecoverd int,
    Deathsper100cases double,
    Recoverdper100cases double,
    Deathsper100recovered double,
    Confirmedlastweek int,
    Oneweekchange int,
    oneweekpercentageinc double,
    WHOregion varchar(50)
);

Create table WorldMeterData(
	Country varchar(50),
    Continent varchar(50),
    Population bigint,
    TotalCases bigint,
    NewCases int,
    TotalDeaths int,
    NewDeaths int,
    TotalRecoverd int,
    NewRecovered int,
    ActiveCases int,
    Serious int,
    TotalCasesper1M int,
    Deathsper1M int,
    TotalTests bigint,
    Testper1M int,
    WHORegion varchar(50)
);
-- Local Death Percentage
SELECT 
    Country,
    (TotalDeaths / Population) * 100 AS DeathPercentage
FROM 
    worldmeterdata;
    
-- Global Death Percentage
SELECT 
    (SUM(TotalDeaths) / SUM(Population)) * 100 AS GlobalDeathPercentage
FROM 
    worldmeterdata;

--  Local Infected Population Percentage
SELECT 
    Country, 
    (TotalCases / Population) * 100 AS InfectedPopulationPercentage
FROM 
    worldmeterdata;

-- Global Infected Population Percentage
SELECT 
    (SUM(TotalCases) / SUM(Population)) * 100 AS GlobalInfectedPopulationPercentage
FROM 
    worldmeterdata;
    

-- countries with the highest infection rates
SELECT 
    Country, 
    (TotalCases / Population) * 100 AS InfectionRate
FROM 
    worldmeterdata
ORDER BY 
    InfectionRate DESC;
    
-- Countries with the Highest Death Counts
SELECT 
    Country, 
    TotalDeaths
FROM 
    worldmeterdata
ORDER BY 
    TotalDeaths DESC;
    
-- Continents with the Highest Death Counts
SELECT 
    Continent, 
    SUM(TotalDeaths) AS TotalDeaths
FROM 
    worldmeterdata
GROUP BY 
    Continentday_wise
ORDER BY 
    TotalDeaths DESC;
    
    
-- Average number of deaths by day
SELECT 
    AVG(`New deaths`) AS DailyAverageDeaths
FROM 
    day_wise;


-- Average of cases divided by the number of population of each country
SELECT 
    AVG(TotalCases / Population) AS AverageCasesToPopulationRatio
FROM 
    worldmeterdata
WHERE 
    Population > 0;
    
-- for joins

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    gender CHAR(1),
    class INT
);

INSERT INTO students (id, name, age, gender, class) VALUES
(1, 'Vinit Bhamare', 15, 'M', 10),
(2, 'Rakesh Singade', 14, 'F', 9),
(3, 'Devendra Singh', 16, 'M', 11),
(4, 'Shreyas Sinde', 17, 'M', 12),
(5, 'Ayush Sharma', 13, 'F', 8),
(6, 'Takshashil Yadav', 15, 'M', 10),
(7, 'Avinash Patil', 14, 'F', 9),
(8, 'Chandrashekhar S', 16, 'M', 11),
(9, 'Antima Yadav', 17, 'M', 12),
(10, 'Harsh Bhamare', 13, 'M', 8),
(11, 'Harshala Yadav', 15, 'F', 10),
(12, 'Bhushan Bhangale', 14, 'M', 9),
(13, 'Om Bhamare', 16, 'F', 11),
(14, 'Krishnkant S', 17, 'M', 12),
(15, 'Vinil G', 13, 'F', 8),
(16, 'Amey B', 15, 'M', 10),
(17, 'Kunal Shekte', 14, 'F', 9),
(18, 'Abhijeet B', 16, 'M', 11),
(19, 'Yug Sonar', 17, 'F', 12),
(20, 'Monit Sonar', 13, 'M', 8);


CREATE TABLE subjects (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO subjects (id, name) VALUES
(1, 'Mathematics'),
(2, 'English'),
(3, 'Physics'),
(4, 'Chemistry'),
(5, 'Biology'),
(6, 'History'),
(7, 'Geography'),
(8, 'Physical Ed.'),
(9, 'Computer Sci'),
(10, 'Art');


CREATE TABLE teachers (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    subject_id INT,
    FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

INSERT INTO teachers (id, name, subject_id) VALUES
(1, 'Ms. Farzana', 1),
(2, 'Ms. Smita', 2),
(3, 'Mr. Harpreet', 3),
(4, 'Ms. Rutuja', 4),
(5, 'Dr. Gorakhnath', 5),
(6, 'Mrs. Manisha', 6),
(7, 'Mr. Deva', 7),
(8, 'Ms. Priya', 8),
(9, 'Mr. Sayali', 9),
(10, 'Mrs. Rupali', 10);

CREATE TABLE student_subjects (
    student_id INT,
    subject_id INT,
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (subject_id) REFERENCES subjects(id)
);

INSERT INTO student_subjects (student_id, subject_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 2),
(3, 4),
(4, 3),
(4, 5),
(5, 4),
(5, 6),
(6, 5),
(6, 7),
(7, 6),
(7, 8),
(8, 7),
(8, 9),
(9, 8),
(9, 10),
(10, 9),
(10, 1),
(11, 1),
(11, 2),
(12, 1),
(12, 3),
(13, 2),
(13, 4),
(14, 3),
(14, 5),
(15, 4),
(15, 6),
(16, 5),
(16, 7),
(17, 6),
(17, 8),
(18, 7),
(18, 9),
(19, 8),
(19, 10),
(20, 9),
(20, 1);

CREATE TABLE classes (
    id INT PRIMARY KEY,
    class_name INT
);

INSERT INTO classes (id, class_name) VALUES
(1, 8),
(2, 9),
(3, 10),
(4, 11),
(5, 12);



-- List the names of students along with their respective class names and the subjects they are enrolled in.
SELECT s.name AS student_name, c.class_name, sub.name AS subject_name
FROM students s
JOIN classes c ON s.class = c.class_name
JOIN student_subjects ss ON s.id = ss.student_id
JOIN subjects sub ON ss.subject_id = sub.id;

--  Find the teachers who are teaching students in class 10 and list the subjects they teach.
SELECT t.name AS teacher_name, sub.name AS subject_name
FROM teachers t
JOIN subjects sub ON t.subject_id = sub.id
JOIN student_subjects ss ON sub.id = ss.subject_id
JOIN students s ON ss.student_id = s.id
WHERE s.class = 10;


-- List the names of students and their ages who are taking Mathematics or English.
SELECT s.name AS student_name, s.age
FROM students s
JOIN student_subjects ss ON s.id = ss.student_id
JOIN subjects sub ON ss.subject_id = sub.id
WHERE sub.name IN ('Mathematics', 'English');


-- Find the total number of students enrolled in each subject.
SELECT sub.name AS subject_name, COUNT(ss.student_id) AS total_students
FROM subjects sub
JOIN student_subjects ss ON sub.id = ss.subject_id
GROUP BY sub.name;

-- List the names of teachers who are teaching more than one subject.
SELECT t.name AS teacher_name, COUNT(t.subject_id) AS subject_count
FROM teachers t
GROUP BY t.name
HAVING COUNT(t.subject_id) > 1;



-- Find the names of students who are taught by 'Mr. Smita'.
SELECT s.name AS student_name
FROM students s
JOIN student_subjects ss ON s.id = ss.student_id
JOIN subjects sub ON ss.subject_id = sub.id
JOIN teachers t ON sub.id = t.subject_id
WHERE t.name = 'Ms. Smita';



