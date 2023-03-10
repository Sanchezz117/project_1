-- "AZON".available_products source

CREATE OR REPLACE VIEW "AZON".available_products
AS SELECT a.product,
    a.amount
   FROM "AZON".assortment a
  WHERE a.amount > 0;