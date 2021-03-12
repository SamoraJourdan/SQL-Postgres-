CREATE TABLE employees (
	emp_id bigserial CONSTRAINT emp_key PRIMARY KEY,
	first_name varchar(20),
	last_name varchar(30),
	email varchar(50),
	dob date,
	sal_inc_id integer REFERENCES salary_increase (sal_inc_id),
	overtime_id integer REFERENCES overtime (overtime_id),
	title_id integer REFERENCES titles (title_id)	
);

CREATE TABLE departments (
	dept_id bigserial CONSTRAINT dept_key PRIMARY KEY,
	dept_name varchar(50)
);

CREATE TABLE salaries (
	salary_id bigserial CONSTRAINT salary_key PRIMARY KEY,
	salary numeric(10,2),
	financial_year integer
);

CREATE TABLE salary_increase (
	sal_inc_id bigserial CONSTRAINT sal_inc_key PRIMARY KEY,
	salary_id integer REFERENCES salaries (salary_id),
	sal_inc numeric(10,2)
);

CREATE TABLE titles (
	title_id bigserial CONSTRAINT title_key PRIMARY KEY,
	dept_id integer REFERENCES departments (dept_id),
	title varchar(30)
);

CREATE TABLE overtime (
	overtime_id bigserial CONSTRAINT overtime_key PRIMARY KEY,
	overtime_hours integer
);

INSERT INTO departments (dept_name)
VALUES 
	('Human Reasources'),
	('Payroll'),
	('Stock Control'),
	('Floor Staff');
	
INSERT INTO overtime (overtime_hours)
VALUES 
	(2),
	(4),
	(6),
	(10),
	(12),
	(15);
	
INSERT INTO titles (title, dept_id)
VALUES 
	('HR Manager', 1),
	('Accountant', 2),
	('Stock Manager', 3),
	('Shelf Packer', 3),
	('Cashier', 4),
	('Floor Manager', 4);	

INSERT INTO salaries (salary, financial_year)
VALUES 
	(8000, 2020),
	(12000, 2020),
	(14000, 2020),
	(20000, 2020),
	(25000, 2020),
	(30000, 2020);
	
INSERT INTO salary_increase (sal_inc, salary_id)
VALUES 
	(500, 1),
	(1000, 2),
	(1000, 3),
	(2000, 4),
	(2500, 5),
	(3000, 6);
		
INSERT INTO employees (first_name, last_name, email, dob, title_id, sal_inc_id, overtime_id)
VALUES
	('Spongebob', 'Squarepants', 'sbjellyfish@gmail.com', '1998-01-25', 4, 1, 6),
	('Squidward', 'Tentacles', 'octoboss@gmail.com', '1994-03-31', 5, 2, 5),
	('Eugene', 'Krabs', 'moneymaker@gmail.com', '1989-11-25', 6, 6, 1),
	('Sandy', 'Cheeks', 'squirrelgirl@gmail.com', '1990-08-13', 1, 4, 4),
	('Patrick', 'Star', 'rockin1996@gmail.com', '1996-07-15', 2, 3, 2),
	('Poppy', 'Puff', 'blowfish22@gmail.com', '1979-12-20', 3, 5, 3);

--Varchar for email was too small
ALTER TABLE employees
ALTER COLUMN email type varchar(50)

--Add a unique contraint
ALTER TABLE employees ADD CONSTRAINT unique_email UNIQUE (email);	

--Add NOTNULL contraints
ALTER TABLE employees ALTER COLUMN first_name SET NOT NULL;
ALTER TABLE employees ALTER COLUMN last_name SET NOT NULL;
ALTER TABLE employees ALTER COLUMN dob SET NOT NULL;

SELECT emp.first_name, emp.last_name, emp.email, emp.dob, dept.dept_name, tit.title, sal_inc.sal_inc, sal.salary, ove.overtime_hours
FROM employees As emp JOIN titles AS tit
ON emp.title_id = tit.title_id
JOIN departments as dept
ON tit.dept_id = dept.dept_id
JOIN salary_increase as sal_inc
ON emp.sal_inc_id = sal_inc.sal_inc_id
JOIN salaries AS sal
ON sal_inc.salary_id = sal.salary_id
JOIN overtime AS ove
ON emp.overtime_id = ove.overtime_id;
