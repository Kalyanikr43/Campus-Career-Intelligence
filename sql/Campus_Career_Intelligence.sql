CREATE DATABASE campus_career_intelligence;
USE campus_career_intelligence;

SELECT COUNT(*) AS total_students
FROM student_placement;

SELECT *
FROM student_placement
LIMIT 10;

DESCRIBE Student_placement;

SELECT placement_status,COUNT(*) AS students
FROM student_placement
GROUP BY placement_status;

SELECT COUNT(*) AS missing_placement_status
FROM student_placement
WHERE placement_status IS NULL;

-- Analysis 1: Overall Placement Performance
SELECT
	COUNT(*) AS total_students,
    SUM(CASE WHEN placement_status = 1 THEN 1 
ELSE 0 END) AS placed_students,
	SUM(CASE WHEN placement_status = 0 THEN 1 
ELSE 0 END) AS not_placed_students,
	ROUND(
		100.0 * SUM(CASE WHEN placement_status = 1
THEN 1 ELSE 0 END) / COUNT(*),
	2
 ) AS placement_rate
FROM student_placement;

-- Analysis 2: Placement by CGPA Band
SELECT
	cgpa_band,
    COUNT(*) AS total_students,
    SUM(CASE WHEN placement_status = 1 THEN 1
ELSE 0 END) AS placed_students,
	ROUND(
		100.0 * SUM(CASE WHEN placement_status = 1
THEN 1 ELSE 0 END) / COUNT(*),
		2
	) AS placement_rate
FROM student_placement
GROUP BY cgpa_band
ORDER BY cgpa_band;

-- Analysis 3: Placement by Internship Category
SELECT 
	internship_category,
    COUNT(*) AS total_students,
    SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END) AS placed_students,
    ROUND(100.0 * SUM(CASE WHEN placement_status = 1 THEN 1 Else 0 END) / COUNT(*),2)
    AS placement_rate
FROM student_placement
GROUP BY internship_category
ORDER BY placement_rate DESC;

-- Analysis 4: Placement by Project Category
SELECT 
	CASE
		WHEN live_projects = 0 THEN 'No Projects'
        WHEN live_projects = 1 THEN '1 Project'
        ELSE '2+ Projects'
	END AS project_category,
    
    COUNT(*) AS total_students,
    SUM(
		CASE
			WHEN placement_status = 1 THEN 1
            ELSE 0
		END
	) AS placed_students,
    
    ROUND(
		100.0 * SUM(
			CASE
				WHEN placement_status = 1 THEN 1
                ELSE 0
			END
		) / COUNT(*),
        2
	) AS placement_rate
FROM student_placement
GROUP BY 
	CASE
		WHEN live_projects = 0 THEN 'No Projects'
        WHEN live_projects = 1 THEN '1 Project'
        Else '2+ Projects'
	END
ORDER BY placement_rate DESC;

-- Analysis 5: 
SELECT
	CASE
		WHEN technical_skill_score < 50 THEN
	'Below 50'
		WHEN technical_skill_score < 60 THEN
	'50-59'
		WHEN technical_skill_score < 70 THEN
	'60-69'
		WHEN technical_skill_score < 80 THEN
	'70-79'
		WHEN technical_skill_score < 90 THEN
	'80-89'
		ELSE '90+'
	    END AS technical_skill_band,
        COUNT(*) AS total_students,
        SUM(
			CASE
               WHEN placement_status = 1 THEN 1
               ELSE 0
			END
		) AS placed_students,
        ROUND(
			100.0 * SUM(
				CASE
					WHEN placement_status = 1 THEN 1
                    ELSE 0
                    END
				) / COUNT(*),2 ) AS placement_rate
		FROM student_placement
        
        GROUP BY 
			CASE
				WHEN technical_skill_score < 50 THEN
			'Below 50'
				WHEN technical_skill_score < 60 THEN
			'50-59'
				WHEN technical_skill_score < 70 THEN
			'60-69'
				WHEN technical_skill_score < 80 THEN
			'70-79'
				WHEN technical_skill_score < 90 THEN
			'80-89'
				ELSE '90+'
			END
		ORDER BY placement_rate DESC;

-- Analysis 6: Placement by soft skill band
SELECT
	CASE
		WHEN soft_skill_score < 50 Then 'Below 50'
        WHEN soft_skill_score < 60 Then '50-59'
        WHEN soft_skill_score < 70 Then '60-69'
        WHEN soft_skill_score < 80 Then '70-79'
        WHEN soft_skill_score < 90 Then '80-89'
        ELSE '90+'
	END AS soft_skill_band,
    COUNT(*) AS total_students,
    SUM(
		CASE
			WHEN placement_status  = 1 THEN 1
            ELSE 0
		END
	) AS placed_students,
    ROUND(
		100.0 * SUM(
		CASE
			WHEN placement_status = 1 THEN 1
			ELSE 0
		END
		) / COUNT(*),2 ) AS placement_rate
	FROM student_placement
    GROUP BY
    CASE
		WHEN soft_skill_score < 50 Then 'Below 50'
        WHEN soft_skill_score < 60 Then '50-59'
        WHEN soft_skill_score < 70 Then '60-69'
        WHEN soft_skill_score < 80 Then '70-79'
        WHEN soft_skill_score < 90 Then '80-89'
        ELSE '90+'
	END
