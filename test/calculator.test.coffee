{Calculator} = require '../src/calculator'

exports.CalculatorTest =

    'number of copies returns default value of 2': (test) ->
        calculator = new Calculator
        result = calculator.number_of_copies()
        test.equal(result, 2)
        test.done()

    'number of copies returns a value of 4 when the number of replicas is 3': (test) ->
        calculator = new Calculator(number_of_replicas: 3)
        result = calculator.number_of_copies()
        test.equal(result, 4)
        test.done()