#!/usr/bin/env python
import re
from operator import add, sub, mul, truediv

def start():
    print("Give me something to calculate! 🖩😺")
    while True:
        user_input = input("> ")
        c = Calculator(rawstring=user_input)
        if c.error:
            print(f"sorry I didn't understand that. ({c.error_message})")
        else:
            print(c.result)

class CalculatorError(Exception):
    pass

class Calculator:

    operators = {
        "+": add,
        "-": sub,
        "x": mul,
        "*": mul,
        "/": truediv
    }

    def __init__(self, **kwargs):
        self.error = False
        self.rawstring = kwargs.get("rawstring")
        self.tokens = []
        self.first_number = None
        self.second_number = None
        self.operator = None
        self.operator_function = None
        self.error_message = ""
        self.result = None

        if self.rawstring:
            self.run()

    def run(self):
        try:
            self.tokenise()
            self.setValues()
            self.setOperator()
            self.calculate()
        except CalculatorError as e:
            self.error_message = e
            self.error = True

    def tokenise(self):
        op_string = re.escape("".join([*self.operators]))
        regex = f"([{op_string}]|[0-9.]+)"
        self.tokens = re.findall(regex, self.rawstring)

        if len(self.tokens) != 3:
            raise CalculatorError("tokenisation failed")

    def setValues(self):
        try:
            self.first_number = self.__get_number(self.tokens[0])
            self.second_number = self.__get_number(self.tokens[2])
        except ValueError:
            raise CalculatorError("converting to numbers failed")

    def __get_number(self, number_string):
        try:
            return int(number_string)
        except ValueError:
            return float(number_string)


    def setOperator(self):
        self.operator = self.tokens[1]
        if self.operator in self.operators.keys():
            self.operatorFunction = self.operators[self.operator]
        else:
            raise CalculatorError("setting operator failed")

    def calculate(self):
        try:
            self.result = self.operatorFunction(self.first_number, self.second_number)
        except:
            raise CalculatorError("calculating failed")

start()
