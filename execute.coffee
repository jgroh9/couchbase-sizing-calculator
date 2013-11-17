{Calculator} = require './src/Calculator'

calc = new Calculator
console.log "Number of Copies - #{calc.number_of_copies()}"
console.log "Total Metadata - #{calc.total_metadata()}"
console.log "Total Dataset - #{calc.total_dataset()}"
console.log "Working Set - #{calc.working_set()}"
console.log "Cluster Ram Quota Required - #{calc.cluster_ram_quota_required()}"