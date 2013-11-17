couchbase-sizing-calculator
===========================

This is a simple coffeescript calculator class for determining the amount of RAM that is required to create a [Couchbase](http://www.couchbase.com) cluster.
  
It also includes a basic class method to determine the number of nodes required to fulfill the amount of RAM that is required for the Couchbase cluster.

I've included Nodeunit tests to ensure that the calculator methods work as expected. The tests can be found in the *test* directory and can be run using `npm test` from your console when you are in the top level directory for the project.

The main calculator class is found in the *src* directory.

**Usage**
  
The calculator was designed to be run from a console and within a webpage. To run from the console make sure you are in the top level directory for the project.

Within the console type `coffee execute.coffee`. You should see the results in your console.
If you want to modify the results you can pass in the proper arguments to the Calculator class like so:

<pre>
calculator = new Calculator(
  number_of_replicas: 2 
  num_of_documents: 10000000  
  id_size: 60 
  value_size: 2000 
  working_set_percentage: .5 
  storage_type: Calculator.SPINNING_STORAGE_TYPE 
)
</pre>

You can add different values and other options as well to fit your needs. A list of all the options can be found in the constructor method within the *src/calculator.coffee* file.

When using the script within a webpage you can update the constructor to have it use the jQuery extend method if you so choose. There are notes within the calculator constructor but I'll lay out what you need to do here as well. 

<pre>
constructor: (options={}) ->
	@options = $.extend({}, @constructor.DEFAULTS, options)
</pre>

Don't forget to make sure you have included jQuery on you webpage that you are running the calculator from otherwise this will not work.

**Additional Info**

Here is a link to the [Couchbase calculations](http://docs.couchbase.com/couchbase-manual-2.2/#sizing-guidelines)

Here is a link to the [jQuery extend method documentation](http://api.jquery.com/jQuery.extend/)

This was my first attempt at utilizing coffeescript so I welcome your feedback and pull requests to help make this calculator better.
