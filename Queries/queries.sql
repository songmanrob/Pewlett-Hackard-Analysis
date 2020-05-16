select first_name, last_name
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

select first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31');

select * from retirement_info ;

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
	retirement_info.first_name,
    retirement_info.last_name,
	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

SELECT ri.emp_no,
	ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no;

-- Create temp table limiting employees to retirement eligible employees
SELECT emp_no, first_name, last_name, gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT e.emp_no,
	e.first_name,
    e.last_name,
	e.gender,
	s.salary,
	de.to_date
-- INTO emp_info
from employees as e
inner join salaries as s
on (e.emp_no = s.emp_no)
inner join dept_emp as de
on (e.emp_no = de.emp_no)
where (e.birth_date between '1952-01-01' and '1955-12-31')
and (e.hire_date between '1985-01-01' and '1988-12-31')
AND (de.to_date = '9999-01-01');

-- Create new table for retirement eligible managers
select dm.dept_no,
	d.dept_name,
	dm.emp_no,
    ce.last_name,
	ce.first_name,
    dm.from_date,
    dm.to_date
-- into manager_info
from dept_manager as dm
inner join departments as d
on (dm.dept_no = d.dept_no)
inner join current_emp as ce
on (dm.emp_no = ce.emp_no);

-- Create department retirees table
SELECT ce.emp_no,
    ce.first_name,
    ce.last_name,
    d.dept_name
-- INTO dept_info
FROM current_emp as ce
INNER JOIN dept_emp AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- Create new table for retirement eligible employees in sales and development departments
select d.dept_no,
    ce.last_name,
	ce.first_name,
	ce.emp_no
-- into filename	
from departments as d
inner join dept_emp as de
on (d.dept_no = de.dept_no)
inner join current_emp as ce
on (de.emp_no = ce.emp_no)
where d.dept_no in ('d005','d007')
order by d.dept_no, ce.last_name, ce.first_name, ce.emp_no;
