'use strict'

const prototest = require('../proto/test')

console.log(JSON.stringify(new prototest.StructSimple()) + '\n')
console.log(JSON.stringify(new prototest.StructOptional()) + '\n')
console.log(JSON.stringify(new prototest.StructNested()) + '\n')
