package examples

object Create
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        // Create a new account using FBE model
        val account = proto.fbe.AccountModel()
        val modelBegin = account.createBegin()
        var accountBegin = account.model.setBegin()
        account.model.uid.set(1)
        account.model.name.set("Test")
        account.model.state.set(proto.State.good)
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
        val access = proto.fbe.AccountModel()
        access.attach(account.buffer)
        assert(access.verify())

        val uid: Int
        val name: String
        val state: proto.State
        val walletCurrency: String
        val walletAmount: Double

        accountBegin = access.model.getBegin()
        uid = access.model.uid.get()
        name = access.model.name.get()
        state = access.model.state.get()
        walletBegin = access.model.wallet.getBegin()
        walletCurrency = access.model.wallet.currency.get()
        walletAmount = access.model.wallet.amount.get()
        access.model.wallet.getEnd(walletBegin)
        access.model.getEnd(accountBegin)

        // Show account content
        println()
        println("account.uid = $uid")
        println("account.name = $name")
        println("account.state = $state")
        println("account.wallet.currency = $walletCurrency")
        println("account.wallet.amount = $walletAmount")
    }
}
