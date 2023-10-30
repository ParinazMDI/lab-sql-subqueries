Use sakila;
-- 1 Determine the number of copies of the film "Hunchback Impossible" that exist in the inventory system
SELECT 
    COUNT(*)
FROM
    inventory
WHERE
    film_id = (SELECT 
            film_id
        FROM
            film
        WHERE
            title = 'Hunchback Impossible');                        
            
-- 2  List all films whose length is longer than the average length of all the films.
SELECT 
    length, title
FROM
    film
WHERE
    length > (SELECT 
            AVG(length)
        FROM
            film)
ORDER BY length ASC;

-- 3  Display all actors who appear in the film "Alone Trip"
SELECT actor.first_name, actor.last_name
FROM actor
WHERE actor.actor_id IN (
    SELECT film_actor.actor_id
    FROM film_actor
    WHERE film_actor.film_id = (
        SELECT film.film_id
        FROM film
        WHERE film.title = 'Alone Trip'
    )
);
            

-- 4   Identify all movies categorized as family films.
SELECT title
FROM film
WHERE film_id IN (SELECT film_id
FROM sakila.film_category 
WHERE category_id = (SELECT category_id FROM sakila.category WHERE name = 'Family'));

-- 5 Retrieve the name and email of customers from Canada. 
SELECT 
    c.first_name, c.last_name, c.email
FROM
    Customer c
        JOIN
    address USING (address_id)
    join city using (city_id)
        JOIN
    country co USING (country_id)
WHERE
    co.country_id =(SELECT 
            country_id
        FROM
            country
        WHERE
            country = 'canada');

-- 6   Determine which films were starred by the most prolific actor in the Sakila database.
SELECT actor_id, actor_name, film_count
FROM (
    SELECT a.actor_id,
           CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
           COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, actor_name
) subquery
ORDER BY film_count DESC
LIMIT 1;




  