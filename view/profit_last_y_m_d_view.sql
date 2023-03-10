-- "AZON".profit_last_y_m_d source

CREATE OR REPLACE VIEW "AZON".profit_last_y_m_d
AS WITH profit_month AS (
         SELECT sum(a.price) AS profit_month,
            date_part('month'::text, o.order_date) AS month_date,
            1 AS id
           FROM "AZON"."order" o
             JOIN "AZON".assortment a ON a.assortment_id = o.assortment_id
          WHERE o.order_date >= (( SELECT date_trunc('month'::text, max(o2.order_date)::timestamp with time zone) AS date_trunc
                   FROM "AZON"."order" o2))
          GROUP BY (date_part('month'::text, o.order_date))
        ), profit_year AS (
         SELECT sum(a.price) AS profit_year,
            date_part('year'::text, o.order_date) AS year_date,
            1 AS id
           FROM "AZON"."order" o
             JOIN "AZON".assortment a ON a.assortment_id = o.assortment_id
          WHERE o.order_date >= (( SELECT date_trunc('year'::text, max(o2.order_date)::timestamp with time zone) AS date_trunc
                   FROM "AZON"."order" o2))
          GROUP BY (date_part('year'::text, o.order_date))
        ), profit_day AS (
         SELECT sum(a.price) AS profit_day,
            date_part('day'::text, o.order_date) AS day_date,
            1 AS id
           FROM "AZON"."order" o
             JOIN "AZON".assortment a ON a.assortment_id = o.assortment_id
          WHERE o.order_date >= (( SELECT date_trunc('day'::text, max(o2.order_date)::timestamp with time zone) AS date_trunc
                   FROM "AZON"."order" o2))
          GROUP BY (date_part('day'::text, o.order_date))
        )
 SELECT y.profit_year,
    y.year_date,
    m.profit_month,
    m.month_date,
    d.profit_day,
    d.day_date
   FROM profit_year y
     JOIN profit_month m ON m.id = y.id
     JOIN profit_day d ON d.id = y.id;