# UrbanStyle Operations Dashboard — Liisi Vaade (Nädal 5)

## 📌 Projekti Ülevaade
Selle projekti eesmärk on pakkuda UrbanStyle'i operatsioonijuht Liis Koppelile ülevaadet kaupluste müügijaotusest ning laoseisude üldisest olukorrast, et tuvastada võimalikud laopuudujäägid ja operatiivsed "punased lipud".

---

## 📊 Visualiseering
![Operations Dashboard](dashboard_overview.png)

---

## 🛠️ Kasutatud Tööriistad ja Andmetöötlus
* **Tööriist:** Power BI Desktop
* **Andmebaas:** PostgreSQL (Supabase)
* **Andmetöötlus:** 
  * Puhastatud inventuuriandmed: eemaldatud vigased negatiivsed kogused (`quantity_available >= 0`).
  * Filtreeritud aegunud kirjed (rakendatud kuupäevafilter viimase inventuuritükelduse kohta).

---

## 🎨 Disainiotsused
1. **Diagrammitüübid:** 
   * *Müük kaupluste lõikes:* Tulpdiagramm (esitab selgelt 4 peamist müügikanalit: Tallinn, Tartu, Pärnu, Online).
   * *Laoseisud kategooriate kaupa:* Püstine tulpdiagramm, sorteeritud suurimast väikseimani.
2. **Värvilahendus:**
   * Peamine brändivärv: UrbanStyle Teal (`#009B8D`).
   * Tingimuslik vormindamine (Conditional Formatting): Kriitilised või miinuses laoseisud värvitakse automaatselt punaseks (`#D9534F`).
3. **Paigutus (Layout):**
   * Ülevaatlik ja puhas ühe ekraani vaade ilma liigse visuaalse mürata (kõrge *data-ink ratio*).

---

## 💡 Äritõlgendus Liisile
* **Müük kaupluste lõikes:**
  > *"Liis, müügitulust moodustab suurima osa Tallinn ja füüsilistest kauplustest samuti Tallinn. Tartu ja Pärnu poed annavad stabiilse panuse, kuid e-pood on meie peamine müügivedur."*
* **Laoseisude jaotus ja varude tervis:**
  > *"Puhastatud andmete põhjal näeme, et laoseisud on kõigis kategooriates piisavad ning kriitilisi laopuudujääke ei esine — madalaima kategooria laoseis on samuti turvalises vahemikus."*