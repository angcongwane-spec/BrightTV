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

--Checking the uniques Provinces
select DISTINCT Province
from `brighttv`.`tv`.`user_profiles`;

--Checking the uniques channels
select DISTINCT Channel
from `brighttv`.`tv`.`viewerships`;
