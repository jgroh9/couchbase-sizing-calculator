{Calculator} = require './src/Calculator'

ram_per_node = 12

calc = new Calculator
console.log "Number of Copies - #{calc.number_of_copies()}"
console.log "Total Metadata - #{calc.total_metadata()}"
console.log "Total Dataset - #{calc.total_dataset()}"
console.log "Working Set - #{calc.working_set()}"

ram_required = calc.cluster_ram_quota_required()
console.log "Cluster Ram Quota Required - #{ram_required}"
console.log "Number of Nodes Required - #{Calculator.number_of_nodes_needed(ram_required, ram_per_node)}"