For Task 1 I have generated dummy datasets finished_lesson_test.csv and lesson_index_test.csv to work with.


By taking a look at our dataset we observe that we have two data tables that are related to each other with one common column lesson_id. We have the table that contains the records of the completed lessons of each user, lesson_id, and the date created. The other table contains the professions(cohort), lesson_id and the profession name.


We need to select those professions that are data analyst, and belong to the 2020 time frame. And then we need to sort them from the earliest to latest, and then calculate the time differences between the two consecutive courses of the same user.
We create a new table where the cases are recorded as the lesson_id, user_id and the delta time of a lesson.


The SQL query presented below is designed to analyze completed lessons within the "data-analyst April 2020 cohort" and identify instances where users completed consecutive lessons within a given timeframe of 5 seconds. 


Query overview


The first part of the query defines a Common Table Expression (CTE) named first_lesson_completion.
It selects the user ID and the minimum completion date for the first lesson completed by each user in the "data-analyst April 2020 cohort".
It joins the finished_lesson_test table with the lesson_index_test table based on the lesson ID.
It filters lessons only for the "data-analyst" profession in the "April 2020 cohort".
It groups the results by user ID.


Secondly
This CTE is named lesson_completion_times.
It selects various fields from the finished_lesson_test table and adds the details of the next lesson using the LEAD window function.
It joins the finished_lesson_test table with the lesson_index_test table based on the lesson ID.

Finally
The main query selects fields from the lesson_completion_times CTE.
It joins the lesson_completion_times CTE with the first_lesson_completion CTE on the user ID to filter only the first lesson completion for each user in the "data-analyst April 2020 cohort".
It filters records where the time difference between consecutive lessons is less than 5 seconds.
It calculates the time difference between the current lesson's completion date and the next lesson's completion date using the TIMESTAMP_DIFF function.


Returns the filtered results, providing a report of cases where users completed consecutive lessons with a very short time interval (less than 5 seconds), which could indicate potential issues or errors in data recording or user behavior.

