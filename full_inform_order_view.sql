-- "AZON".full_inform_order source

CREATE OR REPLACE VIEW "AZON".full_inform_order
AS SELECT o.order_id,
    o.order_date,
    (((c.surname::text || ' '::text) || c.name::text) || ' '::text) || c.patronymic::text AS addressee,
    a.product,
    o.amount,
        CASE
            WHEN o.amount = 1 THEN a.price
            ELSE a.price * o.amount
        END AS price,
        CASE
            WHEN o.amount = 1 THEN a.weight
            ELSE round(a.weight * o.amount::numeric, 2)
        END AS weight,
        CASE
            WHEN o.home_delivery = true THEN (((((c.city::text || ', '::text) || c.street::text) || ', '::text) || c.house_number::text) || ', '::text) || c.apartment_number::text
            ELSE (((((pup.city::text || ', '::text) || pup.street::text) || ', '::text) || pup.house_number::text) || ', '::text) || COALESCE(pup.notes, ''::character varying)::text
        END AS address
   FROM "AZON"."order" o
     JOIN "AZON".client c ON o.client_id = c.client_id
     JOIN "AZON".assortment a ON o.assortment_id = a.assortment_id
     LEFT JOIN "AZON".pick_up_points pup ON o.points_id = pup.points_id;