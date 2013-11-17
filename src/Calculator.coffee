#START:Calculator
class Calculator
	@METADATA_PER_DOCUMENT = 56
	@OLD_METADATA_PER_DOCUMENT = 64
	@SSD_STORAGE_TYPE = 'ssd'
	@SPINNING_STORAGE_TYPE = 'spinning'

	# Default options
	@DEFAULTS = 
		numOfDocuments: 1000000
		idSize: 100
		valueSize: 10000
		numberOfReplicas: 1
		workingSetPercentage: .2
		metadataPerDocument: @METADATA_PER_DOCUMENT
		storageType: @SSD_STORAGE_TYPE
		highWaterMark: .7

	constructor: (options={}) ->
		# if running this code in a browser and you have jQuery available you can simplify the constructor logic
		# by uncommenting the line below and removing the remaining code below that line.
		#@options = $.extend({}, @defaults, options)
		@options = {}		
		@options.numOfDocuments			= options.numOfDocuments 		? @constructor.DEFAULTS.numOfDocuments
		@options.idSize 				= options.idSize 				? @constructor.DEFAULTS.idSize
		@options.valueSize				= options.valueSize 			? @constructor.DEFAULTS.valueSize
		@options.numberOfReplicas		= options.numberOfReplicas 		? @constructor.DEFAULTS.numberOfReplicas
		@options.workingSetPercentage	= options.workingSetPercentage	? @constructor.DEFAULTS.workingSetPercentage
		@options.metadataPerDocument 	= options.metadataPerDocument 	? @constructor.DEFAULTS.metadataPerDocument
		@options.storageType 			= options.storageType 			? @constructor.DEFAULTS.storageType
		@options.highWaterMark 			= options.highWaterMark 		? @constructor.DEFAULTS.highWaterMark		

	numberOfCopies: ->
		# 1 + numberOfReplicas
		1 + @options.numberOfReplicas

	totalMetadata: ->
		# numOfDocuments * (metadataPerDocument + idSize) * numberOfCopies
		@options.numOfDocuments * (@options.metadataPerDocument + @options.idSize) * @numberOfCopies()

	totalDataset: ->
		# numOfDocuments * valueSize * numberOfCopies
		@options.numOfDocuments * @options.valueSize * @numberOfCopies()

	workingSet: ->
		# totalDataset * workingSetPercentage
		@totalDataset() * @options.workingSetPercentage

	clusterRamQuotaRequired: ->
		# divide the ram quota by 1,000,000,000 so that we get an approx. value in Gigabytes
		# always round up by using ceiling so that we ensure we have enough ram specified
		# (totalMetadata + workingSet) * (1 + _overheadPercentage) / (highWaterMark)
		Math.ceil(((@totalMetadata() + @workingSet()) * (1 + @_overheadPercentage()) / @options.highWaterMark) / 1000000000)

	_overheadPercentage: ->
		if (@options.storageType.toLowerCase() == Calculator.SPINNING_STORAGE_TYPE) then .30 else .25

	# create a class method since we do not require access to any other properties or methods within the scope of the class
	@numberOfNodesNeeded: (ramRequired, ramPerNode) ->
    	return if ramPerNode == 0
    	Math.ceil(ramRequired / ramPerNode)
#END:Calculator

root = exports ? window
root.Calculator = Calculator