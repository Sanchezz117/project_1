-- "AZON".client definition

-- Drop table

-- DROP TABLE "AZON".client;

CREATE TABLE "AZON".client (
	client_id serial4 NOT NULL,
	surname varchar(30) NULL,
	"name" varchar(30) NULL,
	patronymic varchar(30) NULL,
	phone_number varchar(10) NULL,
	email varchar(50) NULL,
	bill_number varchar(16) NULL,
	last_delivery_address int4 NULL,
	city varchar(40) NULL,
	street varchar NULL,
	house_number varchar(20) NULL,
	apartment_number varchar NULL,
	CONSTRAINT client_bill_number_key UNIQUE (bill_number),
	CONSTRAINT client_email_key UNIQUE (email),
	CONSTRAINT client_phone_number_key UNIQUE (phone_number),
	CONSTRAINT client_pkey PRIMARY KEY (client_id)
);