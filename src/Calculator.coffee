#START:Calculator
class Calculator
	@METADATA_PER_DOCUMENT = 56
	@OLD_METADATA_PER_DOCUMENT = 64
	@SSD_STORAGE_TYPE = 'ssd'
	@SPINNING_STORAGE_TYPE = 'spinning'

	# Default options
	@DEFAULTS = 
		num_of_documents: 1000000
		id_size: 100
		value_size: 10000
		number_of_replicas: 1
		working_set_percentage: .2
		metadata_per_document: @METADATA_PER_DOCUMENT
		storage_type: @SSD_STORAGE_TYPE
		high_water_mark: .7

	constructor: (options={}) ->
		# if running this code in a browser and you have jQuery available you can simplify the constructor logic
		# by uncommenting the line below and removing the remaining code below that line.
		#@options = $.extend({}, @defaults, options)
		@options = {}		
		@options.num_of_documents 		= options.num_of_documents 	  	 ? @constructor.DEFAULTS.num_of_documents
		@options.id_size 				= options.id_size 				 ? @constructor.DEFAULTS.id_size
		@options.value_size 			= options.value_size 			 ? @constructor.DEFAULTS.value_size
		@options.number_of_replicas	 	= options.number_of_replicas 	 ? @constructor.DEFAULTS.number_of_replicas
		@options.working_set_percentage = options.working_set_percentage ? @constructor.DEFAULTS.working_set_percentage
		@options.metadata_per_document  = options.metadata_per_document  ? @constructor.DEFAULTS.metadata_per_document
		@options.storage_type 			= options.storage_type 		  	 ? @constructor.DEFAULTS.storage_type
		@options.high_water_mark 		= options.high_water_mark 		 ? @constructor.DEFAULTS.high_water_mark		

	number_of_copies: ->
		# 1 + number_of_replicas
		1 + @options.number_of_replicas

	total_metadata: ->
		# num_of_documents * (metadata_per_document + id_size) * number_of_copies
		@options.num_of_documents * (@options.metadata_per_document + @options.id_size) * @number_of_copies()

	total_dataset: ->
		# num_of_documents * value_size * number_of_copies
		@options.num_of_documents * @options.value_size * @number_of_copies()

	working_set: ->
		# total_dataset * working_set_percentage
		@total_dataset() * @options.working_set_percentage

	cluster_ram_quota_required: ->
		# divide the ram quota by 1,000,000,000 so that we get an approx. value in Gigabytes
		# always round up by using ceiling so that we ensure we have enough ram specified
		# (total_metadata + working_set) * (1 + overhead_percentage) / (high_water_mark)
		Math.ceil(((@total_metadata() + @working_set()) * (1 + @_overhead_percentage()) / @options.high_water_mark) / 1000000000)
		
	_overhead_percentage: ->
		if (@options.storage_type.toLowerCase() == Calculator.SPINNING_STORAGE_TYPE) then .30 else .25
#END:Calculator

root = exports ? window
root.Calculator = Calculator