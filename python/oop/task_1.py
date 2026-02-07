class Product:
    # Опишите инициализатор класса.
    # Инициализатор должен принять на вход
    # название (name) и количество (quantity) товара.
    # В теле инициализатора задайте соответствующие атрибуты экземпляра класса.
    def __init__(self, name, quantity):
        self.name = name
        self.quantity = quantity

    def get_basic_info(self):
        return f'{self.name} (в наличии: {self.quantity})'

    def get_full_info(self):
        pass


class Kettlebell(Product):
    # Опишите инициализатор класса и переопределите метод get_full_info()
    def __init__(self, name, quantity, weight):
        self.weight = weight
        super().__init__(name, quantity)

    def get_full_info(self):
        return f'{self.get_basic_info()}. Вес: {self.weight} кг'


class Clothing(Product):
    # Опишите инициализатор класса и переопределите метод get_full_info()
    def __init__(self,  name, quantity, size):
        self.size = size
        super().__init__(name, quantity)

    def get_full_info(self):
        return f'{self.get_basic_info()}. Размер: {self.size}'


# Для проверки вашего кода создадим пару объектов...
small_kettlebell = Kettlebell('Гиря малая', 15, 2)
shirt = Clothing('Футболка', 5, 'L')

# ...и вызовем их методы:
print(small_kettlebell.get_full_info())
print(shirt.get_full_info())