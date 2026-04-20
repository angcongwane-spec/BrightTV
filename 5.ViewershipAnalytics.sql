--Viewing all the columns of the UserProfile table
select *
from `brighttv`.`tv`.`user_profiles`
limit 10;

--Viewing all the columns of the Viewerships table
select*
from `brighttv`.`tv`.`viewerships`
limit 10;

--Joining only the important columns from both tables using a full outer join
select a.UserID, b.UserID, Gender, Race, Age, Province, Channel, RecordDate
from `brighttv`.`tv`.`user_profiles` as a
full outer join `brighttv`.`tv`.`viewerships` as b
on a.UserID = b.UserID;

--Counting the number of rows on table user_profile to confirm any data loss from loading of data
select count(*)
from brighttv.tv.user_profiles;

--Counting number of rows from table viewerships to confirm any data loss from loading of data
select count (*)
from brighttv.tv.viewerships;

--Checking for and replacing NULLS in the table user_profile
select ifnull (Gender, 'no_gender_selected') as Gender,
ifnull (Race, 'no_race_selected') as Race,
ifnull (Age, 'no_age_selected') as Age,
ifnull (Province, 'no_province_selected') as Province
from brighttv.tv.user_profiles;

--Checking for and replacing NULLS in the table viewerships
select ifnull (Channel, 'no_channel_selected') as Channel,
ifnull (RecordDate, 'no_record_date_selected') as RecordDate,
ifnull (Duration, 'no_duration_selected') as Duration
from brighttv.tv.viewerships;


--Checking the uniques Provinces
select DISTINCT Province
from `brighttv`.`tv`.`user_profiles`;

--Checking the uniques channels
select DISTINCT Channel
from `brighttv`.`tv`.`viewerships`;

--Checking distinct viewers
select count (distinct UserID) as Total_Number_of_Viewers
from brighttv.tv.joined_btv_dataset;


--Viewing all columns from the joined BTV table
select *
from brighttv.tv.joined_btv_dataset;

--Analysing which channel was viewed by most/least subscribers
select count (UserID) as user_count, Channel
from  brighttv.tv.joined_btv_dataset
group by Channel
order by user_count desc;

--Counting users by Province
select count (UserID) as User_count_by_Province, Province
from brighttv.tv.joined_btv_dataset
group by province
order by User_count_by_Province desc;


--Analysing trends by categorising channel viewrship by Provice
select count (UserID), Channel, Province
from brighttv.tv.joined_btv_dataset
group by Channel, Province
order by count (UserID) desc;


--Analysing trends by categorising viewrship by race
select Count (UserID) as User_Count_by_Race, Race, Channel
from brighttv.tv.joined_btv_dataset
group by Race, Channel
order by user_count_by_race desc;


--Analysing trends by categorising subscription by age
select count (UserID) as User_count_by_age, Age
from brighttv.tv.joined_btv_dataset
group by Age
order by user_count_by_age desc;


--Analysing trends by categorising viewrship by gender
select count (UserID) as Gender_count, Gender
from brighttv.tv.joined_btv_dataset
group by Gender;


--Distinct age
select distinct Age
from brighttv.tv.joined_btv_dataset
order by Age desc;


--Categorising users by age 
select count (UserID) as Age_count, Age
from brighttv.tv.joined_btv_dataset
group by Age;


--Nulls on Age column through a case statement
select UserID,
      case
      when Age is null or Age = 0 then 'No Age Selected'
      else cast (Age as string)
      end as Age
from brighttv.tv.user_profiles;

--Nulls on joined table
select ifnull (Channel, 'no_channel_selected') as Channel,
ifnull (RecordDate, 'no_record_date_selected') as RecordDate,
ifnull (cast(Duration as string), 'no_duration_selected') as Duration,
ifnull (RecordDate, 'no_record_date_selected') as RecordDate,
to_timestamp(RecordDate, 'yyyy-mm-dd hh : mm : ss') as Timestamp_value,
cast(to_timestamp(RecordDate, 'yyyy-MM-dd HH : mm : ss') as date)as Date_part,
date_format(to_timestamp(RecordDate, 'yyyy-mm-dd'), 'hh : mm : ss') as Time_stamp
from brighttv.tv.joined_btv_dataset;




--Categorising age groups and channel
select count (UserID) as Age_count, Age,
      case
      when Age = 'None' then 'No Age Selected'
      when Age < 13 then 'Child'
      when Age >= 13 and Age <= 17 then 'Teenager'
      when Age >= 18 and Age <= 29 then 'Young Adult'
      when age >= 30 and Age <= 49 then 'Adult'
      when Age >= 50 and age <= 59 then 'Middle Age'
      when Age >= 60 then 'Senior'
      end as age_group,
      Channel
from brighttv.tv.joined_btv_dataset
group by Age, Age_group, Channel;


--Grouping by all
select  Gender, Race, Province, count (UserID) as Age_count, Age,
      case
      when Age is null then 'No Age Selected'
      when Age < 13 then 'Child'
      when Age >= 13 and Age <= 18 then 'Teenager'
      when Age >= 18 and Age <= 30 then 'Young Adult'
      when age >= 30 and Age <= 50 then 'Adult'
      when Age >= 50 and age <= 60 then 'Middle Age'
      when Age >= 60 then 'Senior'
      end as age_group,
      Channel
