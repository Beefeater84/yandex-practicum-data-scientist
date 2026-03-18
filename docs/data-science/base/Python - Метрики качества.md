2026-03-18 10:37
tags: #python 

## MAE

```python
import numpy as np

# Входные данные
x = np.array([30, 40, 50, 60])
y_true = np.array([4.7, 5.2, 6.0, 6.8])

# Параметры модели
w = 0.071
b = 2.48

# Предсказания модели
y_pred = w * x + b #[4.61, 5.32, 6.03, 6.74]

def mae(y_true, y_pred):
	return np.mean(np.abs(y_true - y_pred))

print(f"MAE: {mae(y_true, y_pred):.3f}")

```

## MAPE

```python

def mape(y_true, y_pred):
	return np.mean(np.abs((y_true - y_pred) / y_true)) * 100

print(f"MAPE: {mape(y_true, y_pred):.2f}%")

```

## MSE , RMSE , R^2 

```python
import numpy as np

# Истинные значения целевой переменной
y_true = np.array([4.7, 5.2, 6.0, 6.8])

# Предсказания модели
y_pred = np.array([4.61, 5.32, 6.03, 6.74])

def mean_squared_error(y_true, y_pred):
    # Вычислите ошибки для каждого объекта
    errors = y_true - y_pred

    # Возведите значения ошибок в квадрат
    squared_errors = errors**2

    # Усредните квадраты ошибок по всем объектам
    mse = np.mean(squared_errors)
    
    return mse 

def root_mean_squared_error(y_true, y_pred):
    # Рассчитайте MSE, используя функцию mean_squared_error(y_true, y_pred)
    mse =  mean_squared_error(y_true, y_pred)
    
    # Вычислите корень квадратный из MSE
    rmse = np.sqrt(mse)
    
    return rmse 

def r2_score(y_true, y_pred):
    # Вычислите сумму квадратов ошибок
    ss_res = np.sum((y_true - y_pred)**2)
       
    # Среднее значение целевой переменной
    y_mean  = np.mean(y_true)
    # Вычислите сумму квадратов отклонений от среднего
    ss_tot = np.sum((y_true - y_mean)**2)
    
    # Рассчитайте коэффициент детерминации
    r2 = 1 - ss_res / ss_tot
    
    return r2 

# Расчёт метрик
print(f"MSE: {mean_squared_error(y_true, y_pred):.3f}")
print(f"RMSE: {root_mean_squared_error(y_true, y_pred):.3f}")
print(f"R²: {r2_score(y_true, y_pred):.4f}")

```

## Links
[[МО - Метрики качества]]
