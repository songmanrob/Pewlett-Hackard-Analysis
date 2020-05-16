-- Create table request #1
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

-- Create table request #1 with no dups
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