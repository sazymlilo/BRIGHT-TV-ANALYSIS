select * from `workspace`.`bright_tv`.`viewership` limit 100;

with cte1 AS (
SELECT UserID,
CASE WHEN Province = 'None' THEN 'Uncategorised'
     WHEN Province = ' ' THEN 'Uncategorised'
     ELSE Province 
     END AS Region,
CASE
        WHEN Race IN ('other') THEN 'None'
        WHEN Race = ' ' THEN 'None'
        ELSE Race
    END AS Ethnic_groups, 

age,
 CASE
     WHEN AGE = 0 THEN 'Infacts'
     WHEN AGE BETWEEN 1 AND 12 THEN 'Kids'
     WHEN AGE BETWEEN 13 AND 19 THEN 'Teenagers'
     WHEN AGE BETWEEN 20 AND 39 THEN 'Young Adults'
     WHEN AGE BETWEEN 40 AND 60 THEN 'Adults'
     WHEN AGE > 61 THEN 'PENSIONERS'
     end as age_groups,

 CASE WHEN Gender = ' ' THEN 'None'
    ELSE Gender
    end AS Gender,

CASE
WHEN (Email IS NULL) OR (Email <> ' ') OR (Email NOT IN ('None')) THEN 1
ELSE 0
END AS email_flag,

CASE
WHEN (`Social Media Handle` IS NOT NULL) OR (`Social Media Handle` = ' ') OR (`Social Media Handle` NOT IN ('None')) THEN 1
ELSE 0
END AS sm_flag

FROM workspace.bright_tv.user_profile
),


 cte2 AS(
select 
COALESCE (userID0, userid4) AS UserID,
TO_DATE(RecordDate2) AS watch_date,--------------------------------------extract date from the timestamp
TO_CHAR(TO_DATE(RecordDate2),'yyyyMM') AS month_id,-------------------------------converts date into a string

DATE_FORMAT(RecordDate2, 'HH:mm:ss') AS watch_time,
DATE_FORMAT(RecordDate2, 'EEE') AS day_of_week,
DAYNAME(RecordDate2) AS day_name, ------------------------------------------converts a string into a date

CASE  WHEN DATE_FORMAT(RecordDate2, 'EEEE') IN ('Saturday', 'Sunday') THEN 'Weekend'
ELSE 'Weekday'
END AS day_classification,

HOUR(RecordDate2) AS watch_hour,

CASE
WHEN channel2 IN ('SawSee', 'Sawsee')THEN 'SawSee'
WHEN channel2 IN ('Supersport Live Events', 'Live on Supersport', 'SuperSport Live Events', 'DSTV Events', 'DStv Events 1') THEN 'Live Events'
 ELSE channel2
END AS tv_channel,

CASE WHEN watch_time BETWEEN '00:00:00' AND '05:59:59' THEN '01.Midnight'
WHEN watch_time BETWEEN '06:00:00' AND '11:59:59' THEN '02.Morning'
WHEN watch_time BETWEEN '12:00:00' AND '17:59:59' THEN '03.Afternoon'
WHEN watch_time BETWEEN '18:00:00' AND '23:59:59' THEN '04.Evening'
END AS time_of_day,

DATE_FORMAT(`Duration 2`, 'HH:mm:ss') AS duration,

CASE 
WHEN duration BETWEEN '00:05:00' AND '00:30:00' THEN '01.Low Usage:<5- 30mins'
WHEN duration BETWEEN '00:30:01' AND '01:00:00' THEN '02.Medium Usage:30mins-1hr'
WHEN duration > '01:00:01' THEN '03.High Usage: > 1hrs'
ELSE '04.No usage'
END AS screen_time_bucket,

CASE 
WHEN duration <= '00:05:00' THEN 'Inactive'
ELSE 'Active User'
END AS user_flag,


MONTHNAME(RecordDate2) AS month_name

from `workspace`.`bright_tv`.`viewership`
)


SELECT 
    COALESCE(A.UserID, B.UserID) AS sub_id,
    A.month_id,
    A.day_of_week,
    A.day_name,
    A.day_classification,
    A.watch_hour,
    A.time_of_day,
    A.watch_date,
    A.month_name,
    A.screen_time_bucket,
    A.tv_channel,
    B.region,
    B.age_groups,
    B.ethnic_groups,
    B.gender,
    B.email_flag,
    B.sm_flag,
    A.user_flag

FROM cte2 AS A
LEFT JOIN cte1 AS B
    ON A.UserID = B.`UserID`
GROUP BY ALL;
