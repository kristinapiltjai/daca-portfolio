# UrbanStyle RFM Kliendisegmenteerimine & Python Pandas Analüüs (Nädal 7 — Roll C)

## 📌 Projekti Ülevaade

Käesolev projekt on valminud **DACA (Data Analyst Career Accelerator)** programmi 7. nädala meeskonnatöö raames. Projekti eesmärk on viia läbi **UrbanStyle.ltd** e-kaubanduse kliendibaasi **RFM-analüüs** (*Recency, Frequency, Monetary*), puhastada ja liita andmed Pythoni ning `pandas` teegi abil ja moodustada käitumuslikud kliendisegmendid strateegiliste turundusotsuste tegemiseks.

Projekti rollijaotuses vastutab käesolev dokument **Roll C (Analysis — RFM kliendisegmenteerimine)** teostuse ja dokumentatsiooni eest.

---

## 🎯 Äriprobleem ja Eesmärgid

UrbanStyle'i turundus- ja müügitiim vajab täpset ülevaadet klientide ostukäitumisest. Seni on kõigile klientidele saadetud ühesuguseid masspostitusi, mis vähendab kampaaniate tasuvust ja suurendab klientide voolavust.

**Projekti peamised eesmärgid:**
1. **Andmete liitmine ja puhastamine (Roll B sisend):** Laadida Supabase cloud-andmebaasist `sales`, `customers` ja `products` tabelid ning ühendada need vigadeta Pandas DataFrame'iks.
2. **RFM meetrikate arvutamine:**
   - **Recency (R):** Mitukümmend päeva on möödunud kliendi viimasest ostust võrreldes viitekuupäevaga (`2025-02-28`).
   - **Frequency (F):** Mitu korda on klient tehinguid sooritanud.
   - **Monetary (M):** Kui palju on klient kokku raha kulutanud.
3. **Skoorimine kvintiilide alusel:** Määrata iga näitaja jaoks skoor vahemikus **1–5** kasutades `pd.qcut()` funktsiooni (arvestades Recency vastupidist skaalat ja Frequency korduvate väärtuste järjestamist `.rank(method='first')` abil).
4. **Kliendisegmentide moodustamine:** Liita skoorid `RFM_Score` väärtuseks (vahemikus 3–15) ja jaotada kliendid viide sihtsegmenti: **VIP Champions**, **Loyal**, **Potential**, **At Risk** ja **Lost**.
5. **Ärilised soovitused:** Esitada juhtkonnale ja turundusmeeskonnale tegevuskava iga segmendi kaasamiseks.

---

## 🧹 1. Samm: Andmete Laadimine ja Ettevalmistus

Andmed tõmmatakse Supabase PostgreSQL andmebaasist lehekülgede kaupa (pagineerimisega), tagades kõigi ridade kättesaamise ilma 1000-rea piiranguta.

### Põhitabelite Struktuur
* **`sales`**: `sale_id`, `customer_id`, `product_id`, `sale_date`, `total_price`
* **`customers`**: `customer_id`, `first_name`, `last_name`, `email`, `city`
* **`products`**: `product_id`, `product_name`, `category`, `retail_price`

---

## 📊 2. & 3. Samm: RFM Arvutuslogika ja Skoorimine

