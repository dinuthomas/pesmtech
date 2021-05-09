/**
* The table designed for medicine project. 
* 
* @Auther: MTechProject Team
* Dinu Thomas-09/05/2021- added Prescription column, medicine set into Prescription table
* TODO , pls insert the data according to the design and 
* add the change details as per the format<Updater>-<date>-<Update Details>
* pls use the same comment in the commit message
*/

use medicine;
set sql_safe_updates=0;

show tables;

select * from department limit 10;


select EmployeeID,Name as DoctorName,Position,apnt_count from
(select doctorId,count(*) as apnt_count from Appointment group by doctorId) t1
left join 
(select EmployeeID,Name,Position from doctor) t2
on t1.doctorId = t2.EmployeeID
order by apnt_count;

select Department,Name,dept_strength from
(select Department,count(distinct doctorId) as dept_strength from medical_departmets
where PrimaryDepartment = True group by Department) t1
left join 
(select DepartmentID,Name from department)t2 on t1.Department = t2.DepartmentID;

select EmployeeID,Department from doctor left join (medical_departmets)
on doctor.EmployeeID = medical_departmets.doctorId
where medical_departmets.PrimaryDepartment = True;


select Department,sum(apnt_count) from 
(select EmployeeID,Name as DoctorName,Position,apnt_count from
(select doctorId,count(*) as apnt_count from Appointment group by doctorId) t1
left join 
(select EmployeeID,Name,Position from doctor) t2
on t1.doctorId = t2.EmployeeID
order by apnt_count)a1
left joinā
(select EmployeeID,Department from doctor left join (medical_departmets)
on doctor.EmployeeID = medical_departmets.doctorIdā
where medical_departmets.PrimaryDepartment = True)a2
on a2.EmployeeID = a1.EmployeeID
group by Department;


select *, round((total_apnt/dept_strength),1) as apntPerDoc from(select Department,sum(apnt_count)as total_apnt from 
(select EmployeeID,Name as DoctorName,Position,apnt_count from
(select doctorId,count(*) as apnt_count from Appointment group by doctorId) t1
left join 
(select EmployeeID,Name,Position from doctor) t2
on t1.doctorId = t2.EmployeeID
order by apnt_count)a1
left join
(select EmployeeID,Department from doctor left join (medical_departmets)
on doctor.EmployeeID = medical_departmets.doctorId
where medical_departmets.PrimaryDepartment = True)a2
on a2.EmployeeID = a1.EmployeeID
group by Department) b1
left join 
(select Department,Name,dept_strength from
(select Department,count(distinct doctorId) as dept_strength from medical_departmets
where PrimaryDepartment = True group by Department) t1
left join 
(select DepartmentID,Name from department)t2 on t1.Department = t2.DepartmentID
)b2
on b1.Department = b2.Department;

 