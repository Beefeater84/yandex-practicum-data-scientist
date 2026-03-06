2026-03-06 11:59
tags: #

Ссылка на урок: [Спринт 11/25: Инструменты разработки для Data Science + ООП → Тема 4/8: Система контроля и управления версиями → Урок 11/12: Лучшие практики по оформлению репозиториев]( https://practicum.yandex.ru/learn/data-scientist-plus/courses/64644970-05e9-49db-bba4-195968771d65/sprints/743729/topics/9c8e1768-26fc-48bf-b835-90484725aefe/lessons/42ed754d-8aac-47fc-87ad-6664891108f7/#81496f73-5b61-4244-858a-a0791b185ff0 )

Пример такого репозитория:
[treeverse/example-get-started: Get started DVC project (NLP, random forest)](https://github.com/treeverse/example-get-started)

```
project_name/
│
├── requirements.txt    # Список зависимостей проекта
├── README.md           # Описание проекта
├── .gitignore          # Файл игнорирования для Git
├── setup.py            # Скрипт установки
│
├── data/               # Данные
│   ├── raw/            # Необработанные данные
│   └── processed/      # Предобработанные данные
│
├── notebooks/          # Jupyter-ноутбуки с исследованиями
│
├── src/                # Исходный код проекта
│   ├── data/           # Код для загрузки данных
│   ├── features/       # Код для подготовки данных
│   ├── models/         # Код для создания моделей
│   └── utils.py        # Вспомогательные функции
│
├── models/             # Сохранённые модели
│
├── docs/               # Документация
│
└── tests/              # Тесты

```

- `setup.py` — скрипт для установки, если нужно, чтобы проект работал как Python-библиотека.