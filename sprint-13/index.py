from sklearn.datasets import make_regression

# Генерация данных:
# 200 примеров (наблюдений)
# 5 признаков
# шум с дисперсией 15
# фиксированное случайное зерно для воспроизводимости

X, y = make_regression(n_samples=200, 
                       n_features=5,
                       noise=15,
                       random_state=42)

# Вывод размеров массивов
print("Размеры X:", X.shape)