from brighttv.tv.joined_btv_dataset
group by all;


--Duration and record dates
select RecordDate
from brighttv.tv.viewerships;

--Day of consumption
select Channel, Duration, dayname(RecordDate) as Day_of_consumption
from brighttv.tv.viewerships
order by day_of_consumption asc;

--Month of consumption
select Channel, Duration, monthname(RecordDate) as Month_of_consumption
from brighttv.tv.viewerships
order by Month_of_consumption asc;

--Year of consumption
select Channel, Duration, year(RecordDate) as Year_of_Consumption
from brighttv.tv.viewerships
Order by year_of_consumption asc;

--Duration per channel
select Channel, max(Duration) as Maximum_Duration, Min(Duration) as Minimum_Duration, avg(Duration) as Average_Duration
from brighttv.tv.viewerships
group by Channel;

--Monthly viewership per channel
select Channel, max(Duration) as Most_viewed_per_Day, dayname(Most_viewed_per_Day) as Day_of_consumption
from brighttv.tv.viewerships
group by Channel;


--Viewership by time buckets
select
case
    when RecordDate between '05:00:00' and '11:59:59' then 'Morning'
    when RecordDate between '12:00:00' and '17:59:59' then 'Afternoon'
    when RecordDate between '18:00:00' and '23:59:59' then 'Evening'
    else 'Midnight'
end as Time_bucket,
count (UserID) as User_count
from brighttv.tv.joined_btv_dataset
group by
      case
      when RecordDate between '05:00:00' and '11:59:59' then 'Morning'
    when RecordDate between '12:00:00' and '17:59:59' then 'Afternoon'
    when RecordDate between '18:00:00' and '23:59:59' then 'Evening'
    else 'Midnight'
end
order by User_count desc;

--Big table
SELECT 
        a.UserID,

        -- Demographics
        ifnull(nullif(a.Gender, 'None'), 'No Gender Selected') AS Gender,
        ifnull(nullif(a.Race, 'None'), 'No Race Selected') AS Race,
        ifnull(nullif(a.Province, 'None'), 'No Province Selected') AS Province,

        -- Age handling
        CASE 
            WHEN a.Age IS NULL OR a.Age = 0 THEN 'No Age Selected'
            ELSE CAST(a.Age AS STRING)
        END AS Age,

        -- Viewership data
        ifnull(b.Channel, 'no_channel_selected') AS Channel,
        b.Duration,

        --Timestamp conversion
        to_timestamp(b.RecordDate, 'yyyy-MM-dd HH:mm:ss') AS Timestamp_value,

        CAST(to_timestamp(b.RecordDate, 'yyyy-MM-dd HH:mm:ss') AS DATE) AS Date_part,

        date_format(
            to_timestamp(b.RecordDate, 'yyyy-MM-dd HH:mm:ss'),
            'HH:mm:ss'
        ) AS Time_stamp,

        -- Time-based breakdown
        dayname(to_timestamp(b.RecordDate, 'yyyy-MM-dd HH:mm:ss')) AS Day_of_consumption,
        monthname(to_timestamp(b.RecordDate, 'yyyy-MM-dd HH:mm:ss')) AS Month_of_consumption,
        year(to_timestamp(b.RecordDate, 'yyyy-MM-dd HH:mm:ss')) AS Year_of_consumption,

        -- Time buckets
        CASE
            WHEN date_format(to_timestamp(b.RecordDate, 'yyyy-MM-dd HH:mm:ss'), 'HH:mm:ss') 
                 BETWEEN '05:00:00' AND '11:59:59' THEN 'Morning'
            WHEN date_format(to_timestamp(b.RecordDate, 'yyyy-MM-dd HH:mm:ss'), 'HH:mm:ss') 
                 BETWEEN '12:00:00' AND '17:59:59' THEN 'Afternoon'
            WHEN date_format(to_timestamp(b.RecordDate, 'yyyy-MM-dd HH:mm:ss'), 'HH:mm:ss') 
                 BETWEEN '18:00:00' AND '23:59:59' THEN 'Evening'
            ELSE 'Midnight'
        END AS Time_bucket,

        -- Age groups
        CASE
            WHEN a.Age IS NULL OR a.Age = 0 THEN 'No Age Selected'
            WHEN a.Age < 13 THEN 'Child'
            WHEN a.Age BETWEEN 13 AND 18 THEN 'Teenager'
            WHEN a.Age BETWEEN 19 AND 30 THEN 'Young Adult'
            WHEN a.Age BETWEEN 31 AND 50 THEN 'Adult'
            WHEN a.Age BETWEEN 51 AND 60 THEN 'Middle Age'
            ELSE 'Senior'
        END AS Age_group
    FROM brighttv.tv.user_profiles a
    LEFT JOIN brighttv.tv.viewerships b
        ON a.UserID = b.UserID;

