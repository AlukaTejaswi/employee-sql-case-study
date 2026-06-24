CREATE DATABASE EmployeeCaseStudy;
GO

USE EmployeeCaseStudy;
GO

/*====================================================
  CREATE TABLES Location, Department, Job, Employee
====================================================*/

CREATE TABLE Location
(
    Location_ID INT PRIMARY KEY,
    Regional_Group VARCHAR(20)
);

INSERT INTO Location VALUES
(122,'NEW YORK'),
(123,'DALLAS'),
(124,'CHICAGO'),
(167,'BOSTON');


CREATE TABLE Department
(
    Department_ID INT PRIMARY KEY,
    Name VARCHAR(20),
    Location_ID INT
);

INSERT INTO Department VALUES
(10,'ACCOUNTING',122),
(20,'RESEARCH',124),
(30,'SALES',123),
(40,'OPERATIONS',167);


CREATE TABLE Job
(
    Job_ID INT PRIMARY KEY,
    Functions VARCHAR(20)
);

INSERT INTO Job VALUES
(667,'CLERK'),
(668,'STAFF'),
(669,'ANALYST'),
(670,'SALESPERSON'),
(671,'MANAGER'),
(672,'PRESIDENT');


CREATE TABLE Employee
(
    Employee_ID INT PRIMARY KEY,
    Last_Name VARCHAR(20),
    First_Name VARCHAR(20),
    Middle_Name VARCHAR(5),
    Job_ID INT,
    Manager_ID INT,
    HireDate DATE,
    Salary INT,
    Comm INT NULL,
    Department_ID INT
);

INSERT INTO Employee VALUES
(7369,'SMITH','JOHN','Q',667,7902,'1984-12-17',800,NULL,20),
(7499,'ALLEN','KEVIN','J',670,7698,'1985-02-20',1600,300,30),
(7505,'DOYLE','JEAN','K',671,7839,'1985-04-04',2850,NULL,30),
(7506,'DENNIS','LYNN','S',671,7839,'1985-05-15',2750,NULL,30),
(7507,'BAKER','LESLIE','D',671,7839,'1985-06-10',2200,NULL,40),
(7521,'WARK','CYNTHIA','D',670,7698,'1985-02-22',1250,500,30);



/*====================================================
  BASIC SELECT QUERIES
====================================================*/

--1. List all employee details
SELECT * 
FROM Employee;

--2. List all department details
SELECT * 
FROM Department;

--3. List all job details
SELECT * 
FROM Job;

--4. List all locations
SELECT * 
FROM Location;

--5. List first name, last name, salary, commission
SELECT 
    First_Name,
    Last_Name,
    Salary,
    Comm
FROM Employee;

--6. Rename column aliases
SELECT 
    Employee_ID AS [ID OF THE EMPLOYEE],
    Last_Name AS [NAME OF THE EMPLOYEE],
    Department_ID AS [DEPARTMENT ID]
FROM Employee;

--7. Annual salary
SELECT 
    First_Name,
    Last_Name,
    Salary,
    Salary * 12 AS AnnualSalary
FROM Employee;

--8. Details of SMITH
SELECT * 
FROM Employee
WHERE Last_Name = 'SMITH';

--9. Employees in department 20
SELECT * 
FROM Employee
WHERE Department_ID = 20;

--10. Employees earning between 2000 and 3000
SELECT * 
FROM Employee
WHERE Salary BETWEEN 2000 AND 3000;

--11. Employees in department 10 or 20
SELECT * 
FROM EMPLOYEE
WHERE DEPARTMENT_ID IN (10,20);

--12. Employees not in department 10 or 30
SELECT * 
FROM Employee
WHERE Department_ID NOT IN (10,30);

--13. Employees whose name starts with S
SELECT * 
FROM Employee
WHERE Last_Name LIKE 'S%';

--14. Employees whose name starts with S and ends with H
SELECT * 
FROM Employee
WHERE Last_Name LIKE 'S%H';

--15. Employees whose name length is 4 and starts with S
SELECT * 
FROM Employee
WHERE Last_Name LIKE 'S___';

--16. Employees in department 30 earning > 2500
SELECT * 
FROM Employee
WHERE Department_ID = 30
AND Salary > 2500;

--17. Employees not receiving commission
SELECT * 
FROM Employee
WHERE Comm IS NULL;



/*====================================================
  SET OPERATORS
====================================================*/

