WITH first_lesson_completed AS (
    SELECT 
        finished_lesson_test.user_id,
        MIN(finished_lesson_test.date_created) AS first_lesson_date
    FROM 
        finished_lesson_test
    JOIN 
        lesson_index_test ON finished_lesson_test.lesson_id = lesson_index_test.lesson_id
    WHERE 
        lesson_index_test.profession_name = 'data-analyst'
        AND lesson_index_test.profession_id = 'April 2020 cohort'
        AND finished_lesson_test.date_created BETWEEN '2020-04-01' AND '2020-04-30'
    GROUP BY 
        finished_lesson_test.user_id
),
completed_lessons AS (
    SELECT 
        finished_lesson_test.id,
        finished_lesson_test.user_id,
        finished_lesson_test.date_created,
        finished_lesson_test.lesson_id,
        lesson_index_test.profession_name,
        lesson_index_test.profession_id,
        LEAD(finished_lesson_test.date_created) OVER (PARTITION BY finished_lesson_test.user_id ORDER BY finished_lesson_test.date_created) AS next_lesson_datetime,
        strftime('%s', LEAD(finished_lesson_test.date_created) OVER (PARTITION BY finished_lesson_test.user_id ORDER BY finished_lesson_test.date_created)) - strftime('%s', finished_lesson_test.date_created) AS delta_seconds
    FROM 
        finished_lesson_test
    JOIN 
        lesson_index_test ON finished_lesson_test.lesson_id = lesson_index_test.lesson_id
    JOIN 
        first_lesson_completed ON finished_lesson_test.user_id = first_lesson_completed.user_id
    WHERE 
        finished_lesson_test.date_created BETWEEN '2020-04-01' AND '2020-04-30'
)
SELECT 
    *
FROM 
    completed_lessons
WHERE 
    delta_seconds < 5;
