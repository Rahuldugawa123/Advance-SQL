create database pak

create table employee(
employee_ID int primary key,
full_name varchar(30),
age int,
department varchar(30),
city varchar(30),
salary int
);

select*from employee

insert into employee values(
'1','Rahul dugawa',21,'data analyst','jodhpur','60000'),
('2','Saloni dugawa',20,'French teacher','merrut','50000'),
('3','paras yadav',21,'python developer','haryana','50000'),
('4','Zaid jamal',20,'softwer developer','lucknow','100000'),
('5','Nassir gouri',22,'Four lifter','jodhpur','40000'),
('6','Muskan sheety',20,'Lawer','merrut','60000'),
('7','Tanisha chouhan',20,'Fashion teacher','merrut','60000'),
('8','Mohit jangid',21,'python developer','haryana','100000'),
('9','Rishab jain',21,'java developer','haryana','100000'),
('10','Kailash jangid',22,'data analyst','lucknow','40000')

delete employee where employee_ID = '0'

select distinct city from employee

select distinct department from employee

select sum(salary) total_salary from employee

select avg(salary) avg_salary from employee

select employee_ID,full_name,department from employee

select full_name, department, salary from employee
where salary >= 60000
order by salary desc

alter table employee rename column department where  

select avg(salary) avg_salary, department from employee
group by department

select*from employee

select full_name, department from employee
where salary <= 50000

select full_name, department, salary from employee
where salary > (select avg(salary) avg_salary from employee)

select full_name, department, salary from employee
where age >= 21

select full_name, department, salary from employee
where city = 'jodhpur'

select avg(salary) avg_salary_city, city from employee
group by city
order by avg_salary_city desc

select avg(salary) avg_salary_age, age from employee
group by age
order by avg_salary_age desc

select full_name,salary from employee
where salary between 50000 and 100000

select * from employee
where city = 'jodhpur' or city = 'haryana'

select * from employee
where not city = 'jodhpur' 

select * from employee
where city = 'haryana' and age = 21

update employee
set department = 'French teacher'
where employee_ID = 7

select*from employee

select distinct department from employee

select avg(salary) avg_salary, department from employee
group by department
order by avg_salary

select min(salary) from employee

select top 5 min(salary) min_salary, department from employee
group by department
order by min_salary asc

select * from employee
where full_name like 'r%'

select * from employee
where full_name like '%r%'

select*from employee
where city in ('jodhpur','merrut')

select*from employee
where age in ('21','22')

-- Join cammands(inner join, left join, right join, self join) --

create table company(
employee_ID int primary key,
company_name varchar(30),
doj timestamp)

insert into company values(
'1','Amazon','2004-05-21'),
('2','Amazon','2010-08-20'),
('3','Deloite','2005-05-02'),
('4','Emirites','2004-08-11'),
('5','Wipro','2007-09-22'),
('6','Camgiminie','2008-09-09'),
('7','Wipro','2008-07-20'),
('8','Camgiminie','2007-07-21'),
('9','Wipro','2009-09-21'),
('10','Amazon','2007-07-22')

select*from company

select c.employee_ID,e.full_name,c.company_name from employee e
inner join company c 
on e.employee_ID = c.employee_ID

select e.employee_ID,e.full_name,e.city,e.department,c.company_name from employee e
left join company c 
on e.employee_ID = c.employee_ID

select c.employee_ID,e.full_name,c.company_name from employee e
right join company c 
on e.employee_ID = c.employee_ID

use pak

select a.full_name, b.department,a.city from employee a,
employee b
where a.full_name < b.department and a.city = b.city
order by a.city

-- Union function --

select full_name from employee
union 
select company_name from company

-- Having clause --

select count(employee_ID) employees, city from employee
group by city
having count(employee_ID) > 2

select*from employee
select*from company

select e.salary, e.department,e.age, count(c.employee_ID) employees
from company c 
inner join employee e on c.employee_ID = e.employee_ID
where age = '20' or age = '21'
group by department, salary,age
having count(c.employee_ID) >= 0

