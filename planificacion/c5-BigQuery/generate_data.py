
import csv
import random
from faker import Faker
import datetime

fake = Faker()

# --- Generate dim_productos.csv ---
productos_data = []
categorias = ['Tecnología', 'Hogar', 'Oficina']
for i in range(1, 1001):
    productos_data.append([
        i,
        fake.word().capitalize() + ' ' + fake.word().capitalize(),
        random.choice(categorias)
    ])

with open('dim_productos.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['producto_id', 'nombre', 'categoria'])
    writer.writerows(productos_data)

# --- Generate fact_ventas.csv ---
ventas_data = []
start_date = datetime.date(2023, 1, 1)
end_date = datetime.date(2024, 12, 31)

for _ in range(1000):
    fecha = fake.date_between(start_date=start_date, end_date=end_date)
    ventas_data.append([
        fecha.strftime('%Y-%m-%d'),
        random.randint(1, 1000),  # producto_id
        random.randint(101, 600),   # cliente_id
        random.randint(10, 50),     # vendedor_id
        random.randint(1, 5),       # cantidad
        round(random.uniform(50.0, 2000.0), 2)  # monto
    ])

with open('fact_ventas.csv', 'w', newline='', encoding='utf-8') as f:
    writer = csv.writer(f)
    writer.writerow(['fecha', 'producto_id', 'cliente_id', 'vendedor_id', 'cantidad', 'monto'])
    writer.writerows(ventas_data)

print("Generated dim_productos.csv and fact_ventas.csv successfully.")
