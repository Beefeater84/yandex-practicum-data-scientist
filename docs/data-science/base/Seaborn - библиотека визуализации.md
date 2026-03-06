2026-03-04 09:20
tags: #python 

Современная библиотека для более быстрого вывода графиков, под капотом использует matplotlib

## Импорт бибилотеки

```python
import seaborn as sns 
```


## Как пользоваться
Помимо документации - помним, что библиотека постоена над `matplotlib`, поэтому многие функции ставятся все равно через matplotlib вокруг seaborn

```python

sns.histplot(data, bins=30, kde=True) # kde — кривая плотности бесплатно plt.show()
# График через seaborn, а недостающее управление, все равно через plt
plt.xticks(rotation=45) 
plt.tight_layout() 
plt.show()

```

## Основные графики

### Гистограмма
[seaborn.histplot — seaborn 0.13.2 documentation](https://seaborn.pydata.org/generated/seaborn.histplot.html)

```python

sns.histplot(data, bins=30, kde=True) # kde — кривая плотности бесплатно plt.show()

```


### Boxplot - ящик с усами
[seaborn.boxplot — seaborn 0.13.2 documentation](https://seaborn.pydata.org/generated/seaborn.boxplot.html#)

```python

sns.boxplot(y=data)
# или более современный вариант:
sns.violinplot(y=data)  # сразу видно распределение

```

### Bar - отдельно стоящие бары
[seaborn.barplot — seaborn 0.13.2 documentation](https://seaborn.pydata.org/generated/seaborn.barplot.html#seaborn.barplot)

```python

sns.barplot(data=data)

```


---
## Links

- doc - https://seaborn.pydata.org/

