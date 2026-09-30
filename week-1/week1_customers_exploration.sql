-- Nädal: 1          Meeskond: Sales      Roll: B Kliendiandmete uurija

-- Toomas tahab teada, millised kliendid on UrbanStyle'i andmebaasis. Uuri customers tabelit: mitu klienti on? Millised linnad on esindatud? Kas on duplikaatseid e-maile? Millal kliendid registreerusid?

-- Mitu klienti on kokku? 3150
SELECT COUNT(*) AS klientide_arv FROM customers;

-- Millised veerud ja andmed tabelis on? customer_id, first_name, last_name, email, phone, city, registration_date, loyalty_tier, birth_year
SELECT * FROM customers LIMIT 10;

-- Millised linnad on esindatud? Pärnu, Paide, Jõhvi, Tallinn, Narva, Võru, Viljandi, Rakvere, Haapsalu, Valga, Tartu, Kuressaare.
-- Mida märkasin? Linnad olid kirjutatud erinevalt ehk siis väikeste tähtedega, suurte tähtedega, suure algustähega jne ja siis nad kõik olid tabelis välja toodud.
SELECT DISTINCT city FROM customers;

-- Tallinna kliendid, sorteeritud nime järgi. (Ül: Filtreeri kindla linna kliendid.) Sandra, Reet, Kadri, Väino, Marit, Maris, Eha (2001), Mart, Marika, Nele, Maie, Lauri, Eha (4068), Riina, Henri. Kõik on Aas perekonnanimega.
SELECT * FROM customers
WHERE city = 'Tallinn'
ORDER BY last_name ASC
LIMIT 15;

-- Millal esimesed ja viimased kliendid registreerusid? Vanim 02.01.2020 ja uusim 27.02.2025.
SELECT MIN(registration_date) AS vanim,
       MAX(registration_date) AS uusim
FROM customers;

-- Mitu klienti, kus eesnimi on puudu? 0
SELECT COUNT(*) - COUNT(first_name) AS puuduvad_eesnimed
FROM customers;

-- Mitu klienti, kus e-mail on puudu? 380
SELECT COUNT(*) - COUNT(email) AS puuduvad_emailid
FROM customers;

-- Kokkuvõte
-- Kliente on kokku 3150.
-- Kliendid on linnadest: Pärnu, Paide, Jõhvi, Tallinn, Narva, Võru, Viljandi, Rakvere, Haapsalu, Valga, Tartu, Kuressaare.
-- Üllatusi polnud kui siis oli tüütu linnasid pikast tabelist otsida, kuna need kordusid, sest väärtused olid erinevalt
-- Puuduvad andmed? Polnud.

-- Testisin vihjet
SELECT * FROM customers LIMIT 10;