--18. Distinct jobs in Sales and Accounting
SELECT Functions
FROM Job
WHERE Job_ID IN
(
    SELECT Job_ID
    FROM Employee
    WHERE Department_ID IN
    (
        SELECT Department_ID
        FROM Department
        WHERE Name IN ('SALES','ACCOUNTING')
    )
);

--19. All jobs in Sales and Accounting
SELECT j.Functions
FROM Job j
INNER JOIN Employee e
    ON j.Job_ID = e.Job_ID
INNER JOIN Department d
    ON e.Department_ID = d.Department_ID
WHERE d.Name IN ('SALES','ACCOUNTING');

--20. Common jobs in Research and Accounting
SELECT Functions
FROM Job
WHERE Job_ID IN
(
    SELECT Job_ID
    FROM Employee
    WHERE Department_ID =
    (
        SELECT Department_ID
        FROM Department
        WHERE Name = 'RESEARCH'
    )
)

INTERSECT

SELECT Functions
FROM Job
WHERE Job_ID IN
(
    SELECT Job_ID
    FROM Employee
    WHERE Department_ID =
    (
        SELECT Department_ID
        FROM Department
        WHERE Name = 'ACCOUNTING'
    )
)
ORDER BY Functions;



/*====================================================
  ORDER BY
====================================================*/

--21. Employee id and last name ascending by employee id
SELECT 
    Employee_ID,
    Last_Name
FROM Employee
ORDER BY Employee_ID ASC;

--22. Employee id and last name descending by salary
SELECT 
    Employee_ID,
    Last_Name
FROM Employee
ORDER BY Salary DESC;

--23. Order by last name asc and salary desc
SELECT * 
FROM Employee
ORDER BY Last_Name ASC, Salary DESC;

--24. Order by last name asc and department desc
SELECT * 
FROM Employee
ORDER BY Last_Name ASC, Department_ID DESC;



/*====================================================
  GROUP BY + AGGREGATES
====================================================*/

--25. Employee count department wise
SELECT 
    Department_ID,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY Department_ID;

--26. Department wise max/min/avg salary
SELECT 
    Department_ID,
    MAX(Salary) AS MaxSalary,
    MIN(Salary) AS MinSalary,
    AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Department_ID;

--27. Job wise max/min/avg salary
SELECT 
    Job_ID,
    MAX(Salary) AS MaxSalary,
    MIN(Salary) AS MinSalary,
    AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY Job_ID;

--28. Employees joined every month
SELECT 
    DATENAME(MONTH, HireDate) AS JoiningMonth,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY DATENAME(MONTH, HireDate),
         DATEPART(MONTH, HireDate)
ORDER BY DATEPART(MONTH, HireDate);

--29. Employees joined month/year wise
SELECT 
    DATEPART(YEAR, HireDate) AS JoiningYear,
    DATEPART(MONTH, HireDate) AS JoiningMonth,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY DATEPART(YEAR, HireDate),
         DATEPART(MONTH, HireDate)
ORDER BY JoiningYear, JoiningMonth;

--30. Departments having at least 4 employees
SELECT 
    Department_ID,
    COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY Department_ID
HAVING COUNT(*) >= 4;

--31. Employees joined in May
SELECT 
    DATENAME(MONTH, HireDate) AS JoiningMonth,
    COUNT(*) AS EmployeeCount
FROM Employee
WHERE DATENAME(MONTH, HireDate) = 'May'
GROUP BY DATENAME(MONTH, HireDate);

--32. Employees joined in May or June
SELECT 
    DATENAME(MONTH, HireDate) AS JoiningMonth,
    COUNT(*) AS EmployeeCount
FROM Employee
WHERE DATENAME(MONTH, HireDate) IN ('May','June')
GROUP BY DATENAME(MONTH, HireDate);

--33. Employees joined in 1985
SELECT 
    DATEPART(YEAR, HireDate) AS JoiningYear,
    COUNT(*) AS EmployeeCount
FROM Employee
WHERE DATEPART(YEAR, HireDate) = 1985
GROUP BY DATEPART(YEAR, HireDate);

--34. Employees joined each month in 1985
SELECT 
    DATEPART(YEAR, HireDate) AS JoiningYear,
    DATEPART(MONTH, HireDate) AS JoiningMonth,
    COUNT(*) AS EmployeeCount
