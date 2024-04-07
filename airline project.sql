SELECT * FROM booking_table;
SELECT * FROM user_table;
# Q1 
## SEGMENT    TOTAL_USER_COUNT   USER_WHO_BOOKED_FLIGHT_IN_APR2022
SELECT u.Segment, count(distinct u.User_id) as Number_user_count
from user_table u
left join booking_table b
on u.User_id = b.User_id
group by u.Segment;

SELECT u.Segment, count(distinct u.User_id) as Number_user_count,
  count(distinct case when b.Line_of_business = 'flight'
    and b.Booking_date between '2022-04-01' and '2022-04-30' then b.user_id end)
from user_table u 
left join booking_table b
on u.User_id = b.User_id
group by u.Segment;

#Q2: Write a Query to identify users whose first booking was a hotel booking?
select * from ( select * ,
rank() over(partition by User_id order by Booking_date) as Rn
from booking_table) a
where rn= 1 and Line_of_business = 'hotel';

select distinct user_id from ( select * ,
first_value(Line_of_business) over(partition by User_id order by Booking_date) as first_booking
from booking_table) a
where first_booking = 'hotel'; 

#Q3 Write a query to calculate the daysbetween first and last booking of each user?
select user_id, 
min(booking_date) , max(booking_date) as number_of_days
from booking_table
group by User_id;

#Q4 Write a query to count the number of flight and hotel bookings in each pf the user segments for the year 2022?
select Segment,
sum(case when line_of_business = 'flight' then 1 else 0 end) as flight_flag,
sum(case when line_of_business = 'hotel' then 1 else 0  end) as hotel_flag
from booking_table b
join user_table u on b.User_id = u.User_id
group by segment;



