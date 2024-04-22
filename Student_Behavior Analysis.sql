  SELECT *
  FROM Student_Behavior

ALTER TABLE Student_Behavior
ADD Old_Avg_Academic_Performance as (_10th_Mark + _12th_Mark + college_mark) / 3 PERSISTED;

ALTER TABLE Student_Behavior
DROP COLUMN Avg_Academic_Performance

--to duplicate the table
SELECT *
INTO Student_Behaviors
FROM Student_Behavior

--To generate and add a new column permanently for average performance:
--find the average of their overall performance from 10th mark, 12th mark and college mark
--add up the 3 marks and divide by 3 to find the average performance of each 
ALTER TABLE Student_Behavior
ADD N_Avg_Academic_Performance as ROUND((_10th_Mark + _12th_Mark + college_mark) / 3, 0) PERSISTED;

-- How does the daily studying time affect academic performance?
  SELECT daily_studing_time, AVG(N_Avg_Academic_Performance) AS A_avg_Performance
  FROM Student_Behavior
  GROUP BY daily_studing_time
  ORDER BY A_avg_Performance DESC
  --the students with longer studying time perform better than those with short studying time.

  -- Does the type of hobbies correlate with academic performance?
  SELECT DISTINCT hobbies, SUM (N_Avg_Academic_Performance) AS Sum_Of_Perfomance
  FROM Student_Behavior
  GROUP BY hobbies
  ORDER BY Sum_Of_Perfomance DESC
  --Students who play sports perform the highest while students who play video games have the lowest performance

  -- Is there a difference in academic performance between genders
  SELECT DISTINCT Gender, SUM (N_Avg_Academic_Performance) AS Sum_Of_Perfomance
  FROM Student_Behavior
  GROUP BY Gender
  ORDER BY Sum_Of_Perfomance DESC
  --the male students perform better by the female students overall
  
  -- How does stress level correlate with academic performance?
  SELECT Stress_Level, SUM (N_Avg_Academic_Performance) AS Sum_Of_Perfomance
  FROM Student_Behavior
  GROUP BY Stress_Level
  ORDER BY Sum_Of_Perfomance DESC
  --Students with a good stress level have the highest performance while 
  --students with a fabulous stress level have the lowest performance

  SELECT *
  FROM Student_Behavior

  -- Are students who like their degree more likely to pursue a career based on it?
  --using a case statement to extract the 0s and 1s to state if students like their degrees
SELECT willingness_to_pursue_a_career_based_on_their_degree,
  CASE WHEN Do_you_like_your_degree = 0 THEN 'Do not like degree'
       WHEN Do_you_like_your_degree = 1 THEN 'like degree'
      END AS Likeness_of_Degree
  FROM Student_Behavior
  ORDER BY willingness_to_pursue_a_career_based_on_their_degree DESC
  --majority of the students who are willing to pursue a career based on their degree like their degree

  -- Do students with higher salary expectations tend to like their degree more?
  --using a case statement to extract the 0s and 1s to state if students like their degrees
  SELECT TOP(10) salary_expectation,
  CASE WHEN Do_you_like_your_degree = 0 THEN 'Do not like degree'
       WHEN Do_you_like_your_degree = 1 THEN 'like degree'
      END AS Likeness_of_Degree
  FROM Student_Behavior
  ORDER BY salary_expectation DESC
  --majority of the students with high salary expectations like their degree

  -- How does the department of study influence the willingness to pursue a career based on the degree?
  SELECT Department, willingness_to_pursue_a_career_based_on_their_degree
  FROM Student_Behavior
  ORDER BY willingness_to_pursue_a_career_based_on_their_degree DESC
  --most students in BCA, commerce and B.comm are willing to pursue a career based on their degree

  --compare the salary expectation of students studying a certificate and non-certificate course
  --using a case statement to extract the 0s and 1s to state if students are studying a certificate course
  SELECT TOP(10) salary_expectation,
  CASE WHEN Certification_Course = 0 THEN 'Non-certificate course'
       WHEN Certification_Course = 1 THEN 'Certificate course'
      END AS Course_Type
  FROM Student_Behavior
  ORDER BY salary_expectation DESC
  --majority of the students with high salary expectation are studying a certificate course
  
  SELECT *
  FROM Student_Behavior

  --In what department do we find the highest college marks?
  SELECT Department, college_mark
  FROM Student_Behavior
  ORDER BY college_mark DESC
  --we find the highest college mark from the commerce department with an overall score of 100

  --What is the relationship between students with part time jobs and their financial status
  --using a case statement to extract the 0s and 1s to state if students have a part time job
  --use a subquery to count the number of students with a part time job according to their financial status
  SELECT financial_status, COUNT(Job_Status) AS No_of_Job_Status
  FROM (
  SELECT financial_status,
   CASE WHEN part_time_job = 0 THEN 'no part time job'
       WHEN part_time_job = 1 THEN 'part time job'
      END AS Job_Status
	  FROM Student_Behavior) AS SUBT
	  WHERE Job_Status = 'part time job'
	  GROUP BY financial_status
	  ORDER BY  No_of_Job_Status
	  --most of the students with a part time job have a good financial status

  --How does the students travelling time affect their college mark?
  SELECT Travelling_Time, ROUND(SUM(college_mark), 0) AS Sum_of_college_mark
  FROM Student_Behavior
  GROUP BY Travelling_Time
  ORDER BY Sum_of_college_mark DESC
  --Students that travel within 30-60 minutes have the highest college mark while those 
  --that travel longer (2.30-more than 3 hours) have the lowest college mark
  
  --Does the students height and weight affect their academic performance?
  SELECT Height_CM, Weight_KG, SUM (N_Avg_Academic_Performance) AS Sum_Of_Perfomance
  FROM Student_Behavior
  GROUP BY Height_CM, Weight_KG
  ORDER BY Sum_Of_Perfomance DESC
  --the height and weight of the students does not affect their academic performance

  --What department has the lowest college mark?
  SELECT Department, ROUND(SUM(college_mark),0) AS Sum_of_college_mark
  FROM Student_Behavior
  GROUP BY Department
  ORDER BY Sum_of_college_mark DESC
  --BCA department has the highest college mark