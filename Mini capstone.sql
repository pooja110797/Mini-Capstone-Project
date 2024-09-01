-- Analyze the monthly rental trends over the available data period.

select Month(rental_date) as rental_month, count(rental_id) as count_rentals
from rental
group by rental_month
order by count_rentals;


-- Determine the peak rental hours in a day based on rental transactions.
-- Extract the hour from the rental timestamp.
-- Count the number of rentals per hour.
-- Identify the peak hour(s) with the highest number of rentals.

select HOUR(r.rental_date) as peak_hour, sum(p.amount) as rental_transaction,count(*) as rental_count
from rental r
join payment p on r.customer_id=p.customer_id
group by peak_hour
order by rental_transaction desc

-- 2. Film Popularity:	
-- Identify the top 10 most rented films.


select f.title, count(*) as rentalcount
from rental r
join inventory i on r.inventory_id=i.inventory_id
join film f on i.film_id = f.film_id
group by f.title
order by rentalcount desc
limit 10;

-- Determine which film categories have the highest number of rentals.

select c.name, count(*) as rentalcount
from rental r
join inventory i on r.inventory_id=i.inventory_id
join film f on i.film_id = f.film_id
join film_category fc on f.film_id=fc.film_id
join category c on fc.category_id = c.category_id
group by c.name
order by rentalcount desc;

-- 3. Store Performance:
-- Identify which store generates the highest rental revenue.

 select s.store_id,sum(p.amount) as rental_revenue, count(*) as rentalcount
 from rental r
 join payment p on r.rental_id =p.rental_id
 join staff s on p.staff_id=s.staff_id
 join store st on s.store_id = st.store_id
 group by s.store_id
 order by rental_revenue desc
 limit 1;
 
 -- Determine the distribution of rentals by staff members to assess performance.

select s.staff_id,CONCAT(s.first_name,' ',s.last_name) as staffmember,sum(p.amount) as rental_revenue, count(*) as rentalcount
from rental r
 join payment p on r.rental_id =p.rental_id
 join staff s on p.staff_id=s.staff_id
 join store st on s.store_id = st.store_id
 group by s.staff_id,staffmember
 order by rentalcount desc
 
