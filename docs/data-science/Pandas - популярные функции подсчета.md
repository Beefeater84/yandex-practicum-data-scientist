2026-03-04 23:47
tags: #python 


```python

# Выводит список уникальных значений и сколько раз каждое встречается
df['column'].value_counts()

[1,1,1,2,3].value_counts() 
# 1 - 3
# 2 - 1
# 3 - 1

# Выводит список уникальных значений и долю сколько раз оно встречается
df['column'].value_counts(normalize=True)

## Кыводит сколько всего уникальных значений
df['column_name'].nunique(dropna=False)

[1,1,1,2,3].nunique(dropna=False) 
# 3

```
