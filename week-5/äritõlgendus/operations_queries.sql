-- Nädal: 5          Meeskond: Sales      Roll: C inventuur, tarneaeg

-- Ülesanne: Liis tahab näha laoseise ja operatsioonide näitajaid. Loo operations dashboard inventuuri olukorra ja müügi jaotusega kaupluste lõikes.

-- Hangi andmed
-- Müügi jaotus kaupluste lõikes
SELECT store_location, SUM(total_price) AS tulu,
COUNT(*) AS tehinguid
FROM sales GROUP BY store_location ORDER BY tulu DESC;

SELECT 
    COALESCE(store_location, 'Online') AS store_location,
    SUM(total_price) AS tulu,
    COUNT(*) AS tehinguid
FROM sales
GROUP BY COALESCE(store_location, 'Online')
ORDER BY tulu DESC;

-- Inventuuri olukord
SELECT p.category, SUM(i.quantity_available) AS kogus
FROM inventory i
JOIN products p ON i.product_id = p.product_id
GROUP BY p.category ORDER BY kogus DESC;

-- Laoseisude jaotus kategooriate kaupa (puhastatud andmetega):
SELECT 
    p.category AS kategooria,
    SUM(i.quantity_available) AS kogus
FROM inventory i
JOIN products p ON i.product_id = p.product_id
WHERE i.quantity_available >= 0  -- Filtreerime välja vigased negatiivsed kogused
GROUP BY p.category
ORDER BY kogus DESC;