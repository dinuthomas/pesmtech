use medicine;

SELECT doctorId,patient, START, END, DENSE_RANK() OVER (
		PARTITION   BY  doctorId
        ORDER BY START,patient
    ) my_rank from Appointment ;
 