ORDER BY placement_rate DESC;

-- Analysis 7: Placement by Attendance Band
SELECT
	CASE
		WHEN attendance_percentage < 60 Then 'Below 60%'
        WHEN attendance_percentage < 70 Then '60-69%'
        WHEN attendance_percentage < 80 Then '70-79%'
        WHEN attendance_percentage < 90 Then '80-89%'
        
        ELSE '90%+'
	END AS attendance_band,
    COUNT(*) AS total_students,
    SUM(
		CASE
			WHEN placement_status  = 1 THEN 1
            ELSE 0
		END
	) AS placed_students,
    ROUND(
		100.0 * SUM(
		CASE
			WHEN placement_status = 1 THEN 1
			ELSE 0
		END
		) / COUNT(*),2 ) AS placement_rate
	FROM student_placement
    GROUP BY
    CASE
		WHEN attendance_percentage < 60 Then 'Below 60%'
        WHEN attendance_percentage < 70 Then '60-69%'
        WHEN attendance_percentage < 80 Then '70-79%'
        WHEN attendance_percentage < 90 Then '80-89%'
        
        ELSE '90%+'
	END
ORDER BY placement_rate DESC;

-- Analysis 8: Placements by Backlog Category
SELECT
	CASE
		WHEN backlogs = 0  Then 'No Backlogs'
        WHEN backlogs = 1 Then '1 Backlog'
        WHEN backlogs = 2 Then '2 Backlogs'
        ELSE '3+ Backlogs'
	END AS backlog_category,
    COUNT(*) AS total_students,
    SUM(
		CASE
			WHEN placement_status  = 1 THEN 1
            ELSE 0
		END
	) AS placed_students,
    ROUND(
		100.0 * SUM(
		CASE
			WHEN placement_status = 1 THEN 1
			ELSE 0
		END
		) / COUNT(*),2 ) AS placement_rate
	FROM student_placement
    GROUP BY
   CASE
		WHEN backlogs = 0  Then 'No Backlogs'
        WHEN backlogs = 1 Then '1 Backlog'
        WHEN backlogs = 2 Then '2 Backlogs'
        ELSE '3+ Backlogs'
	END
ORDER BY placement_rate DESC;

-- Analysis 9:Placement by Extracurricular Activities
SELECT
	extracurricular_activities,
    COUNT(*) AS total_students,
    
    SUM(
		CASE
			WHEN placement_status = 1 THEN 1
            ELSE 0
		eND
	) AS placed_students,
	ROUND(
		100.0 * SUM(
		CASE
			WHEN placement_status = 1 THEN 1
			ELSE 0
		END
		) / COUNT(*),2 ) AS placement_rate
	FROM student_placement
GROUP BY extracurricular_activities
ORDER BY placement_rate DESC;
    
-- Analysis 10: Average Salary by CGPA Band
SELECT
	cgpa_band,
    COUNT(*) AS placed_students,
    ROUND(AVG(salary_package_lpa),2) AS average_salary_lpa,
    ROUND(MAX(salary_package_lpa),2) AS highest_salary_lpa,
    ROUND(MIN(salary_package_lpa),2) AS lowest_salary_lpa
FROM student_placement
WHERE placement_status = 1
GROUP BY cgpa_band
ORDER BY average_salary_lpa DESC;

-- Analysis 11: Average Salary by Internship
SELECT
	Internship_category,
    COUNT(*) AS placed_students,
    ROUND(AVG(salary_package_lpa),2) AS average_salary_lpa,
    ROUND(MAX(salary_package_lpa),2) AS highest_salary_lpa,
    ROUND(MIN(salary_package_lpa),2) AS lowest_salary_lpa
FROM student_placement
WHERE placement_status = 1
GROUP BY InternshiP_category
ORDER BY average_salary_lpa DESC;

-- Analysis 12: Placement Risk Segmentation
SELECT
    student_id,
    cgpa,
    technical_skill_score,
    internship_count,
    live_projects,
    backlogs,
    placement_status,

    CASE
        WHEN cgpa < 7
             AND technical_skill_score < 60
             AND internship_count = 0
             AND live_projects = 0
             AND backlogs >= 2
        THEN 'High Risk'

        WHEN (
             cgpa < 7
             AND technical_skill_score < 70
             )
             OR internship_count = 0
             OR backlogs >= 2
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS placement_risk

FROM student_placement;
USE college;

