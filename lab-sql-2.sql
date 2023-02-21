USE sakila;

# 1. Select all the actors with the first name ‘Scarlett’.
select first_name
from actor
where first_name = 'Scarlett';

# 2. Select all the actors with the last name ‘Johansson’.
select last_name
from actor
where last_name = 'Johansson';

# 3. How many films (movies) are available for rent?
select count(distinct film_id), count(distinct title)
from film;
# 1000 films 

# 4. How many films have been rented?
select count(distinct rental_id) as rental_ids, count(distinct inventory_id) as inv_ids, count(distinct film_id) as film_ids
from film, rental;
# IF the question was about the number of rented films as in the number of rentals, the answer would have to be 16044 films
# HOWEVER: a more accurate way to approach this would either have to take the number of films in the inventory into account, wherefrom the number of rented films would be deducted after we
## determined which inventory_ids were given for rental (number of this kind of products used by customers so to speak) OR the number of films by id following the same logic (number of
### films by title, because it could be that some titles have never been rented)

# 5. What is the shortest and longest rental period?
# note: select min(datediff(return_date, rental_date)) as min__rental_period, max(datediff(return_date, rental_date)) as max_rental_period --> unreliable unless limited to own rental_id somehow

select max(rental_duration) as max_rental_period, min(rental_duration) as min_rental_period
from film;
# shortest period = 3 days, longest period = 7 days (units of measurement looked into)

# 6. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select min(length) as shortest_duration, max(length) as longest_duration
from film;
# shortest duration = 46 mins, longest duration = 185 mins 

# 7. What's the average movie duration?
select avg(length) as avg_movie_duration
from film;
# avg_movie_duration = 115.27 mins

# 8. What's the average movie duration expressed in format (hours, minutes)?

## option 1
select concat(floor(avg(length)/60),'h ', round(mod(avg(length),60), 0),'m') as avg_movie_duration # based on a solution by dkasipovic on stackoveerflow (https://stackoverflow.com/questions/22025363/mysql-minutes-to-hours-and-minutes)
from film;
# 1h 55m

## option 2
select concat(lpad(floor(avg(length)/60), 2, '0'),':', lpad(mod(avg(length),60), 2, '0')) as avg_movie_duration # based on a solution by Bart Van Eynde on stackoveerflow (https://stackoverflow.com/questions/22025363/mysql-minutes-to-hours-and-minutes)
from film;
# 01:55

# 9. How many movies longer than 3 hours?
## 3 hours = 180 mins
SELECT COUNT(length) AS long_films_n
FROM film
WHERE length > 180;
# 39 films

# 10. Get the name and email formatted. Example: Mary SMITH - mary.smith@sakilacustomer.org.
SELECT *
from customer; # to have a general idea of what I need to standardise

SELECT CONCAT(UPPER(SUBSTRING(first_name,1,1)), LOWER(SUBSTRING(first_name,2))) AS first_name, # based on a solution by Sharon Christine on tutorialspoint.com
CONCAT(LOWER(SUBSTRING(last_name,1)), UPPER(SUBSTRING(last_name,2,1))) AS last_name,
LOWER(email) as email
FROM customer;

# 11. What's the length of the longest film title?
SELECT MAX(LENGTH(title))
FROM film;
# longest title = 27 characters