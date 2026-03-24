
import pandas as pd

df = pd.DataFrame({"value": [10, 20, 1500, 30, 200, 40]})

# Заменяем выбросы: все value, для которых не выполняется условие (value != 1500),
# будут заменены на значение 150
df["value_filled"] = df["value"].where(df["value"] != 1500, 150)


## -----------------------------------------   

df = pd.DataFrame({"value": [10, 12, 11, 13, 200, 14, 15]})

# Удаляем выбросы, находящиеся вне диапазона [50, 500]
# where - заменяет выбросы на NaN, dropna() - удаляет строки с NaN
df_cleaned = df.where((df["value"] >= 50) & (df["value"] <= 500)).dropna()

