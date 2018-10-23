#!/usr/bin/env python
from operator import add, sub, mul, truediv

operator_fns = {
    "+": add,
    "-": sub,
    "x": mul,
    "*": mul,
    "/": truediv
}

def run():
    print("Give me something to calculate! 🖩😺")
    while True:
        number1 = get_number_input()
        operator_fn= get_operator_fn()
        number2 = get_number_input()
        print(">>", operator_fn(number1, number2))


def get_number_input():
    while True:
        number_input = input("number > ")
        try:
            return float(number_input)
        except ValueError:
            print("please enter a number")
            continue

def get_operator_fn():
    operators = operator_fns.keys()
    while True:
        operator_input = input("operator > ")
        if operator_input in operators:
            return operator_fns[operator_input]
        else:
            print(", ".join(operators))
            continue

run()