-- Exists function --

select full_name from employee
where exists (select company_name from company
where company.employee_ID = employee.employee_ID
and salary >= 40000)

-- ANY & ALL function --

select full_name from employee
where employee_ID = any (select employee_ID from company
where company_name = 'Amazon')

select full_name from employee
where employee_ID = all (select employee_ID from company
where company_name = 'Wipro')

-- Into function --

select * into employee1 from employee

select full_name, department, salary into employee2 from employee

select*from employee1
select * from employee2

drop table employee1
drop table employee2

select e.full_name, e.department,e.salary,c.company_name,c.doj 
into employee1 from employee e
left join company c on e.employee_ID = c.employee_ID

select full_name, department, salary into employee2 from employee
where 1 = 0

select full_name, department, salary into employee1 from employee
where 1 = 0

-- Insert Into function --

insert into employee2(full_name, department, salary)
select full_name, department, salary from employee

select * from employee2
order by salary asc

insert into employee1(full_name, department, salary)
select full_name, department, salary from employee
where department = 'data analyst'

select * from employee1

-- CASE function --

create table orders(
ordernumberID int identity(1,1) primary key,
orderID int,
productID int,
quantity int)

select*from orders

insert into orders values
('10248','11','12'),
('10248','42','10'),
('10248','72','5'),
('10249','14','9'),
('10249','51','40')

select orderID, quantity,
case
	when quantity > 30 then 'the quantity is greater than 30'
	when quantity = 30 then 'the quantity is 30'
	else 'the quantity is under 30'
end as quantitytext
from orders

select full_name, department, salary,
Case
	when department = 'data analyst' then 'name of data analyst'
	else 'none'
end as texts
from employee
order by salary

-- Stored Procedure --

create procedure selectallemployees
as
select*from employee
go;

exec selectallemployees

create procedure selectcitys @c varchar(30)
as
select * from employee 
where city = @c
go

exec selectcitys @c = 'jodhpur'

exec selectcitys @c = 'lucknow'

exec selectcitys @c = 'merrut'

create procedure selectage @a int
as
select * from employee 
where age = @a
go

exec selectage @a = '20'

create procedure select_department @dep varchar(30)
as
select*from employee
where department = @dep
order by salary
go

exec select_department @dep = 'french teacher'

create procedure select_salary @s int
as
select*from employee
where salary = @s
order by salary
go

exec select_salary @s = '60000'

create procedure select_companyname @companyname varchar(20)
as
select*from company
where company_name = @companyname
go

exec select_companyname @companyname = 'Amazon'

-- Constraints --

CREATE TABLE Person (
    ID int identity NOT NULL,
    F_name varchar(255) NOT NULL,
    L_name varchar(255) NOT NULL,
    Age int
)

insert into Person values
('rahul','dugawa','21'),
('saloni','chouhan','19'),
('kuldeep','choudary','24'),
('deeraj','','23'),
('suraj','patel','20')

select * from Person

update Person
set L_name = 'dugawa'
where ID = 1

alter table person
add constraint UB_persons unique (F_name,L_name)

alter table person
drop constraint UB_persons

insert into Person values
('rahul','dugawa','22')

delete from Person
where ID = '6' or ID = '8'

-- Views --

select*from employee

create view [merrut employee] 
as 
select full_name,department,salary 
from employee
where city = 'merrut'

select * from [jodhpur employee]

select * from [merrut employee]

create view [data dep]
as
select*from employee
where department = 'data analyst'

select*from [data dep]

create view [employees above avg salary]
as
select * from employee
where salary > (select avg(salary) from employee)

select*from [employees above avg salary]

drop view [data dep]
drop view [merrut employee]
drop view [employees above avg salary]

-- Injection --

select * from Person
where ID = '4' or 1=0

select * from Person
where ID = '4' or 1=1


