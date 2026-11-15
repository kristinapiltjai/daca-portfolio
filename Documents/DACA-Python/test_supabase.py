from supabase import create_client

# Sinu Supabase URL ja võti
url = "https://ezihblbfabxvfdyfzvac.supabase.co"
key = "sb_publishable_Zn40-QwYR7N76ZderBCHUA_J6SOxzu2"

supabase = create_client(url, key)

# Pärime andmed tabelist 'sales'
response = supabase.table('sales_test').select("*").execute()

print(f"Leitud ridu: {len(response.data)}")
for row in response.data:
    print(row)