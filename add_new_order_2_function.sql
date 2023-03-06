CREATE OR REPLACE FUNCTION "AZON".add_new_order_2(p_date date, p_client integer, array_a integer[])
 RETURNS void
 LANGUAGE plpgsql
AS $function$
declare
p_id_order int;
p_assort int;
p_amount int;
p_points int;
p_home_deliv bool;
begin
	select nextval('pocled') into p_id_order;
	select last_delivery_address into p_points from client where p_client = client_id;
		case
			when p_points is null then p_home_deliv := true;
			else p_home_deliv := false;
		end case;
	for i in 1..array_length(array_a, 2) loop
		p_assort := array_to_string(array_a[1:1][i:i], ',')::int;
		p_amount := array_to_string(array_a[2:2][i:i], ',')::int;
	if ((select amount from assortment where p_assort = assortment_id) - p_amount) < 0
	then raise exception 'Товар отсутствует.' USING HINT = 'Нет товара на складе.';
	end if;
		insert into "order" (order_id, order_date, client_id, assortment_id, amount, points_id, home_delivery)
		values (p_id_order, p_date, p_client, p_assort, p_amount, p_points, p_home_deliv);
		update assortment
		set amount = amount - p_amount
		where assortment_id = p_assort;
	end loop;
end;
$function$
;
