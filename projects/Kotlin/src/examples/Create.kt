package examples

import com.chronoxor.proto.*
import com.chronoxor.proto.fbe.*

object Create
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        // Create a new account using FBE model
        val account = AccountModel()
        val modelBegin = account.createBegin()
        var accountBegin = account.model.setBegin()
        account.model.id.set(1)
        account.model.name.set("Test")
        account.model.state.set(State.good)
        var walletBegin = account.model.wallet.setBegin()
        account.model.wallet.currency.set("USD")
        account.model.wallet.amount.set(1000.0)
        account.model.wallet.setEnd(walletBegin)
        account.model.setEnd(accountBegin)
        account.createEnd(modelBegin)
        assert(account.verify())

        // Show the serialized FBE size
        println("FBE size: " + account.buffer.size)

        // Access the account using the FBE model
        val access = AccountModel()
        access.attach(account.buffer)
        assert(access.verify())

        val id: Int
        val name: String
        val state: State
        val walletCurrency: String
        val walletAmount: Double

        accountBegin = access.model.getBegin()
        id = access.model.id.get()
        name = access.model.name.get()
        state = access.model.state.get()
        walletBegin = access.model.wallet.getBegin()
        walletCurrency = access.model.wallet.currency.get()
        walletAmount = access.model.wallet.amount.get()
        access.model.wallet.getEnd(walletBegin)
        access.model.getEnd(accountBegin)

        // Show account content
        println()
        println("account.id = $id")
        println("account.name = $name")
        println("account.state = $state")
        println("account.wallet.currency = $walletCurrency")
        println("account.wallet.amount = $walletAmount")
    }
}
