import numpy as np
from sklearn.linear_model import SGDRegressor
from sklearn.metrics import mean_squared_error, r2_score
from sklearn.preprocessing import PolynomialFeatures
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import train_test_split

np.random.seed(42)


# Задаем сетку параметров
params_list = [
    {'max_iter': 500, 'learning_rate': 'invscaling', 'eta0': 0.01},
    {'max_iter': 1000, 'learning_rate': 'constant', 'eta0': 0.001},
    {'max_iter': 1000, 'learning_rate': 'adaptive', 'eta0': 0.01},
]


# Создаём данные
X = np.linspace(0, 10, 100).reshape(-1, 1)
y = 2 * X.squeeze()**2 + 10 * np.sin(X.squeeze()) + 2 * X.squeeze() + 5 + np.random.normal(0, 60, size=100)

# Сначала делим: 80% train+val, 20% test
X_train_val, X_test, y_train_val, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Теперь от 80% отделяем 10% под val (0.1 * 80% = 8%)
X_train, X_val, y_train, y_val = train_test_split(X_train_val, y_train_val, test_size=0.1, random_state=42)


# Инициализация переменных для хранения лучшей модели и её метрик
best_model = None
best_val_mse = float('inf')
best_val_r2 = float('-inf')
best_params = None

# Перебираем все наборы параметров из списка params_list
for params in params_list:
# Создаём модель
    model = make_pipeline(
        PolynomialFeatures(degree=1),
        SGDRegressor(random_state=42, **params)
    )
# Обучаем модель на тренировочных данных
    model.fit(X_train, y_train)
# Предсказываем целевую переменную на валидационной выборке
    y_val_pred = model.predict(X_val)
# Вычисляем метрики качества
    val_mse = mean_squared_error(y_val, y_val_pred)
    val_r2 = r2_score(y_val, y_val_pred)
# Выводим параметры и результаты для текущей модели
    print(f"Параметры: {params}, Validation MSE: {val_mse:.2f}, Validation R²: {val_r2:.2f}")
    
# Если текущая модель лучше предыдущих по MSE, сохраняем её как лучшую
    if val_mse < best_val_mse:
        best_val_mse = val_mse
        best_val_r2 = val_r2
        best_model = model
        best_params = params

# Выводим параметры и метрики лучшей модели после перебора всех вариантов
print(f"\nЛучшие параметры: {best_params}, Validation MSE = {best_val_mse:.2f}, Validation R² = {best_val_r2:.2f}")