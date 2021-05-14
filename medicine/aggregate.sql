/**
* The aggregate queries for medicine project. 
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


select doctorId,Department,count(*) as dept_strength from medical_departmets
where PrimaryDepartment = True group by Department;


# The SUM() and AVG() aggregate functions do not work with temporal values
select EmployeeID,Name as DoctorName,Position,
count(*) as apnt_count,
avg(time_to_sec(timediff(End,Start))/60) as avgConTime
from Appointment as t1 left join  doctor t2 on t1.doctorId = t2.EmployeeID
group by t1.doctorId order by avgConTime desc;

select EmployeeID,Name as DoctorName,Position,
count(*) as apnt_count,
avg(timediff(End,Start)) as avgConTime
from Appointment as t1 left join  doctor t2 on t1.doctorId = t2.EmployeeID
group by t1.doctorId order by avgConTime desc;


select AppointmentID,doctorId,
((time_to_sec(End)-time_to_sec(Start))/60) as conTime,
time_to_sec(timediff(End,Start))/60 as conTime2,
avg(End-start) as conTime3
from Appointment
where doctorId = 68;

select AppointmentID,doctorId,
((time_to_sec(End)-time_to_sec(Start))/60) as conTime
from Appointment
where doctorId between 69 and 20;


select do.EmployeeID,do.Name, Department,
group_concat(de.Name) as serving_depts
from doctor do,medical_departmets md, department de
where do.EmployeeID = md.doctorId and md.Department = de.DepartmentID 
group by do.EmployeeID having serving_depts like '%,%';


select do.EmployeeID,do.Name, Department,de.Head,
group_concat(de.Name) as ser_depts_form1,
json_arrayagg(de.Name) as ser_depts_form2
from doctor do,medical_departmets md, department de
where do.EmployeeID = md.doctorId and md.Department = de.DepartmentID 
group by do.EmployeeID;

select Department, Head,doc.Name as HeadName,
json_objectagg(emp,DocName) as subord_id_name
from
(select do.EmployeeID as emp,do.Name as DocName, Department,de.Head as Head
from doctor do,medical_departmets md, department de
where do.EmployeeID = md.doctorId and md.Department = de.DepartmentID 
) as detail left join doctor doc on detail.Head = doc.EmployeeID
group by Head;


select EmployeeID,Name as DoctorName,Position,
count(*) as apnt_count,
round(max(time_to_sec(timediff(End,Start))/60),1) as max_consult,
round(min(time_to_sec(timediff(End,Start))/60),1) as min_consult,
round(stddev_samp(time_to_sec(timediff(End,Start))/60),1) as std_deviaton,
round(var_samp(time_to_sec(timediff(End,Start))/60),1) as variance,
avg(time_to_sec(timediff(End,Start))/60) as avgConTime
from Appointment as t1 left join  doctor t2 on t1.doctorId = t2.EmployeeID
group by t1.doctorId order by avgConTime desc;


select EmployeeID,Name as DoctorName,Position,
count(*) as apnt_count,
round(avg(time_to_sec(timediff(End,Start))/60),1) as avg_consult
from Appointment as t1 left join  doctor t2 on t1.doctorId = t2.EmployeeID
group by t1.doctorId having avg_consult < 
(select round(avg(time_to_sec(timediff(End,Start))/60),1) as tot_avg_consult
from Appointment) order by avg_consult asc;


select EmployeeID,Name as DoctorName,Position,
count(AppointmentID) as apnt_count,
round(avg(time_to_sec(timediff(End,Start))/60),1) as avg_consult
from Appointment as t1 left join  doctor t2 on t1.doctorId = t2.EmployeeID
group by t1.doctorId having avg_consult < 
(select round(avg(time_to_sec(timediff(End,Start))/60),1) as tot_avg_consult
from Appointment) order by avg_consult asc;









 