-- "AZON".popular_product source

CREATE OR REPLACE VIEW "AZON".popular_product
AS SELECT a.product,
    sum(o.amount) AS sum
   FROM "AZON"."order" o
     RIGHT JOIN "AZON".assortment a ON o.assortment_id = a.assortment_id
  GROUP BY a.product
  ORDER BY (sum(o.amount)) DESC;