2026-03-04 09:33
tags: #python 


## Вывод категориальных данных

Мы пытаемся:
- визуально найти явные дубликаты
- оценить количество значений в каждой колонке, чтобы понять какими графиками в будущем их оценивать

```python
## Вывод уникальных значений категориальных данных
for column in category_cols: 
	unique_vals = df[column].sort_values().unique() 
	print(f'Столбец "{column}" — {len(unique_vals)} уникальных значений:') 
	print(', '.join(map(str, unique_vals))) 
	print()

```

```python
def lowercase_categories(df, columns):
    for col in columns:
        # Проверяем, что столбец содержит строковые данные перед преобразованием
        if df[col].dtype == 'object':
            df[col] = df[col].str.lower()
    return df

# Применение:
df = lowercase_categories(df, category_cols)

```

## Вывод количественных данных

- Мы анализируем выбросы.

В построении графиков нам помогают 2 диаграммы: 
- гистограмма распределения
- ящих с усами

[[Pandas - популярные функции подсчета]]
[[Seaborn - библиотека визуализации]]

```python

# Проверим значения в количественных колонках
for column in num_cols:
    print(f'Значения в {column}:')
    print(df[column].describe())
    print()
    
    
## Функция для вывода KDE и boxplot
def plot_numeric_kde_box(df, columns):
    """
    Строит KDE и boxplot для каждой числовой колонки.
    """

    for column in columns:
        data = df[column].dropna()

        fig, axes = plt.subplots(1, 2, figsize=(14, 4))

        # --- KDE ---
        sns.kdeplot(data=data, ax=axes[0], fill=True)
        axes[0].set_title(f'KDE распределение: {column}')
        axes[0].set_xlabel(column)
        axes[0].set_ylabel('Density')

        # --- Boxplot ---
        sns.boxplot(y=data, ax=axes[1])
        axes[1].set_title(f'Boxplot: {column}')
        axes[1].set_ylabel(column)

        plt.tight_layout()
        plt.show()
        
## Выводим boxplot и распределение числовых колонок
plot_numeric_kde_box(
    df,
    num_cols
)

```

### После анализа количественных данных - удаляем выбросы

```python
## Оцениваем все количественные колонки - после какого перцентиля идет больше всего выбросов и какой % от df придется удалить
def check_outliers(df, columns, percentile=0.99):
    """
    Оценка количества выбросов выше заданного перцентиля.

    df: DataFrame
    columns: list[str] — список числовых колонок
    percentile: float — например 0.99, 0.95, 0.995
    """

    for column in columns:
        data = df[column].dropna()
        threshold = data.quantile(percentile)

        count = (data > threshold).sum()
        share = (data > threshold).mean()

        print(f"\nКолонка: {column}")
        print(f"{int(percentile*100)}-й перцентиль: {threshold:,.2f}")
        print(f"Количество значений выше: {count}")
        print(f"Доля: {share*100:.3f}%")


## Вывод функции
# Пытаемся найти баланс - при каком перцентиле останется максимум значений, но без явных выбросов
check_outliers(df, num_cols, percentile=0.99)

```


```python

## фильтрация датафрейма от выбросов
def filter_by_percentiles(df, percentiles_dict):
    """
    Фильтрация датафрейма по разным перцентилям для разных колонок.
    ВАЖНО: Если в данных есть пропуски - то эта функция их отфильрует
    percentiles_dict: dict
        пример:
        {
            'tickets_count': 0.99,
            'revenue_rub': 0.995
        }
    """
    df_filtered = df.copy()
    for column, percentile in percentiles_dict.items():
        threshold = df_filtered[column].quantile(percentile)
        df_filtered = df_filtered[df_filtered[column] <= threshold]
        print(f"{column}: порог {int(percentile*100)}% = {threshold:,.2f}")
    
    original_len = len(df)
    filtered_len = len(df_filtered)
    removed = original_len - filtered_len
    removed_pct = removed / original_len * 100

    print(f"\nИсходный размер:   {original_len:,}")
    print(f"После фильтрации:  {filtered_len:,}")
    print(f"Удалено строк:     {removed:,} ({removed_pct:.2f}%)")
    
    return df_filtered
    
## Вызов фильрации
percentiles = {
    'revenue_rub': 0.99,
    'tickets_count': 0.99,
    'days_since_prev': 0.97
}

df = filter_by_percentiles(df, percentiles)

```

### Преобразуем типы в числовых данных

Для преобразования числовых в числовые, лучше всего подходит to_numeric

```python
	# Передаем в метод столбец датафрейма. У него одна задача - переводить строки в int или float
	df['column'] = pandas.to_numeric(df['column'])
	
# Меняем тип данных с помощью цикла
for column in num_cols:
    df[column] = pd.to_numeric(df[column], errors='coerce', downcast='integer') 

```

## Вывод диапазонов дат
- Выводим min / max даты
- Смотрим количество занений в каждом месяце ( дне )

```python

# смотрим min / max даты
df[date_cols].describe()


## Показ количества записей по месяцам
col = 'order_dt'
df[col].dt.to_period('M').value_counts().sort_index()

## синомимы
df.groupby(df[col].dt.to_period('M')).size().rename('count')
df.set_index(col).resample('ME').size().rename('count')

## Простая визуализация
monthly = df[col].dt.to_period('M').value_counts().sort_index()
## TODO! Переписать на seaborn
monthly.plot(kind='bar', figsize=(12, 4), title=f'Records per month: {col}')
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()


```

## Удаление неявных дубликатов

```python

# Определяем колонки, содержащие дубликаты
duplicate_cols = ['col']

# Оцениваем количество
df.duplicated(subset=columns_to_dupl).sum()

# Оцениваем визуально. Это выводит все дубликаты рядом
# keep=False — помечает ВСЕ строки (и оригинал и дубликат)
all_dups = df[df.duplicated(subset=dublicate_cols, keep=False)]
all_dups.sort_values(by=dublicate_cols)

## Удаление дубликатов со сбросом индексов
df = df.drop_duplicates().reset_index(drop=True)

```