-- Nädal: 4          Meeskond: Sales      Roll: B Kliendid - kliendigruppide analüüs

-- Ülesanne: Segmenteeri kliendid kulutuse järgi (VIP / Regular / Uus), leia TOP kliendid ja koosta kliendiprofiili kokkuvõte Annale.

-- Kliendigruppide analüüs CTE-ga. Kasuta CTE-d, et arvutada iga kliendi kogukulutus, seejärel segmenteeri:
WITH kliendi_kokkuvote AS (
  SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS nimi,
    c.city,
    COUNT(o.sale_id) AS tellimuste_arv,
    SUM(o.total_price) AS kogukäive
  FROM customers c
  JOIN sales o ON c.customer_id = o.customer_id
  GROUP BY c.customer_id, c.first_name, c.last_name, c.city
)
SELECT
  nimi,
  city,
  tellimuste_arv,
  kogukäive,
  CASE
    WHEN kogukäive > 500 THEN 'VIP'       -- vali ise piir!
    WHEN kogukäive > 150 THEN 'Regular'    -- vali ise piir!
    ELSE 'Uus'
  END AS segment
FROM kliendi_kokkuvote
ORDER BY kogukäive DESC;

-- Max ja min käive
SELECT MAX(kogukäive), AVG(kogukäive), MIN(kogukäive) 
FROM (
  SELECT SUM(total_price) AS kogukäive 
  FROM sales 
  GROUP BY customer_id
) sub;

-- TOP 10 klienti
-- GROUP BY kliendi järgi    - SUM(total_price) kogukäive leidmiseks    - HAVING: vähemalt 2 tellimust (filteeri välja ühekordse ostuga kliendid)    - ORDER BY kogukäive DESC, LIMIT 10
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS klient,
    COUNT(s.sale_id) AS tellimuste_arv,
    SUM(s.total_price) AS kogukäive
FROM customers c
INNER JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(s.sale_id) >= 2
ORDER BY kogukäive DESC
LIMIT 10;

-- Segmentide koondstatistika — kirjuta ise:
-- Mitu klienti on igas segmendis (VIP, Regular, Uus)?    - Mis on iga segmendi keskmine käive?    
-- Millistes linnades on kõige rohkem VIP-kliente?

-- Klientide arv ja keskmine käive segmendi kaupa
WITH kliendi_kokkuvote AS (
  SELECT
    c.customer_id,
    c.city,
    SUM(s.total_price) AS kogukäive
  FROM customers c
  JOIN sales s ON c.customer_id = s.customer_id
  GROUP BY c.customer_id, c.city
),
segmentidega_kliendid AS (
  SELECT
    customer_id,
    city,
    kogukäive,
    CASE
      WHEN kogukäive > 500 THEN 'VIP'
      WHEN kogukäive > 150 THEN 'Regular'
      ELSE 'Uus'
    END AS segment
  FROM kliendi_kokkuvote
)
SELECT
  segment,
  COUNT(*) AS klientide_arv,
  ROUND(AVG(kogukäive), 2) AS keskmine_käive
FROM segmentidega_kliendid
GROUP BY segment
ORDER BY keskmine_käive DESC;

-- VIP klientide arv linnade kaupa
WITH kliendi_kokkuvote AS (
  SELECT
    c.customer_id,
    c.city,
    SUM(s.total_price) AS kogukäive
  FROM customers c
  JOIN sales s ON c.customer_id = s.customer_id
  GROUP BY c.customer_id, c.city
),
segmentidega_kliendid AS (
  SELECT
    city,
    CASE
      WHEN kogukäive > 500 THEN 'VIP'
      WHEN kogukäive > 150 THEN 'Regular'
      ELSE 'Uus'
    END AS segment
  FROM kliendi_kokkuvote
)
SELECT
  city,
  COUNT(*) AS vip_klientide_arv
FROM segmentidega_kliendid
WHERE segment = 'VIP'
GROUP BY city
ORDER BY vip_klientide_arv DESC;

-- UrbanStyle'i 2551 aktiivsest kliendist kuulub koguni 1722 VIP-segmenti, 639 Regular- ning 190 Uus-segmenti. VIP-klientide rühm paistab silma ka märgatavalt kõrgeima keskmise käibega, moodustades ettevõtte jaoks kõige väärtuslikuma kliendibaasi. Kliendid koonduvad peamiselt Tallinnasse, Tartusse ja Pärnusse, mis on ühtlasi UrbanStyle'i peamised tegevuspiirkonnad. Anna peaks tegevjuht Kristile raporteerima, et kuna enamik aktiivsetest klientidest on juba VIP-staatuses ja toovad kõrgeimat keskmist käivet, tuleb fookus hoida nende rahulolul ja hoidmisel, pakkudes samal ajal Regular- ja Uutele klientidele stiimuleid korduvostudeks.