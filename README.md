# Employee SQL Case Study Project

## Project Overview

This project demonstrates an end-to-end SQL analysis of employee workforce data using a relational database model. The project covers database design, data management, and business analysis using SQL queries to generate meaningful workforce insights.

## Business Objective

The objective of this project is to analyse employee workforce data and generate insights related to workforce distribution, salary structure, employee hierarchy, departmental performance, and hiring trends.

The analysis supports HR and management decision-making by identifying workforce patterns, compensation trends, and opportunities for workforce optimisation.

---

## Key Business Questions Answered

The SQL analysis answers questions such as:

1. What are the details of all employees?
2. Which employees earn above the company average salary?
3. Who are the highest-paid employees?
4. What is the second-highest salary in the organisation?
5. How many employees work in each department?
6. Which employees share the same salary?
7. Who are the top three highest-paid employees?
8. Which employees earn above their department average salary?
9. Who are the highest-paid employees within each department?
10. What hiring trends can be observed from employee joining dates?

---

## Database Design

The project uses a relational database model consisting of four tables:

### Employee

Stores employee information including employee details, job role, salary, hire date, manager, and department.

### Department

Stores department information and links departments to locations.

### Job

Stores job roles and employee functions.

### Location

Stores regional information for department locations.

---

## Database Relationships

* Location → Department (One-to-Many)
* Department → Employee (One-to-Many)
* Job → Employee (One-to-Many)
* Employee → Employee (Manager–Employee Hierarchy)

---

## Tools and Technologies Used

* Microsoft SQL Server
* SQL (T-SQL)
* SQL Server Management Studio (SSMS)
* Microsoft Excel

### SQL Concepts Applied

* Data Retrieval and Filtering
* Aggregations and Grouping
* Joins
* Subqueries
* Common Table Expressions (CTEs)
* Window Functions (RANK, DENSE_RANK, ROW_NUMBER)

---

## Key Insights

* The Sales department has the highest employee concentration, indicating a strong focus on revenue-generating activities.
* Salary distribution varies across departments and job roles, reflecting differences in responsibilities and seniority levels.
* Salary ranking analysis identified the highest-paid employees and highlighted compensation hierarchy within the organisation.
* Hiring trend analysis revealed workforce expansion activity during 1985.
* Department-level salary analysis provides visibility into workforce costs and supports compensation planning.

---

## Conclusion

This project demonstrates how SQL can be used to transform employee data into actionable business insights. 
The analysis supports workforce planning, salary evaluation, employee management, and data-driven HR decision-making.

---

## Future Improvements

* Incorporate employee performance metrics
* Include attendance and leave data
* Develop an interactive HR dashboard using Power BI
* Implement stored procedures and database views
* Automate reporting workflows

---

## Author

**Aluka Tejaswi**

SQL Data Analyst Portfolio Project
