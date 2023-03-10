-- "AZON".pick_up_points definition

-- Drop table

-- DROP TABLE "AZON".pick_up_points;

CREATE TABLE "AZON".pick_up_points (
	points_id serial4 NOT NULL,
	city varchar(20) NULL,
	street varchar(40) NULL,
	house_number varchar(10) NULL,
	notes varchar NULL,
	CONSTRAINT pick_up_points_pkey PRIMARY KEY (points_id)
);