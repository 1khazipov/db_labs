SELECT MAX(COALESCE(enr, 0)) AS maximum, MIN(COALESCE(enr, 0)) AS minimum
FROM (SELECT COUNT (*) AS enr
      FROM takes
      GROUP BY course_id, sec_id, semester, year
     ) AS enrolments;
