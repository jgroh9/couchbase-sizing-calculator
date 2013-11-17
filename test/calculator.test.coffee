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

    'total metadata returns default value of 312,000,000': (test) ->
        calculator = new Calculator
        result = calculator.total_metadata()
        test.equal(result, 312000000)
        test.done()

    'total metadata returns a value of 3,480,000,000 when specifying multiple options to overwrite default values': (test) ->
        calculator = new Calculator(
        	number_of_replicas: 2
        	num_of_documents: 10000000
        	id_size: 60
        )
        result = calculator.total_metadata()
        test.equal(result, 3480000000)
        test.done()