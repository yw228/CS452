CREATE TABLE department (
   id INTEGER NOT NULL,
   name VARCHAR,
   PRIMARY KEY (id)
);

CREATE TABLE employee (
   id INTEGER NOT NULL,
   name VARCHAR,
   PRIMARY KEY (id)
);

CREATE TABLE phone (
  id INTEGER NOT NULL,
  employee_id INTEGER NOT NULL,
  type VARCHAR,
  number VARCHAR,
  PRIMARY KEY (id),
  FOREIGN KEY (employee_id) REFERENCES employee (id)
);

CREATE TABLE link (
   department_id INTEGER NOT NULL,
   employee_id INTEGER NOT NULL,
   PRIMARY KEY (department_id, employee_id),
   FOREIGN KEY(department_id) REFERENCES department (id),
   FOREIGN KEY(employee_id) REFERENCES employee (id)
);

INSERT INTO department (id, name)
VALUES (1, 'CS'), (2, 'EE'), (3, 'MATH');

INSERT INTO employee (id, name)
VALUES 
  (1, 'Quinn Snell'), 
  (2, 'Parris Egbert'), 
  (3, 'Mark Clement'),
  (4, 'David Wingate'),
  (5, 'Kevin Seppi');

INSERT INTO phone (id, employee_id, type, number)
values
  (1, 1, 'Office', '801-422-5098'),
  (2, 1, 'Dummy', '801-555-1212'),
  (3, 3, 'Office', '801-422-7608'),
  (4, 2, 'Office', '801-422-4029');

INSERT INTO link (department_id, employee_id)
values
  (1, 1),
  (1, 2),
  (2, 3),
  (2, 4),
  (3, 1),
  (3, 3);

.mode column
.headers on

-- List all phone numbers for Quinn or Mark
 CREATE table TestAssignQ1 as
    select E.id, E.name, P.number
    from employee E join phone P
    on E.id = P.employee_id
    where E.name like "Quinn%" or E.name like "Mark%";

select * from TestAssignQ1;




-- List employees by name and their department names sorted by employee name
CREATE table TestAssignQ2 as
  select E.name as Employee , D.name as Department
  
  from employee E join link L
  on E.id = L.employee_id
  join department D 
  on D.id = L.department_id
  order by E.name;

select * from TestAssignQ2;




-- List employees of CS
CREATE table TestAssignQ3 as
  select E.name as Employee, D.name as Department
  
  from employee E join link L
  on E.id = L.employee_id
  join department D 
  on D.id = L.department_id
  where D.name = "CS"
  order by E.name;

select * from TestAssignQ3;





-- List departments Quinn belongs to
  
CREATE table TestAssignQ4 as
  select D.name as Department,E.name as Employee
  
  from employee E join link L
  on E.id = L.employee_id
  join department D 
  on D.id = L.department_id
  where E.name = "Quinn Snell"
  order by D.name;
select * from TestAssignQ4;


-- List people that don't belong to a department
/* solution 1
CREATE table TestAssignQ5 as
  select E.name as Employee_With_No_Department
  from employee E FULL OUTER join link L
  on E.id = L.employee_id
  FULL OUTER join Department D 
  on D.id = L.department_id
WHERE D.id is null;
select * from TestAssignQ5;
*/ 
-- solution 2
CREATE table TestAssignQ5 as
select 
E.name AS Employee_With_No_Department
from
employee E
where
E.id NOT IN (select employee_id from link)
order by 
E.name;
select * from TestAssignQ5;
