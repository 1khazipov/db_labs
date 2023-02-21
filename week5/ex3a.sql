SELECT MAX(enrolment) AS maximum, MIN(enrolment) AS minimum 
FROM (SELECT 
        (
		SELECT COUNT(*) 
		FROM takes
		WHERE s.course_id = takes.course_id 
			AND s.sec_id = takes.sec_id 
			AND s.semester = takes.semester 
			AND s.year = takes.year) AS enrolment 
    FROM SECTION s
	) AS enrolment_counts;
