/* eslint-disable prefer-const,no-loss-of-precision */
'use strict'

const fbe = require('../proto/fbe')
const proto = require('../proto/proto')

// Create a new account using FBE model
let account = new proto.AccountModel(new fbe.WriteBuffer())
let modelBegin = account.createBegin()
let accountBegin = account.model.setBegin()
account.model.id.set(1)
account.model.name.set('Test')
account.model.state.set(proto.State.good)
let walletBegin = account.model.wallet.setBegin()
account.model.wallet.currency.set('USD')
account.model.wallet.amount.set(1000.0)
account.model.wallet.setEnd(walletBegin)
account.model.setEnd(accountBegin)
account.createEnd(modelBegin)
console.assert(account.verify())

// Show the serialized FBE size
console.log(`FBE size: ${account.buffer.size}`)

// Access the account using the FBE model
let access = new proto.AccountModel(new fbe.ReadBuffer())
access.attachBuffer(account.buffer)
console.assert(access.verify())

accountBegin = access.model.getBegin()
let id = access.model.id.get()
let name = access.model.name.get()
let state = access.model.state.get()
walletBegin = access.model.wallet.getBegin()
let walletCurrency = access.model.wallet.currency.get()
let walletAmount = access.model.wallet.amount.get()
access.model.wallet.getEnd(walletBegin)
access.model.getEnd(accountBegin)

// Show account content
console.log()
console.log(`account.id = ${id}`)
console.log(`account.name = ${name}`)
console.log(`account.state = ${state}`)
console.log(`account.wallet.currency = ${walletCurrency}`)
console.log(`account.wallet.amount = ${walletAmount}`)
