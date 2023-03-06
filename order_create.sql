-- "AZON"."order" definition

-- Drop table

-- DROP TABLE "AZON"."order";

CREATE TABLE "AZON"."order" (
	order_id int4 NOT NULL,
	order_date date NOT NULL,
	client_id int4 NULL,
	assortment_id int4 NULL,
	amount int4 NOT NULL,
	points_id int4 NULL,
	home_delivery bool NULL
);