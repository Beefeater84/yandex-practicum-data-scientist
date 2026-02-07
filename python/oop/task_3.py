class Customer:
    def __init__(self, name: str):
        self.name = name
        # Add a private attribute "discount" here
        # with a default value of 10.
        self.__discount = 10

    # The set_discount() method takes
    # a new value for the private attribute "discount".
    # If new_value exceeds 80 -
    # the new discount value should become 80.
    # The method should not return anything.
    def set_discount(self, new_value: int):
        if new_value > 80:
            self.__discount = 80
        else:
            self.__discount = new_value

    # The get_price() method takes the original price of the product
    # and should return the new price of the product considering
    # the customer's discount.
    # Round the return value to two decimal places.
    def get_price(self, price: int) -> float:
        
        return round(price * (1 - self.__discount / 100), 2)


# Let's test the program.
# Create a customer object:
customer = Customer('Иван Иванович')

original_price = 85

print(
    f'With the initial discount, Иван Иванович will pay '
    f'{customer.get_price(original_price)} rubles instead of {original_price}'
)
# Change the discount to an unacceptable level.
# The set_discount() method should set the discount to 80.
customer.set_discount(90)
print(
    f'With the new discount, Иван Иванович will pay '
    f'{customer.get_price(original_price)} rubles instead of {original_price}'
)