{Calculator} = require '../src/calculator'

exports.CalculatorTest =

    'number of copies returns default value of 2': (test) ->
        calculator = new Calculator
        result = calculator.numberOfCopies()
        test.equal(result, 2)
        test.done()

    'number of copies returns a value of 4 when the number of replicas is 3': (test) ->
        calculator = new Calculator(numberOfReplicas: 3)
        result = calculator.numberOfCopies()
        test.equal(result, 4)
        test.done()

    'total metadata returns default value of 312,000,000': (test) ->
        calculator = new Calculator
        result = calculator.totalMetadata()
        test.equal(result, 312000000)
        test.done()

    'total metadata returns a value of 3,480,000,000 when specifying multiple options to overwrite default values': (test) ->
        calculator = new Calculator(
        	numberOfReplicas: 2
        	numOfDocuments: 10000000
        	idSize: 60
        )
        result = calculator.totalMetadata()
        test.equal(result, 3480000000)
        test.done()

    'total dataset returns default value of 20,000,000,000': (test) ->
        calculator = new Calculator
        result = calculator.totalDataset()
        test.equal(result, 20000000000)
        test.done()

    'total dataset returns a value of 60,000,000,000 when specifying multiple options to overwrite default values': (test) ->
        calculator = new Calculator(
        	numberOfReplicas: 2
        	numOfDocuments: 10000000
        	valueSize: 2000
        )
        result = calculator.totalDataset()
        test.equal(result, 60000000000)
        test.done()

    'working set returns default value of 4,000,000,000': (test) ->
        calculator = new Calculator
        result = calculator.workingSet()
        test.equal(result, 4000000000)
        test.done()

    'working set returns a value of 30,000,000,000 when specifying multiple options to overwrite default values': (test) ->
        calculator = new Calculator(
        	numberOfReplicas: 2
        	numOfDocuments: 10000000
        	valueSize: 2000
        	workingSetPercentage: .5
        )
        result = calculator.workingSet()
        test.equal(result, 30000000000)
        test.done()

    'cluster ram quota required returns default value of 8': (test) ->
        calculator = new Calculator
        result = calculator.clusterRamQuotaRequired()
        test.equal(result, 8)
        test.done()

    'cluster ram quota required returns 63 when specifying multiple options to overwrite default values': (test) ->
    	calculator = new Calculator(
    		numberOfReplicas: 2
    		numOfDocuments: 10000000
    		idSize: 60
    		valueSize: 2000
    		workingSetPercentage: .5
    		storageType: Calculator.SPINNING_STORAGE_TYPE
    	)
    	result = calculator.clusterRamQuotaRequired()
    	test.equal(result, 63)
    	test.done()

    'overhead percentage returns default value of .25': (test) ->
        calculator = new Calculator
        result = calculator._overheadPercentage()
        test.equal(result, .25)
        test.done()

    'overhead percentage returns .30 when specifying a spinning disk storage type': (test) ->
        calculator = new Calculator(storageType: Calculator.SPINNING_STORAGE_TYPE)
        result = calculator._overheadPercentage()
        test.equal(result, .30)
        test.done()

    'number of nodes required is 6 when the required ram is 64GB and each node contains 11GB of available ram': (test) ->
    	calculator = new Calculator(
    		numberOfReplicas: 2
    		numOfDocuments: 10000000
    		idSize: 60
    		valueSize: 2000
    		workingSetPercentage: .5
    		storageType: Calculator.SPINNING_STORAGE_TYPE
    	)
    	ramRequired = calculator.clusterRamQuotaRequired()
    	nodesRequired = Calculator.numberOfNodesNeeded(ramRequired, 11)
    	test.equal(nodesRequired, 6)
    	test.done()

    'number of nodes required is 3 when the required ram is 64GB and each node contains 23GB of available ram': (test) ->
    	nodesRequired = Calculator.numberOfNodesNeeded(64, 23)
    	test.equal(nodesRequired, 3)
    	test.done()

    'number of nodes required is 0 when the required ram is 64GB and 0 is passed in as the ram available per node': (test) ->
    	nodesRequired = Calculator.numberOfNodesNeeded(64, 0) ? 0
    	test.equal(nodesRequired, 0)
    	test.done()