--AGGEGATE FUNCTION
SELECT 
    e.gender, AVG(s.salary) AS Average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY gender;

--LEFT JOIN
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

--CASE STATEMENT
SELECT 
    d.dept_name,
    ee.gender,
    dm.emp_no,
    dm.from_date,
    dm.to_date,
    e.calender_year,
    CASE
        WHEN
            YEAR(dm.from_date) <= e.calender_year
                AND YEAR(dm.to_date) >= e.calender_year
        THEN
            1
        ELSE 0
    END AS Active
FROM
    (SELECT 
        YEAR(hire_date) AS calender_year
    FROM
        t_employees
    GROUP BY calender_year) e
        CROSS JOIN
    t_dept_manager dm
        JOIN
    t_departments d ON dm.dept_no = d.dept_no
        JOIN
    t_employees ee ON dm.emp_no = ee.emp_no
ORDER BY dm.emp_no , calender_year;

--HAVING, GROUP BY
SELECT 
    d.dept_name,
    e.gender,
    ROUND(AVG(s.salary), 2) AS salary,
    YEAR(s.from_date) AS calender_year
FROM
    t_salaries s
        JOIN
    t_employees e ON s.emp_no = e.emp_no
        JOIN
    t_dept_emp de ON e.emp_no = de.emp_no
        JOIN
    t_departments d ON d.dept_no = de.dept_no
GROUP BY e.gender , d.dept_no , calender_year
HAVING calender_year <= 2002
ORDER BY d.dept_no, calender_year;

--SPLIT BY GENDER
select
year(d.from_date) as Calender_year,
e.gender,
count(e.emp_no) as number_of_employees
from
t_employees e
join
t_dept_emp d on e.emp_no = d.emp_no
group by calender_year, gender 
having calender_year >= 1990
order by calender_year 

--SUBQUERIES
SELECT 
    *
FROM
    employees e
WHERE
    EXISTS( SELECT 
            *
        FROM
            titles t
        WHERE
            t.emp_no = e.emp_no
            and title = 'assistant engineer');
--Select all the entire information for all employees whose job title is assistant engineer


--RIGHT JOIN
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        right JOIN
    departments_dup d ON m.dept_no = d.dept_no
ORDER BY dept_no;

--LEFT JOIN
select 
m.emp_no, m.first_name, m.last_name, d.dept_no, d.from_date
from employees m
left join
dept_manager d on m.emp_no = d.emp_no
where m.last_name = 'markovitch'
order by d.dept_no desc;

--JOIN
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    m.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    titles t ON e.emp_no = t.emp_no
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
        JOIN
    departments d ON m.dept_no = d.dept_no

select
e.gender as gender, count(d.emp_no) as frequency
from
employees e
join
dept_manager d on e.emp_no = d.emp_no
group by gender
;

select
e.gender as gender, count(e.gender) as frequency
from
employees e
join
dept_manager d on e.emp_no = d.emp_no
group by gender
;

--CROSS JOIN
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    dept_manager dm,
    departments d
ORDER BY dm.emp_no , d.dept_no;

SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;