CREATE OR REPLACE FUNCTION "AZON".delete_order(p_id_order integer, p_assort integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
declare 
	p_amount int;
begin
	select amount into p_amount from "order"  where p_id_order = order_id and p_assort = assortment_id;
	delete from "order"
		where order_id = p_id_order and p_assort = assortment_id;
	update assortment 
		set amount = amount + p_amount
		where assortment_id = p_assort;
end;
$function$
;
