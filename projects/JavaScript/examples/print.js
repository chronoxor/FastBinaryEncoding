/* eslint-disable prefer-const,no-loss-of-precision */
'use strict'

const prototest = require('../proto/test')

console.log(new prototest.StructSimple() + '\n')
console.log(new prototest.StructOptional() + '\n')
console.log(new prototest.StructNested() + '\n')

// Print bytes struct
let structBytes = new prototest.StructBytes()
// noinspection JSUnresolvedFunction
structBytes.f1 = Uint8Array.from('ABC', x => x.charCodeAt(0))
// noinspection JSUnresolvedFunction
structBytes.f2 = Uint8Array.from('test', x => x.charCodeAt(0))
console.log(structBytes + '\n')

// Print array struct
let structArray = new prototest.StructArray()
structArray.f1[0] = 48
structArray.f1[1] = 65
structArray.f2[0] = 97
structArray.f2[1] = undefined
structArray.f3[0] = Array.from('000', x => x.charCodeAt(0))
structArray.f3[1] = Array.from('AAA', x => x.charCodeAt(0))
structArray.f4[0] = Array.from('aaa', x => x.charCodeAt(0))
structArray.f4[1] = undefined
structArray.f5[0] = prototest.EnumSimple.ENUM_VALUE_1
structArray.f5[1] = prototest.EnumSimple.ENUM_VALUE_2
structArray.f6[0] = prototest.EnumSimple.ENUM_VALUE_1
structArray.f6[1] = undefined
structArray.f7[0] = prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2)
structArray.f7[1] = prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2 | prototest.FlagsSimple.FLAG_VALUE_3)
structArray.f8[0] = prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2)
structArray.f8[1] = undefined
structArray.f9[0] = new prototest.StructSimple()
structArray.f9[1] = new prototest.StructSimple()
structArray.f10[0] = new prototest.StructSimple()
structArray.f10[1] = undefined
console.log(structArray + '\n')

// Print vector struct
let structVector = new prototest.StructVector()
structVector.f1[0] = 48
structVector.f1[1] = 65
structVector.f2[0] = 97
structVector.f2[1] = undefined
structVector.f3[0] = Array.from('000', x => x.charCodeAt(0))
structVector.f3[1] = Array.from('AAA', x => x.charCodeAt(0))
structVector.f4[0] = Array.from('aaa', x => x.charCodeAt(0))
structVector.f4[1] = undefined
structVector.f5[0] = prototest.EnumSimple.ENUM_VALUE_1
structVector.f5[1] = prototest.EnumSimple.ENUM_VALUE_2
structVector.f6[0] = prototest.EnumSimple.ENUM_VALUE_1
structVector.f6[1] = undefined
structVector.f7[0] = prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2)
structVector.f7[1] = prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2 | prototest.FlagsSimple.FLAG_VALUE_3)
structVector.f8[0] = prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2)
structVector.f8[1] = undefined
structVector.f9[0] = new prototest.StructSimple()
structVector.f9[1] = new prototest.StructSimple()
structVector.f10[0] = new prototest.StructSimple()
structVector.f10[1] = undefined
console.log(structVector + '\n')

// Print list struct
let structList = new prototest.StructList()
structList.f1[0] = 48
structList.f1[1] = 65
structList.f2[0] = 97
structList.f2[1] = undefined
structList.f3[0] = Array.from('000', x => x.charCodeAt(0))
structList.f3[1] = Array.from('AAA', x => x.charCodeAt(0))
structList.f4[0] = Array.from('aaa', x => x.charCodeAt(0))
structList.f4[1] = undefined
structList.f5[0] = prototest.EnumSimple.ENUM_VALUE_1
structList.f5[1] = prototest.EnumSimple.ENUM_VALUE_2
structList.f6[0] = prototest.EnumSimple.ENUM_VALUE_1
structList.f6[1] = undefined
structList.f7[0] = prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2)
structList.f7[1] = prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2 | prototest.FlagsSimple.FLAG_VALUE_3)
structList.f8[0] = prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2)
structList.f8[1] = undefined
structList.f9[0] = new prototest.StructSimple()
structList.f9[1] = new prototest.StructSimple()
structList.f10[0] = new prototest.StructSimple()
structList.f10[1] = undefined
console.log(structList + '\n')

