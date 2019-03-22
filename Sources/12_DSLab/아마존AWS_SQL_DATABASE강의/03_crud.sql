
-- Check databases
SHOW DATABASES;

-- Use `ybigta` database
USE ybigta;

-- Check current `database` name
SELECT DATABASE();

-- Create `students` table
CREATE TABLE ybigta.students (  # ybigta라는 DB안에 students라는 관계를 하나 만들었다.
  student_id VARCHAR(10),
  name VARCHAR(10),
  sex CHAR(2),
  age INT,

  PRIMARY KEY (student_id)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;   # utf-8이어야 한글 자료를 받을 수 있다.

-- Insert data into `ybigta.students` table
INSERT INTO ybigta.students (student_id, name, sex, age) VALUES
  ('Y0001', '김신우', '남', 20),
  ('Y0002', '오현아', '여', 28),
  ('Y0003', '강민준', '남', 21),
  ('Y0004', '최세희', '여', 27),
  ('Y0005', '신민우', '남', 26);

-- Create `scores` table
CREATE TABLE ybigta.scores (
  student_id VARCHAR(10),
  subject VARCHAR(50),
  grade INT,
  year YEAR(4),
  semester CHAR(2)
) DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Insert data into `ybigta.scores` table
INSERT INTO ybigta.scores (student_id, subject, grade, year, semester) VALUES
  ('Y0001', 'database', 100, 2017, '1'),
  ('Y0005', 'politics', 76, 2014, '2'),
  ('Y0003', 'sociology', 89, 2016, '2'),
  ('Y0004', 'database', 93, 2013, '2'),
  ('Y0006', 'statistics', 0, 2014, '2'),
  ('Y0002', 'biology', 63, 2009, '1'),
  ('Y0007', 'philosophy', 83, 2008, '1'),
  ('Y0002', 'statistics', 69, 2010, '1'),
  ('Y0004', 'economics', 89, 2015, '2'),
  ('Y0005', 'database', 83, 2013, '2'),
  ('Y0001', 'politics', 96, 2017, '1'),
  ('Y0008', 'philosophy', 76, 2015, '1'),
  ('Y0003', 'biology', 86, 2016, '1'),
  ('Y0007', 'sociology', 79, 2013, '2'),
  ('Y0002', 'database', 76, 2014, '1'),
  ('Y0010', 'philosophy', 96, 2012, '2'),
  ('Y0004', 'statistics', 79, 2011, '2'),
  ('Y0010', 'sociology', 89, 2015, '1'),
  ('Y0002', 'economics', 86, 2012, '2'),
  ('Y0005', 'statistics', 73, 2011, '1'),
  ('Y0008', 'politics', 79, 2013, '2');

--
-- SELECT
--
SELECT 'YBIGTA';

--
SELECT
  student_id, name
FROM
  ybigta.students;

--
SELECT
  *
FROM
  ybigta.students
LIMIT 3;

--
SELECT
  student_id, subject, grade    # grade가 꼭 가져와져야 되는 것은 아니다.
FROM
  ybigta.scores
WHERE
  grade > 80;

--
SELECT
  student_id, subject, grade
FROM
  ybigta.scores
WHERE
  subject LIKE 'p%';    # LIKE 문법을 이용하여 해당하는 글자만 가져온다.

--
SELECT
  *
FROM
  ybigta.scores
WHERE
  grade > 80 AND year <= 2015;

--
SELECT
  *
FROM
  ybigta.scores
WHERE
  year < 2015
ORDER BY
  grade DESC;  # ASC

--
SELECT
  year, max(grade)
FROM
  ybigta.scores
GROUP BY
  year;

--
SELECT
  year, max(grade)
FROM
  ybigta.scores
GROUP BY
  year
HAVING
  max(grade) > 70;

--
SELECT
  *
FROM
  ybigta.students AS std
  JOIN
  ybigta.scores AS sco
  ON std.student_id = sco.student_id;

--
-- UPDATE
--
UPDATE ybigta.students
SET age = 30;

SELECT
  *
FROM
  ybigta.students;

--
UPDATE ybigta.students
SET age = 25
WHERE name = '김신우';

SELECT
  *
FROM
  ybigta.students;

--
-- DELETE
--
DELETE FROM ybigta.students;

SELECT
  *
FROM
  ybigta.students;

INSERT INTO ybigta.students (student_id, name, sex, age) VALUES
  ('Y0001', '김신우', '남', 20),
  ('Y0002', '오현아', '여', 28),
  ('Y0003', '강민준', '남', 21),
  ('Y0004', '최세희', '여', 27),
  ('Y0005', '신민우', '남', 26);

--
DELETE FROM ybigta.students
WHERE
  age < 25;

SELECT
  *
FROM
  ybigta.students;
