SELECT MAX(COALESCE(enrolment, 0)) AS maximum, 
	   MIN(COALESCE(enrolment, 0)) AS minimum 
FROM (
    SELECT s.course_id, s.sec_id, s.semester, s.year, COUNT(takes.ID) AS 
enrolment 
    FROM SECTION s 
		LEFT JOIN takes ON s.course_id = takes.course_id 
						AND s.sec_id = 
takes.sec_id 
						AND s.semester = 
takes.semester 
						AND s.year = takes.year
    GROUP BY s.course_id, s.sec_id, s.semester, s.year
	) AS enrolment_counts;