// Print set struct
let structSet = new prototest.StructSet()
structSet.f1.add(48)
structSet.f1.add(65)
structSet.f1.add(97)
structSet.f2.add(prototest.EnumSimple.ENUM_VALUE_1)
structSet.f2.add(prototest.EnumSimple.ENUM_VALUE_2)
structSet.f3.add(prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2))
structSet.f3.add(prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2 | prototest.FlagsSimple.FLAG_VALUE_3))
let s1 = new prototest.StructSimple()
s1.id = 48
structSet.f4.add(s1)
let s2 = new prototest.StructSimple()
s2.id = 65
structSet.f4.add(s2)
console.log(structSet + '\n')

// Print map struct
let structMap = new prototest.StructMap()
structMap.f1.set(10, 48)
structMap.f1.set(20, 65)
structMap.f2.set(10, 97)
structMap.f2.set(20, undefined)
structMap.f3.set(10, Array.from('000', x => x.charCodeAt(0)))
structMap.f3.set(20, Array.from('AAA', x => x.charCodeAt(0)))
structMap.f4.set(10, Array.from('aaa', x => x.charCodeAt(0)))
structMap.f4.set(20, undefined)
structMap.f5.set(10, prototest.EnumSimple.ENUM_VALUE_1)
structMap.f5.set(20, prototest.EnumSimple.ENUM_VALUE_2)
structMap.f6.set(10, prototest.EnumSimple.ENUM_VALUE_1)
structMap.f6.set(20, undefined)
structMap.f7.set(10, prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2))
structMap.f7.set(20, prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2 | prototest.FlagsSimple.FLAG_VALUE_3))
structMap.f8.set(10, prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2))
structMap.f8.set(20, undefined)
s1.id = 48
structMap.f9.set(10, s1)
s2.id = 65
structMap.f9.set(20, s2)
structMap.f10.set(10, s1)
structMap.f10.set(20, undefined)
console.log(structMap + '\n')

// Print hash struct
let structHash = new prototest.StructHash()
structHash.f1.set('10', 48)
structHash.f1.set('20', 65)
structHash.f2.set('10', 97)
structHash.f2.set('20', undefined)
structHash.f3.set('10', Array.from('000', x => x.charCodeAt(0)))
structHash.f3.set('20', Array.from('AAA', x => x.charCodeAt(0)))
structHash.f4.set('10', Array.from('aaa', x => x.charCodeAt(0)))
structHash.f4.set('20', undefined)
structHash.f5.set('10', prototest.EnumSimple.ENUM_VALUE_1)
structHash.f5.set('20', prototest.EnumSimple.ENUM_VALUE_2)
structHash.f6.set('10', prototest.EnumSimple.ENUM_VALUE_1)
structHash.f6.set('20', undefined)
structHash.f7.set('10', prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2))
structHash.f7.set('20', prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2 | prototest.FlagsSimple.FLAG_VALUE_3))
structHash.f8.set('10', prototest.FlagsSimple.fromFlags(prototest.FlagsSimple.FLAG_VALUE_1 | prototest.FlagsSimple.FLAG_VALUE_2))
structHash.f8.set('20', undefined)
s1.id = 48
structHash.f9.set('10', s1)
s2.id = 65
structHash.f9.set('20', s2)
structHash.f10.set('10', s1)
structHash.f10.set('20', undefined)
console.log(structHash + '\n')

// Print extended hash struct
let structHashEx = new prototest.StructHashEx()
s1.id = 48
structHashEx.f1.set(s1, new prototest.StructNested())
s2.id = 65
structHashEx.f1.set(s2, new prototest.StructNested())
structHashEx.f2.set(s1, new prototest.StructNested())
structHashEx.f2.set(s2, undefined)
console.log(structHashEx + '\n')
