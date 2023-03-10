-- "AZON".assortment definition

-- Drop table

-- DROP TABLE "AZON".assortment;

CREATE TABLE "AZON".assortment (
	assortment_id serial4 NOT NULL,
	product varchar(30) NULL,
	price int4 NULL,
	weight numeric(5, 2) NULL,
	amount int4 NULL,
	CONSTRAINT assortment_pkey PRIMARY KEY (assortment_id)
);