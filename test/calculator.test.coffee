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

    'total dataset returns default value of 20,000,000,000': (test) ->
        calculator = new Calculator
        result = calculator.total_dataset()
        test.equal(result, 20000000000)
        test.done()

    'total dataset returns a value of 60,000,000,000 when specifying multiple options to overwrite default values': (test) ->
        calculator = new Calculator(
        	number_of_replicas: 2
        	num_of_documents: 10000000
        	value_size: 2000
        )
        result = calculator.total_dataset()
        test.equal(result, 60000000000)
        test.done()

    'working set returns default value of 4,000,000,000': (test) ->
        calculator = new Calculator
        result = calculator.working_set()
        test.equal(result, 4000000000)
        test.done()

    'working set returns a value of 30,000,000,000 when specifying multiple options to overwrite default values': (test) ->
        calculator = new Calculator(
        	number_of_replicas: 2
        	num_of_documents: 10000000
        	value_size: 2000
        	working_set_percentage: .5
        )
        result = calculator.working_set()
        test.equal(result, 30000000000)
        test.done()

    'cluster ram quota required returns default value of 8': (test) ->
        calculator = new Calculator
        result = calculator.cluster_ram_quota_required()
        test.equal(result, 8)
        test.done()

    'cluster ram quota required returns 63 when specifying multiple options to overwrite default values': (test) ->
    	calculator = new Calculator(
    		number_of_replicas: 2
    		num_of_documents: 10000000
    		id_size: 60
    		value_size: 2000
    		working_set_percentage: .5
    		storage_type: Calculator.SPINNING_STORAGE_TYPE
    	)
    	result = calculator.cluster_ram_quota_required()
    	test.equal(result, 63)
    	test.done()

    'overhead percentage returns default value of .25': (test) ->
        calculator = new Calculator
        result = calculator._overhead_percentage()
        test.equal(result, .25)
        test.done()

    'overhead percentage returns .30 when specifying a spinning disk storage type': (test) ->
        calculator = new Calculator(storage_type: Calculator.SPINNING_STORAGE_TYPE)
        result = calculator._overhead_percentage()
        test.equal(result, .30)
        test.done()

    'number of nodes required is 6 when the required ram is 64GB and each node contains 11GB of available ram': (test) ->
    	calculator = new Calculator(
    		number_of_replicas: 2
    		num_of_documents: 10000000
    		id_size: 60
    		value_size: 2000
    		working_set_percentage: .5
    		storage_type: Calculator.SPINNING_STORAGE_TYPE
    	)
    	ram_required = calculator.cluster_ram_quota_required()
    	nodes_required = Calculator.number_of_nodes_needed(ram_required, 11)
    	test.equal(nodes_required, 6)
    	test.done()

    'number of nodes required is 3 when the required ram is 64GB and each node contains 23GB of available ram': (test) ->
    	nodes_required = Calculator.number_of_nodes_needed(64, 23)
    	test.equal(nodes_required, 3)
    	test.done()

    'number of nodes required is 0 when the required ram is 64GB and 0 is passed in as the ram available per node': (test) ->
    	nodes_required = Calculator.number_of_nodes_needed(64, 0) ? 0
    	test.equal(nodes_required, 0)
    	test.done()