ALTER TABLE student_placement
CHANGE COLUMN `ï»¿student_id` student_id INT;
USE campus_career_intelligence;
SELECT
    CASE
        WHEN cgpa < 7
             AND technical_skill_score < 60
             AND internship_count = 0
             AND live_projects = 0
             AND backlogs >= 2
        THEN 'High Risk'

        WHEN (
             cgpa < 7
             AND technical_skill_score < 70
             )
             OR internship_count = 0
             OR backlogs >= 2
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END AS placement_risk,

    COUNT(*) AS total_students,

    SUM(
        CASE
            WHEN placement_status = 1 THEN 1
            ELSE 0
        END
    ) AS placed_students,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN placement_status = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS placement_rate

FROM student_placement

GROUP BY
    CASE
        WHEN cgpa < 7
             AND technical_skill_score < 60
             AND internship_count = 0
             AND live_projects = 0
             AND backlogs >= 2
        THEN 'High Risk'

        WHEN (
             cgpa < 7
             AND technical_skill_score < 70
             )
             OR internship_count = 0
             OR backlogs >= 2
        THEN 'Medium Risk'

        ELSE 'Low Risk'
    END

ORDER BY placement_rate;

SELECT
    COUNT(*) AS total_students,
    SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END) AS placed_students,
    SUM(CASE WHEN placement_status = 0 THEN 1 ELSE 0 END) AS not_placed_students,
    ROUND(
        100.0 * SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS overall_placement_rate
FROM student_placement;

SELECT
    cgpa_band,
    COUNT(*) AS total_students,
    SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END) AS placed_students,
    ROUND(
        100.0 * SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS placement_rate
FROM student_placement
GROUP BY cgpa_band
ORDER BY placement_rate DESC;

SELECT
    internship_category,
    COUNT(*) AS total_students,
    SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END) AS placed_students,
    ROUND(
        100.0 * SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS placement_rate
FROM student_placement
GROUP BY internship_category
ORDER BY placement_rate DESC;

-- Step 13.4: Technical Skills and Placement

SELECT
    CASE
        WHEN technical_skill_score < 50 THEN 'Below 50'
        WHEN technical_skill_score < 60 THEN '50-59'
        WHEN technical_skill_score < 70 THEN '60-69'
        WHEN technical_skill_score < 80 THEN '70-79'
        WHEN technical_skill_score < 90 THEN '80-89'
        ELSE '90+'
    END AS technical_skill_band,

    COUNT(*) AS total_students,

    SUM(
        CASE
            WHEN placement_status = 1 THEN 1
            ELSE 0
        END
    ) AS placed_students,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN placement_status = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS placement_rate

FROM student_placement

GROUP BY
    CASE
        WHEN technical_skill_score < 50 THEN 'Below 50'
        WHEN technical_skill_score < 60 THEN '50-59'
        WHEN technical_skill_score < 70 THEN '60-69'
        WHEN technical_skill_score < 80 THEN '70-79'
        WHEN technical_skill_score < 90 THEN '80-89'
        ELSE '90+'
    END

ORDER BY placement_rate DESC;

-- Step 13.5: Backlogs and Placement

SELECT
    CASE
        WHEN backlogs = 0 THEN 'No Backlogs'
        WHEN backlogs = 1 THEN '1 Backlog'
        WHEN backlogs = 2 THEN '2 Backlogs'
        ELSE '3+ Backlogs'
    END AS backlog_category,

    COUNT(*) AS total_students,

    SUM(
        CASE
            WHEN placement_status = 1 THEN 1
            ELSE 0
        END
    ) AS placed_students,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN placement_status = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS placement_rate

FROM student_placement

GROUP BY
    CASE
        WHEN backlogs = 0 THEN 'No Backlogs'
        WHEN backlogs = 1 THEN '1 Backlog'
        WHEN backlogs = 2 THEN '2 Backlogs'
        ELSE '3+ Backlogs'
    END

ORDER BY placement_rate DESC;

SELECT
    CASE
        WHEN backlogs = 0 THEN 'No Backlogs'
        WHEN backlogs = 1 THEN '1 Backlog'
        WHEN backlogs = 2 THEN '2 Backlogs'
        ELSE '3+ Backlogs'
    END AS backlog_category,

    COUNT(*) AS total_students,

    SUM(
        CASE
            WHEN placement_status = 1 THEN 1
            ELSE 0
        END
    ) AS placed_students,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN placement_status = 1 THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS placement_rate

FROM student_placement

GROUP BY
    CASE
        WHEN backlogs = 0 THEN 'No Backlogs'
        WHEN backlogs = 1 THEN '1 Backlog'
        WHEN backlogs = 2 THEN '2 Backlogs'
        ELSE '3+ Backlogs'
    END;
    
SELECT
    extracurricular_activities,
    COUNT(*) AS total_students,
    SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END) AS placed_students,
    ROUND(
        100.0 * SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS placement_rate
FROM student_placement
GROUP BY extracurricular_activities
ORDER BY placement_rate DESC;


    
			
        