FROM Employee
WHERE DATEPART(YEAR, HireDate) = 1985
GROUP BY DATEPART(YEAR, HireDate),
         DATEPART(MONTH, HIREDATE)
ORDER BY JoiningMonth;

--35. Employees joined in February 1985
SELECT 
    COUNT(*) AS EmployeeCount
FROM Employee
WHERE DATEPART(YEAR, HireDate) = 1985
AND DATEPART(MONTH, HireDate) = 2;

--36. Departments having >= 1 employee joined in April 1985
SELECT 
    Department_ID,
    COUNT(*) AS EmployeeCount
FROM Employee
WHERE DATEPART(YEAR, HireDate) = 1985
AND DATEPART(MONTH, HireDate) = 4
GROUP BY Department_ID
HAVING COUNT(*) >= 1;

/*====================================================
  JOINS, SUBQUERIES, CTEs, RANKING FUNCTIONS
====================================================*/

--37. List employee name, department name, and location name.
SELECT 
    e.First_Name,
    e.Last_Name,
    d.Name AS DepartmentName,
    l.Regional_Group AS LocationName
FROM Employee e
INNER JOIN Department d
    ON e.Department_ID = d.Department_ID
INNER JOIN Location l
    ON d.Location_ID = l.Location_ID;


--38. List employees along with their job function.
SELECT 
    e.Employee_ID,
    e.First_Name,
    e.Last_Name,
    j.Functions
FROM Employee e
INNER JOIN Job j
    ON e.Job_ID = j.Job_ID;

--39. List employees and their manager names.
SELECT 
    e.First_Name AS EmployeeName,
    m.First_Name AS ManagerName
FROM Employee e
LEFT JOIN Employee m
    ON e.Manager_ID = m.Employee_ID;

--40. Find employees earning more than the average salary.
SELECT *
FROM Employee
WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Employee
);

--41. Find the second highest salary.
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employee
WHERE Salary <
(
    SELECT MAX(Salary)
    FROM Employee
);

--42. List department-wise highest paid employee.
WITH DeptSalary AS
(
    SELECT 
        Department_ID,
        First_Name,
        Last_Name,
        Salary,
        RANK() OVER
        (
            PARTITION BY Department_ID
            ORDER BY Salary DESC
        ) AS Rnk
    FROM Employee
)
SELECT *
FROM DeptSalary
WHERE Rnk = 1;

--43. List top 3 highest paid employees.
SELECT TOP 3
    Employee_ID,
    First_Name,
    Last_Name,
    Salary
FROM Employee
ORDER BY Salary DESC;

--44. Find employees whose salary is greater than their department average salary.
WITH DeptAvg AS
(
    SELECT 
        Department_ID,
        AVG(Salary) AS AvgSalary
    FROM Employee
    GROUP BY Department_ID
)
SELECT 
    e.*
FROM Employee e
INNER JOIN DeptAvg d
    ON e.Department_ID = d.Department_ID
WHERE e.Salary > d.AvgSalary;

-- 45. Rank employees based on salary.
SELECT 
    Employee_ID,
    First_Name,
    Last_Name,
    Salary,
    RANK() OVER(ORDER BY Salary DESC) AS SalaryRank
FROM Employee;

-- 46. Dense rank employees based on salary.
SELECT 
    Employee_ID,
    First_Name,
    Last_Name,
    Salary,
    DENSE_RANK() OVER(ORDER BY Salary DESC) AS SalaryRank
FROM Employee;

-- 47. Row number for employees department wise.
SELECT 
    Employee_ID,
    First_Name,
    Last_Name,
    Department_ID,
    ROW_NUMBER() OVER
    (
        PARTITION BY Department_ID
        ORDER BY Salary DESC
    ) AS RowNum
FROM Employee;

-- 48. Find duplicate salaries.
SELECT 
    Salary,
    COUNT(*) AS SalaryCount
FROM Employee
GROUP BY Salary
HAVING COUNT(*) > 1;

-- 49. Find employees who earn the same salary.
SELECT *
FROM Employee
WHERE Salary IN
(
    SELECT Salary
    FROM Employee
    GROUP BY Salary
    HAVING COUNT(*) > 1
);

-- 50. Department-wise total salary using CTE.
WITH DepartmentSalary AS
(
    SELECT 
        Department_ID,
        SUM(Salary) AS TotalSalary
    FROM Employee
    GROUP BY Department_ID
)
SELECT *
FROM DepartmentSalary
ORDER BY TotalSalary DESC;