### 1. Viitekuupäev ja Recency
Viitekuupäevaks on määratud `today = pd.to_datetime('2025-02-28')`.
```python
df['sale_date'] = pd.to_datetime(df['sale_date'])
recency_df = df.groupby('customer_id')['sale_date'].max().reset_index()
recency_df['recency_days'] = (today - recency_df['sale_date']).dt.days
2. Frequency ja Monetary
frequency_df = df.groupby('customer_id')['sale_id'].count().reset_index()
frequency_df.columns = ['customer_id', 'frequency']

monetary_df = df.groupby('customer_id')['total_price'].sum().reset_index()
monetary_df.columns = ['customer_id', 'monetary_value']
3. Tabelite Liitmine ja Skoorimine (1–5)
rfm = pd.merge(recency_df[['customer_id', 'recency_days']], frequency_df, on='customer_id')
rfm = pd.merge(rfm, monetary_df, on='customer_id')

# Recency (Vastupidine: 1-5, kus vähem päevi = skoor 5)
rfm['R_score'] = pd.qcut(rfm['recency_days'], 5, labels=[5, 4, 3, 2, 1]).astype(int)

# Frequency (.rank(method='first') lahendab kattuvad tehinguarvud)
rfm['F_score'] = pd.qcut(rfm['frequency'].rank(method='first'), 5, labels=[1, 2, 3, 4, 5]).astype(int)

# Monetary (kõrgem kulutus = skoor 5)
rfm['M_score'] = pd.qcut(rfm['monetary_value'], 5, labels=[1, 2, 3, 4, 5]).astype(int)

# RFM Koguskoor
rfm['RFM_Score'] = rfm['R_score'] + rfm['F_score'] + rfm['M_score']
📈 4. Samm: Kliendisegmendid ja Kokkuvõte
Koguskoori (RFM_Score) alusel määratakse igale kliendile täpne käitumuslik segment:
Segment
RFM Koguskoor
Kirjeldus & Iseloomustus
VIP Champions
13 – 15
Kõige väärtuslikumad kliendid. Ostavad tihti, hiljuti ja suurtes summades.
Loyal
10 – 12
Stabiilsed püsikliendid. Regulaarne ostuaktiivsus ja hea käive.
Potential
7 – 9
Potentsiaalikad kliendid. Vajavad täiendavat julgustust püsikliendiks saamiseks.
At Risk
4 – 6
Ohus olevad kliendid. Varem aktiivsed, kuid pole pikemat aega ostnud.
Lost
3
Inaktiivsed või kaotatud kliendid. Madalaim ostusagedus ja -summa.
📝 Juhtide Kokkuvõte & Ärilised Soovitused (Executive Summary)
📌 STRATEEGILISED TURUNDUSSOOVITUSED SEGMENTIDE LÕIKES
VIP Champions (Skoor 13–15):
Eesmärk: Hoida rahulolu ja suurendada brändilojaalsust.
Tegevus: Eksklusiivne varajane ligipääs uutele kollektsioonidele, VIP-ürituste kutsed ja personaalne klienditeenindus.
Loyal Customers (Skoor 10–12):
Eesmärk: Tõsta keskmist ostukorvi suurust (AOV).
Tegevus: Ristmüügi (cross-sell) ja lisamüügi (up-sell) pakkumised, lojaalsusprogrammi boonuspunktid.
Potential Loyalists (Skoor 7–9):
Eesmärk: Muuta korduvostjad püsiklientideks.
Tegevus: Personaalsed tootesoovitused viimati vaadatud/ostetud kategooriate põhjal ning ajaliselt piiratud sooduskupongid.
At Risk (Skoor 4–6):
Eesmärk: Äratada huvi ja vältida kliendi lõplikku kaotamist.
Tegevus: "Me igatseme sind" tagasivõitmise e-kirjad koos erilise allahindluskoodiga.
Lost (Skoor 3):
Eesmärk: Minimeerida turunduskulusid või proovida viimast reaktivatsiooni.
Tegevus: Automatiseeritud madala kuluga taastusturundus; kui reageerimist ei tule, eemaldada aktiivsetest meililistidest.
🛠️ Täielik Python / Pandas Kood (Roll C)
import os
import pandas as pd
from dotenv import load_dotenv
from supabase import create_client

# 1. Keskkonna ja Supabase ühenduse seadistamine
load_dotenv()
supabase = create_client(os.getenv('SUPABASE_URL'), os.getenv('SUPABASE_KEY'))

# 2. Andmete laadimine pagineerimisega
def get_data(table_name):
    data = []
    page_size = 1000
    page = 0
    while True:
        response = (
            supabase.table(table_name)
            .select('*')
            .range(page * page_size, (page + 1) * page_size - 1)
            .execute()
        )
        data.extend(response.data)
        if len(response.data) < page_size:
            break
        page += 1
    return pd.DataFrame(data)

df = get_data('sales')
customers_df = get_data('customers')

# 3. Andmetüüpide korrastamine
df['sale_date'] = pd.to_datetime(df['sale_date'])
today = pd.to_datetime('2025-02-28')

# 4. R, F, M arvutused
recency_df = df.groupby('customer_id')['sale_date'].max().reset_index()
recency_df['recency_days'] = (today - recency_df['sale_date']).dt.days

frequency_df = df.groupby('customer_id')['sale_id'].count().reset_index()
frequency_df.columns = ['customer_id', 'frequency']

monetary_df = df.groupby('customer_id')['total_price'].sum().reset_index()
monetary_df.columns = ['customer_id', 'monetary_value']

# 5. Tabelite liitmine
rfm = pd.merge(recency_df[['customer_id', 'recency_days']], frequency_df, on='customer_id')
rfm = pd.merge(rfm, monetary_df, on='customer_id')

# 6. Skoorimine
rfm['R_score'] = pd.qcut(rfm['recency_days'], 5, labels=[5, 4, 3, 2, 1]).astype(int)
rfm['F_score'] = pd.qcut(rfm['frequency'].rank(method='first'), 5, labels=[1, 2, 3, 4, 5]).astype(int)
rfm['M_score'] = pd.qcut(rfm['monetary_value'], 5, labels=[1, 2, 3, 4, 5]).astype(int)

rfm['RFM_Score'] = rfm['R_score'] + rfm['F_score'] + rfm['M_score']

# 7. Segmentide määramine
def get_segment(score):
    if score >= 13:
        return 'VIP Champions'
    elif score >= 10:
        return 'Loyal'
    elif score >= 7:
        return 'Potential'
    elif score >= 4:
        return 'At Risk'
    else:
        return 'Lost'

rfm['Segment'] = rfm['RFM_Score'].apply(get_segment)

# 8. Tulemuste trükkimine
summary = pd.DataFrame({
    'Arv': rfm['Segment'].value_counts(),
    'Osakaal (%)': (rfm['Segment'].value_counts(normalize=True) * 100).round(1)
})

print("=== RFM SEGMENTIDE KOKKUVÕTE ===")
print(summary)