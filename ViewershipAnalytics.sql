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
