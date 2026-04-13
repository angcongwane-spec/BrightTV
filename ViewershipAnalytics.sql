select *
from `brighttv`.`tv`.`user_profiles`
limit 10;

select*
from `brighttv`.`tv`.`viewerships`
limit 10;

select a.UserID, b.UserID, Gender, Race, Age, Province, Channel, RecordDate
from `brighttv`.`tv`.`user_profiles` as a
full outer join `brighttv`.`tv`.`viewerships` as b
on a.UserID = b.UserID;
