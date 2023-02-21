SELECT course_id, sec_id, semester, year, COUNT(*) AS enrolment
FROM takes
GROUP BY course_id, sec_id, semester, year
HAVING COUNT(*) = (
    SELECT MAX(enrolment)
    FROM (
        SELECT COUNT(*) as enrolment 
        FROM takes 
        GROUP BY course_id, sec_id, semester, year 
        HAVING COUNT(*) > 0
    ) AS enrolment_counts
);
