-- Päring: Toomas Kase raport
-- Autor: Kristina Piltjai
-- Kuupäev: 01.10.2026
-- Ülesanne: Kirjuta neli päringut, mis vastavad kõigile Toomase küsimustele. Kasuta kõiki nädala jooksul õpitud käske.

-- Duplikaatide arv
SELECT
    COUNT(*) AS ridu_kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid,
    COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaate
FROM sales;
-- Vastus Toomasele: Meie tabelis on 15 234 rida, millest 5116 on duplikaadid.

-- Kirjuta ise päring, mis näitab, mitmel real puudub customer_id:
SELECT COUNT (*)
FROM sales
WHERE customer_id IS NULL
-- Vastus Toomasele: 1487 tellimusel puudub kliendi ID.

-- Kirjuta päring, mis näitab 10 suurimat tellimust (sale_id, customer_id, total_price):
SELECT sale_id, customer_id, total_price
FROM sales
ORDER BY total_price DESC
LIMIT 10;
-- Vastus Toomasele: Suurim müük oli 2170.40 eurot.

-- Kirjuta päring, mis näitab 10 väikseimat tellimust JA read, kus summa on 0 või väiksem:
SELECT COUNT(*) AS null_voi_negatiivsed
FROM sales
WHERE total_price <= 0;
-- Vastus Toomasele: Leidsime 305 tellimust, kus summa on 0 või negatiivne.

-- Küsimused, mis tekkisid:
-- Kus jäid hätta? Jäin hätta enim sellega, et ei teadnud, mis on tulpade nimed ja siis tulid errorid ning kasutasin AI abi.
-- Mis jäi segaseks? Pigem on asi harjutamises ja eks AI aitab ka tänapäeval väga palju päringute kirjutamises.
-- Mida tahaksid sügavamalt mõista? Hetkel kõige keerulisem on ilmselt WHERE struktuur, muu ei ole nii keeruline. Keeruline seetõttu, et millal kuhu mis nool panna jne, aga peab lihtsalt läbi mõtlema ja keskenduma.