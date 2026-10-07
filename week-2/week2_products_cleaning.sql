-- Nädal: 2          Meeskond: Sales      Roll: C Toodeandmete puhastamine

-- Samm 1. Loo test koopia
CREATE TABLE products_test AS SELECT * FROM products;
SELECT COUNT(*) AS ridade_arv FROM products_test;
-- 362 rida

-- Samm 2. Leia duplikaadid — kas on korduvaid tootenimesid?
SELECT product_name, COUNT(*) AS koopiate_arv
FROM products_test
GROUP BY product_name
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;
-- 12 duplikaatset tootenime

-- Samm 3. Leia NULL väärtused kriitilistes väljades:
SELECT
    COUNT(*) FILTER (WHERE product_name IS NULL OR product_name = '') AS null_nimi,
    COUNT(*) FILTER (WHERE category IS NULL OR category = '') AS null_kategooria,
    COUNT(*) FILTER (WHERE retail_price IS NULL) AS null_jaehind,
    COUNT(*) FILTER (WHERE cost_price IS NULL) AS null_omahind
FROM products_test;
-- 0 NULL nimi, 0 NULL kategooria, 0 NULL jaehind, 0 NULL omahind

-- Samm 4. Kontrolli loogilisi vigu — kas on ebareaalseid hindu?
-- Kas on negatiivseid hindu?
SELECT COUNT(*) AS negatiivne_hind
FROM products_test
WHERE retail_price < 0;

-- Kas on äärmuslikke hindu (> 1000€)?
SELECT product_name, retail_price
FROM products_test
WHERE retail_price > 1000
ORDER BY retail_price DESC;
-- 0 negatiivset jaehinda, success no rows returned

-- Samm 5. Kontrolli kategooriate järjekindlust:
SELECT category, COUNT(*) AS arv
FROM products_test
GROUP BY category
ORDER BY category;
-- Vaata: kas mõni kategooria esineb mitmes kirjapildis või tähesuuruses? Vastus võib olla, et ei esine - puhas veerg on leid, mitte ebaõnnestunud päring. Kirjuta üles see, mida sa päriselt näed. Kirjuta üles: Näen 5 kategooriat: aksessuaarid, jalanõusid, laste_riided, meeste_riided ja naiste_riided ehk 5 erineva kategooria väärtust.

-- Samm 6. Koosta puhastamisraport
SELECT category, COUNT(*)
FROM products_test
GROUP BY category;

-- Edasijõudnud
-- Kui baastase on valmis ja aega jääb, vii puhastamine läbi:
-- Ühtlusta kategooriate nimed
UPDATE products_test
SET category = INITCAP(TRIM(category))
WHERE category != INITCAP(TRIM(category));

-- Kontrolli tulemust
SELECT category, COUNT(*) AS arv
FROM products_test
GROUP BY category ORDER BY category;

-- Lisa CASE WHEN kategooriate standardiseerimiseks: - ei olnud erinevaid nimekujusid
UPDATE products_test
SET category = CASE
    WHEN LOWER(TRIM(category)) IN ('meeste_riided') THEN 'Menswear'
    WHEN LOWER(TRIM(category)) IN ('naiste_riided') THEN 'Womenswear'
    WHEN LOWER(TRIM(category)) IN ('laste_riided') THEN 'Kidswear'
    WHEN LOWER(TRIM(category)) IN ('jalanõusid') THEN 'Footwear'
    WHEN LOWER(TRIM(category)) IN ('aksessuaarid') THEN 'Accessories'
    ELSE INITCAP(TRIM(category))
END;

-- Mis oli suurim üllatus?
-- Kas NULL väärtused olid tõesti kõikides  kriitilistes väljades 0.

-- Milline on meie soovitus Toomasele?
-- Soovitan duplikaadid eemaldada tabelist, et saaks korrektsema pildi olukorrast.

-- Milliseid andmeid meil puudus?
-- Mul oli NULL kõik 0 ehk siis polnud midagi puudu olulist.