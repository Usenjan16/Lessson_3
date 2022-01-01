
~ 1. ������� ���������� ������� � ������ ���������, ������������� �� ��������.
select name, count(*) 
from film f 
	join film_category fc 
		on fc.film_id = f.film_id 
	join category c 
		on c.category_id = fc.category_id 
group by c.name
order by count desc

~2. ������� 10 �������, ��� ������ �������� ����� ����������, ������������� �� ��������.

select a.first_name ,a.last_name , count(*) as c
from rental r
 	join inventory y
 		on r.inventory_id =y.inventory_id 
 	join film f 
		 on f.film_id =y.film_id 
 	join film_actor fa 
		 on f.film_id =fa.film_id 
 	join actor a 
		 on a.actor_id =fa.actor_id 
group by a.first_name ,a.last_name
order by c desc
limit 10
 
~3. ������� ��������� �������, �� ������� ��������� ������ ����� �����.
select 
	f.title filim_title,
	sum(p.amount) film_amaount
from film f
	join inventory i 
		on i.film_id = f.film_id 
	join rental r 
		on r.inventory_id  = i.inventory_id 
	join payment p 
		on p.rental_id = r.rental_id 
group by f.title
order by film_amaount desc;

~4. ������� �������� �������, ������� ��� � inventory. �������� ������ ��� ������������� ��������� IN.

select * from film f 
where not exists 
(
select 1 from inventory i 
where i.film_id =f.film_id 
)

~5. ������� ��� 3 �������, ������� ������ ����� ���������� � ������� � ��������� �Children�. ���� � ���������� ������� ���������� ���-�� �������, ������� ����.

select * from actor a2 
	where a2.actor_id in(
		select a.actor_id from (
			select a.actor_id ,count(*) as count from actor a 
	join film_actor fa 
		on a.actor_id =fa.actor_id 
	join film f 
		on f.film_id =fa.film_id 
	join film_category fc 
		on fc.film_id =f.film_id 
	join category c 
		on c.category_id =fc.category_id 
			and c."name" ='Children'
group by a.actor_id 
) as a
	where a.count in(

	select a1.count from (
		select a1.actor_id ,count(*) as count from actor a1 
	join film_actor fa1 
		on a1.actor_id =fa1.actor_id 
	join film f1 
		on f1.film_id =fa1.film_id 
	join film_category fc1 
		on fc1.film_id =f1.film_id 
	join category c1 
		on c1.category_id =fc1.category_id 
			and c1."name" ='Children'
group by a1.actor_id 
) as a1
group by a1.count
order by count desc
limit 3))

~6. ������� ������ � ����������� �������� � ���������� �������� (�������� � customer.active = 1). ������������� �� ���������� ���������� �������� �� ��������.

select  c2.city ,c.active ,count(*) 
from customer c 
	join address a 
		on a.address_id =c.address_id 
	join city c2  
		on c2.city_id = a.city_id   
group by c2.city ,c.active
order by c.active  , a.count desc

~7. ������� ��������� �������, � ������� ����� ������� ���-�� ����� ��������� ������ � ������� (customer.address_id � ���� city), � ������� ���������� �� ����� �a�. �� �� ����� ������� ��� ������� � ������� ���� ������ �-�. �������� ��� � ����� �������.

select  c."name"  ,sum(f.length) from film f 
	join film_category fc 
		on f.film_id = fc.film_id 
	join category c 
		on c.category_id= fc.category_id 
	join inventory i 
		on f.film_id =i.film_id 
	join rental r 
		on r.inventory_id =i.inventory_id 
	join customer c2 
		on r.customer_id =c2.customer_id 
	join address a 
		on c2.address_id =a.address_id 
	join city c3 
		on c3.city_id =a.city_id 
			and(c3.city like '%-%' or c3.city like 'a%')
group by c."name" 

