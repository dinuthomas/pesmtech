use medicine;

select * from patient;

-- To find the patient distribution over doctors
select t1.ConsultingDoctor,t2.Name,t2.Position,
count(ConsultingDoctor) no_of_patients,
row_number() over(order by count(ConsultingDoctor))rowNumber,
round(cume_dist() over( order by count(ConsultingDoctor)),2) as CUME_DIST_DOC 
from patient t1
right join doctor t2 on t2.EmployeeID=t1.ConsultingDoctor
group by ConsultingDoctor
order by CUME_DIST_DOC;

###############################
-- Get the cumulative distribution of gender of patients visiting a particular doctor
select ConsultingDoctor,
max(case when sex='Female' then gender_count else 0 end) as female_count,
total-(max(case when sex='Female' then gender_count else 0 end)) as male_count,
total, max(case when sex='Female' then gender else 0 end) as female,
max(case when sex='Male' then gender else 0 end) as male 
from (select ConsultingDoctor, sex,
count(sex) over(partition by ConsultingDoctor order by sex) gender_count,
count(sex) over(partition by ConsultingDoctor) total,
cume_dist() over(partition by ConsultingDoctor order by sex)gender
from patient order by ConsultingDoctor)t
group by ConsultingDoctor;


##############################
-- Find specialization which has highest number of patients

select (position)specialization, sum(no_of_patients)patients_count,
row_number() over(order by sum(no_of_patients))rowNumber,
round(cume_dist() over( order by sum(no_of_patients)),2) as CUME_DIST_DOC
from (select t1.ConsultingDoctor,t2.Position,
count(ConsultingDoctor) no_of_patients from patient t1
right join doctor t2 on t2.EmployeeID=t1.ConsultingDoctor
group by ConsultingDoctor)t
group by Position order by CUME_DIST_DOC;


