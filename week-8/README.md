## Nädal 8: API Integration & Data Fetching (Supabase)

### Roll: Roll A (API Query)
**Eesmärk:** Luua automaatne, turvaline ja modulaarne Pythoni lahendus UrbanStyle andmete pärimiseks Supabase API-st.

### Tehtud tööd:
- **Töökindel moodul (`data_fetcher.py`):** Ehitatud universaalne funktsioon `fetch_table_data()`, mis toetab kõigi tabelite pärimist ja kuupäevade filtreerimist.
- **Automaatne pagineerimine:** Teostatud pagineerimise loogika (`range()`), mis võimaldab piiranguteta laadida suuri andmestikke osade kaupa.
- **Dünaamiline keskkonnahaldus:** Seadistatud automaatne `.env` faili otsing üle erinevate kaustateekondade.
- **Veakäsitlus:** Lisatud `try/except` plokid selgete teadetega ühenduse või API võtmete vigade korral.

### Saavutatud tulemused:
- 📊 **Sales data:** 10 118 rida
- 👥 **Customers data:** 3 150 rida
- 📦 **Products data:** 362 rida

### Kasutatud tehnoloogiad:
`Python` | `pandas` | `supabase-py` | `python-dotenv` | `Git`