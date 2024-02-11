--1. List all customers who live in Texas (use JOINs)
select *
from customer 
left join address 
on customer.address_id = address.address_id 
where district = 'Texas'; 

-- 5 CUSTOMERS LIVES IN TEXAS

select*from payment


--2. Get all payments above $6.99 with the Customer's Full Name
select  customer.first_name, customer.last_name, payment.amount
from customer
inner join payment on customer.customer_id = payment.customer_id
where payment.amount > 6.99;



--3. Show all customers names who have made payments over $175(use subqueries)
select customer_id
from payment 
group by customer_id 
having sum(amount) > 175
order by sum(amount) desc;

select first_name
from customer where customer_id in (
	select customer_id 
	from payment 
	group by customer_id 
	having sum(amount) > 175
	order by sum(amount) desc
)

--4. List all customers that live in Nepal (use the city table)

select customer.first_name, city, country
from customer
join city 
on customer.customer_id = city.city_id 
join country
on city.city_id = country.country_id 
where country = 'Nepal'


--5. Which staff member had the most transactions?
select staff.first_name, count(payment.payment_id) as transactions
from payment
join staff on staff.staff_id = payment.staff_id
group by staff.staff_id, staff.first_name
order by transactions desc

-- Jon is the staff member who had more transactions



--6. How many movies of each rating are there?

select film.rating, count(inventory.film_id) as number_of_movies
from film
join inventory on film.film_id = inventory.film_id
group by film.rating
order by number_of_movies desc;



--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select customer.first_name, customer.last_name, payment.amount
from customer 
inner join payment  on customer.customer_id = payment.customer_id
where payment.amount > 6.99
and (select count(*)
     from payment
     where customer_id = customer.customer_id) = 1;

--8.How many free rental did our stores give away?
select count(rental.rental_id) as number_of_free_rentals
from rental
join payment on rental.rental_id = payment.rental_id
where payment.amount = 0;

