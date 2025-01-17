-- Deliverable #1
-- Create table of retiring employees by title
select tt.title,
	tt.from_date,
	ce.emp_no,
    ce.last_name,
	ce.first_name,
	s.salary
-- into filename	
from current_emp as ce
inner join titles as tt
on (ce.emp_no = tt.emp_no)
inner join salaries as s
on (tt.emp_no = s.emp_no)
order by tt.title,
	tt.from_date,
	ce.emp_no,
    ce.last_name,
	ce.first_name,
	s.salary;

-- Remove duplicates from titles
SELECT emp_no,
	title,
	from_date,
    to_date
INTO titles_no_dups
FROM
 (SELECT emp_no,
	title,
	from_date,
    to_date, ROW_NUMBER() OVER
    (PARTITION BY (emp_no)
    ORDER BY to_date DESC) rn
    FROM titles
    ) tmp WHERE rn = 1
ORDER BY emp_no;

-- Re-create table of retiring employees by title with no dups
select tt.title,
	tt.from_date,
	ce.emp_no,
    ce.last_name,
	ce.first_name,
	s.salary
into retirement_by_title_no_dups	
from current_emp as ce
inner join titles_no_dups as tt
on (ce.emp_no = tt.emp_no)
inner join salaries as s
on (tt.emp_no = s.emp_no)
order by tt.title,
	tt.from_date,
	ce.emp_no,
    ce.last_name,
	ce.first_name,
	s.salary;

--Create table that shows number of retiring employees per title
select title,
	count (title)
into retiring_titles
from retirement_by_title_no_dups
group by (title);

--Create table that shows number of current employees per title
select title,
	count (title)
into current_emp_titles
from titles as tt
right join current_emp as ce
on (tt.emp_no = ce.emp_no)
group by (title);

-- Deliverable #2
-- Create table of mentorship eligibility
-- Include emp_no, last_name, first_name, title, from_date, to_date
-- Only current employees born in 1965
select e.emp_no,
    e.last_name,
    e.first_name,
    tnd.title,
    tnd.from_date,
    tnd.to_date
into mentorship_eligibility
from employees as e
inner join titles_no_dups as tnd
on (e.emp_no = tnd.emp_no)
inner join dept_emp as de
on (tnd.emp_no = de.emp_no)
where (e.birth_date between '1965-01-01' and '1965-12-31')
and (de.to_date = '9999-01-01')
order by tnd.title,
    e.last_name,
    e.first_name,
    tnd.to_date,
    tnd.from_date,
    e.emp_no;