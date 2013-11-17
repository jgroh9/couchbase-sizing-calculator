{Calculator} = require './src/Calculator'

ramPerNode = 12

calc = new Calculator
console.log "Number of Copies - #{calc.numberOfCopies()}"
console.log "Total Metadata - #{calc.totalMetadata()}"
console.log "Total Dataset - #{calc.totalDataset()}"
console.log "Working Set - #{calc.workingSet()}"

ramRequired = calc.clusterRamQuotaRequired()
console.log "Cluster Ram Quota Required - #{ramRequired}"
console.log "Number of Nodes Required - #{Calculator.numberOfNodesNeeded(ramRequired, ramPerNode)}"