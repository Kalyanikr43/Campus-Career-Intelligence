-- ============================================================
-- CAMPUS CAREER INTELLIGENCE
-- Student Placement Analytics
-- ============================================================

-- Create and select database
CREATE DATABASE IF NOT EXISTS campus_career_intelligence;
USE campus_career_intelligence;


-- ============================================================
-- DATASET VALIDATION
-- ============================================================

-- Check total number of students
SELECT COUNT(*) AS total_students
FROM student_placement;

-- View sample records
SELECT *
FROM student_placement
LIMIT 10;

-- View table structure
DESCRIBE student_placement;

-- Check placement status distribution
SELECT
    placement_status,
    COUNT(*) AS students
FROM student_placement
GROUP BY placement_status;

-- Check missing placement status
SELECT
    COUNT(*) AS missing_placement_status
FROM student_placement
WHERE placement_status IS NULL;


-- ============================================================
-- ANALYSIS 1: OVERALL PLACEMENT PERFORMANCE
-- ============================================================

SELECT
    COUNT(*) AS total_students,
    SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END)
        AS placed_students,
    SUM(CASE WHEN placement_status = 0 THEN 1 ELSE 0 END)
        AS not_placed_students,
    ROUND(
        100.0 * SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS placement_rate
FROM student_placement;


-- ============================================================
-- ANALYSIS 2: PLACEMENT BY CGPA BAND
-- ============================================================

SELECT
    cgpa_band,
    COUNT(*) AS total_students,
    SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END)
        AS placed_students,
    ROUND(
        100.0 * SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS placement_rate
FROM student_placement
GROUP BY cgpa_band
ORDER BY placement_rate DESC;


-- ============================================================
-- ANALYSIS 3: PLACEMENT BY INTERNSHIP CATEGORY
-- ============================================================

SELECT
    Internship_category,
    COUNT(*) AS total_students,
    SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END)
        AS placed_students,
    ROUND(
        100.0 * SUM(CASE WHEN placement_status = 1 THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS placement_rate
FROM student_placement
GROUP BY Internship_category
ORDER BY placement_rate DESC;


-- ============================================================
-- ANALYSIS 4: PLACEMENT BY PROJECT CATEGORY
-- ============================================================

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
        ELSE '2+ Projects'
    END

ORDER BY placement_rate DESC;


-- ============================================================
-- ANALYSIS 5: PLACEMENT BY TECHNICAL SKILL BAND
-- ============================================================

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


-- ============================================================
-- ANALYSIS 6: PLACEMENT BY SOFT SKILL BAND
-- ============================================================

SELECT
    CASE
        WHEN soft_skill_score < 50 THEN 'Below 50'
        WHEN soft_skill_score < 60 THEN '50-59'
        WHEN soft_skill_score < 70 THEN '60-69'
        WHEN soft_skill_score < 80 THEN '70-79'
        WHEN soft_skill_score < 90 THEN '80-89'
        ELSE '90+'
    END AS soft_skill_band,

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
        WHEN soft_skill_score < 50 THEN 'Below 50'
        WHEN soft_skill_score < 60 THEN '50-59'
        WHEN soft_skill_score < 70 THEN '60-69'
        WHEN soft_skill_score < 80 THEN '70-79'
        WHEN soft_skill_score < 90 THEN '80-89'
        ELSE '90+'
    END

ORDER BY placement_rate DESC;


-- ============================================================
-- ANALYSIS 7: PLACEMENT BY ATTENDANCE BAND
-- ============================================================

SELECT
    CASE
        WHEN attendance_percentage < 60 THEN 'Below 60%'
        WHEN attendance_percentage < 70 THEN '60-69%'
        WHEN attendance_percentage < 80 THEN '70-79%'
        WHEN attendance_percentage < 90 THEN '80-89%'
        ELSE '90%+'
    END AS attendance_band,

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
        WHEN attendance_percentage < 60 THEN 'Below 60%'
        WHEN attendance_percentage < 70 THEN '60-69%'
        WHEN attendance_percentage < 80 THEN '70-79%'
        WHEN attendance_percentage < 90 THEN '80-89%'
        ELSE '90%+'
    END

ORDER BY placement_rate DESC;


-- ============================================================
-- ANALYSIS 8: PLACEMENT BY BACKLOG CATEGORY
-- ============================================================

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


-- ============================================================
-- ANALYSIS 9: PLACEMENT BY EXTRACURRICULAR ACTIVITIES
-- ============================================================

SELECT
    extracurricular_activities,
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

GROUP BY extracurricular_activities

ORDER BY placement_rate DESC;


-- ============================================================
-- ANALYSIS 10: AVERAGE SALARY BY CGPA BAND
-- ============================================================

SELECT
    cgpa_band,
    COUNT(*) AS placed_students,
    ROUND(AVG(salary_package_lpa), 2) AS average_salary_lpa,
    ROUND(MAX(salary_package_lpa), 2) AS highest_salary_lpa,
    ROUND(MIN(salary_package_lpa), 2) AS lowest_salary_lpa

FROM student_placement

WHERE placement_status = 1

GROUP BY cgpa_band

ORDER BY average_salary_lpa DESC;


-- ============================================================
-- ANALYSIS 11: AVERAGE SALARY BY INTERNSHIP CATEGORY
-- ============================================================

SELECT
    Internship_category,
    COUNT(*) AS placed_students,
    ROUND(AVG(salary_package_lpa), 2) AS average_salary_lpa,
    ROUND(MAX(salary_package_lpa), 2) AS highest_salary_lpa,
    ROUND(MIN(salary_package_lpa), 2) AS lowest_salary_lpa

FROM student_placement

WHERE placement_status = 1

GROUP BY Internship_category

ORDER BY average_salary_lpa DESC;


-- ============================================================
-- ANALYSIS 12: PLACEMENT RISK SEGMENTATION
-- ============================================================

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
