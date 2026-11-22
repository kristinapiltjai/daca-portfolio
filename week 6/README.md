# 📊 UrbanStyle Tallinna Esinduskaupluse Müügianalüüs (2023–2024)

## 📌 Projekti ülevaade
Selle projekti raames analüüsisin **UrbanStyle'i Tallinna esinduskaupluse** müügiandmeid perioodil **01.01.2023 – 31.12.2024**. Eesmärk oli luua juhtkonnale selge ja interaktiivne Power BI dashboard, mis toob välja müügitrendid, suurimad müügivedurid ning valdkonnad, mis vajavad optimeerimist.

---

## 🚀 Peamised tulemused (*Executive Summary*)

* **Müügivedur (Kategooria):** Tallinna kaupluse käivet juhivad selgelt **meeste riided** (suurima müügituluga kategooria).
* **TOP tooted:** Enim tulu toovad tooted on **õhuline sünteetiline kõrge kontsaga kingad** ja **praktiline džersii seelik**.
* **Pühademüügi hüpe:** Müügitulu saavutas tipu 2024. aasta detsembris (**63 134,16 €**), näidates võimast **+60,32% kasvu** võrreldes novembriga (**39 379,69 €**).
* **Madala tulemusega segmendid:** 
  * Kõige väiksema müügituluga kategooria on **laste riided**.
  * Nõrgima läbimüögiga üksiktooted on *sportlik villane tossud*, *soe teksane chino püksid*, *praktiline viskoosne jakk* ja *praktiline merino villane parka*.

---

## 📈 Power BI Dashboardi Visualiseerimine & Kujundus

Dashboard hõlmab järgmisi visualisatsioone ja analüütilisi elemente:

1. **Igakuine müügitulude joondiagramm (2023–2024):**
   * Kuvab kõiki 24 kuud järjestikku kahekorruselisel X-teljel (*Year & Month*).
   * Sisaldab **keskmise müügitulu viitejoont** (*Average line*), mis raamistab igakuist tulemuslikkust.
   * Sisaldab annotatsiooni detsembri pühademüügi tipu juures (`Pühademüük: +60,3%`).

2. **Kategooriate ja toodete tulpdiagrammid:**
   * Tõstavad esile TOP tooted vs nõrgima läbimüügiga tooted.
   * Sisaldavad annotatsiooni suurima käibega kategooria juures (`TOP: Meeste riided`).

3. **KPI Kaardid (Key Performance Indicators):**
   * Kogumüügitulu (*Sum of Total Price*).
   * Keskmine ostukorvi väärtus / tellimus (*AOV – Average Order Value*).

---

## 🛠️ Tehnilised lahendused (DAX & Filtrid)

* **Ajavahemiku filtreerimine:** Lehe-taseme filtriga (*Filters on this page*) on valitud vahemik `01.01.2023 – 31.12.2024`.
* **Aasta-Kuu koondveerg (DAX):**
  ```dax
  YearMonth = FORMAT('public sales'[sale_date], "YYYY-MM")