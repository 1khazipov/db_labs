SELECT course_id, sec_id, COUNT(*) AS enrolment
FROM takes
WHERE semester = 'Fall' AND year = 2022
GROUP BY course_id, sec_id;
