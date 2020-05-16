# Pewlett-Hackard-Analysis
## Challenge

Deliverables:

We were tasked with finding the number of retiring employees for each job title, a listing of those employees, finding the number of current employees for each job title, and listing employees who are eligible for the mentorship program.

Among other csv files, we were given on that listed all employees (including past employees) and one that included all titles held by all the employees.

One of the challenges was to filter the employee data to include only current employees and filter the title data to include only the current title held by each employee.

To start, we needed to create an ERD for the data we were given as shown here.
![ERD Image](https://github.com/songmanrob/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png)

To figure out the employees who were retiring, we listed those who were current employees born between 1952 and 1955 (retirement_info.csv).

We removed the duplicates from the title data (titles_no_dups.csv).

To list the current employees for each job title who are retiring, we pulled the current title and added that information to the current employees who are retiring (retirement_info_no_dups.csv). We also ran a count of the number of employees per job title (retiring_titles.csv).

We filtered the entire employee list to include only those who are current employees (current_emp.csv), and added the current title (titles_no_dups.csv) to generate a count of how many current employees per title (current_emp_titles.csv).

We filtered the current employee data (current_emp.csv) to include only those born in 1965 to generate a resulting list of employees eligible for the mentorship program (mentorship_eligibility.csv).


Summary:

There are 41,380 employees retiring, including 2 out of the 5 department managers. 1549 employees are eligible for the mentorship program.
