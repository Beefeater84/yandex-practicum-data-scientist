class Customer:
    def __init__(self, name: str):
        self.name = name
        # Добавьте сюда приватный атрибут "скидка"
        # со значением по умолчанию 10.
        self.__discount = 10

    # Метод set_discount() принимает на вход
    # новое значение для приватного атрибута "скидка".
    # Если new_value превышает 80 -
    # новое значение скидки должно стать 80.
    # Метод не должен ничего возвращать.
    def set_discount(self, new_value: int):
        ...

    # Метод get_price() получает на вход исходную стоимость товара
    # и должен вернуть новую цену товара с учётом
    # скидки покупателя.
    # Возвращаемое значение округлите до двух знаков после запятой.
    def get_price(self, price: int) -> float:
        ...
        return ...


# Проверим работу программы.
# Создаём объект покупателя:
customer = Customer('Иван Иванович')

original_price = 85

print(
    f'С исходной скидкой Иван Иванович заплатит '
    f'{customer.get_price(original_price)} рублей вместо {original_price}'
)
# Изменим скидку до неприемлемого уровня.
# Метод set_discount() должен установить размер скидки равным 80.
customer.set_discount(90)
print(
    f'С новой скидкой Иван Иванович заплатит '
    f'{customer.get_price(original_price)} рублей вместо {original_price}'
)