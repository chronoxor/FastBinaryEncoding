'use strict'

const prototest = require('../proto/test')

console.log(new prototest.StructSimple() + '\n')
console.log(new prototest.StructOptional() + '\n')
console.log(new prototest.StructNested() + '\n')
