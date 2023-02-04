use sqlbook;

select datediff('2006-12-28', start_date) as cal_dates,
avg( case when stop_date is null then 1 else 0 end) as retention_rate
from subs
where tenure >=0 and datediff(start_date,'2004-01-01') >=0
group by datediff('2006-12-28', start_date);


select 
period_add( '200401',
period_diff(date_format(start_date, "%y%m"), date_format('2004-01-01', "%y%m")) )as cohort,
sum(rr_0_0) /count(*) as r_0,
sum(rr_0_1) /count(*)as r_1,
sum(rr_0_2) /count(*)as r_2,
sum(rr_0_3) /count(*) as r_3
from
(
select start_date, stop_date, stop_type, 
case when stop_date is null or 
(
period_diff(date_format(stop_date, "%y%m"), date_format('2004-01-01', "%y%m"))>=
period_diff(date_format(start_date, "%y%m"), date_format('2004-01-01', "%y%m")) + 1) then 1 or 0 end  as rr_0_0,
case when stop_date is null or 
(
period_diff(date_format(stop_date, "%y%m"), date_format('2004-01-01', "%y%m"))>=
period_diff(date_format(start_date, "%y%m"), date_format('2004-01-01', "%y%m")) + 2) then 1 or 0 end  as rr_0_1,
case when stop_date is null or 
(
period_diff(date_format(stop_date, "%y%m"), date_format('2004-01-01', "%y%m"))>=
period_diff(date_format(start_date, "%y%m"), date_format('2004-01-01', "%y%m"))+ 3) then 1 or 0 end  as rr_0_2,
case when stop_date is null or 
(
period_diff(date_format(stop_date, "%y%m"), date_format('2004-01-01', "%y%m"))>=
period_diff(date_format(start_date, "%y%m"), date_format('2004-01-01', "%y%m")) +4) then 1 or 0 end  as rr_0_3
from subs
where tenure >=0 and datediff(start_date,'2004-01-01') >=0
-- group by datediff('2006-12-28', start_date);
and period_diff(date_format(start_date, "%y%m"), date_format('2004-01-01', "%y%m")) >=0
and period_diff(date_format(start_date, "%y%m"), date_format('2004-01-01', "%y%m")) <=4

) subs

group by period_diff(date_format(start_date, "%y%m"), date_format('2004-01-01', "%y%m"))
;







select start_date, stop_date, period_diff(date_format(stop_date, "%y%m"), date_format('2004-01-01', "%y%m"))
from subs 
where year(start_date)=2004 and month(start_date) = 1 and year(stop_date)=2004 and month(stop_date) = 1 

