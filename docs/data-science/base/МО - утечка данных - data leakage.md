2026-03-22 11:00
tags: #машинное-обучение 

Утечка данных - когда мы каким-то образом даем модели подсмотреть тестовые данные. Это может случиться во время маштабирования признаков [[МО - маштабирование признаков]]

Поэтому мы высчитываем Min-max или Стандартизацию только на тренировочных данных, и потом эти числа применяем и к тестовым. 


![[leakage-1.png]]

## Links

[yandex-practicum-data-scientist/sprint-13/notebooks/Normalization.ipynb at main · Beefeater84/yandex-practicum-data-scientist](https://github.com/Beefeater84/yandex-practicum-data-scientist/blob/main/sprint-13/notebooks/Normalization.ipynb)