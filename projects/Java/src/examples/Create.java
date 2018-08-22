package examples;

public class Create
{
    public static void main(String[] args)
    {
        // Create a new account using FBE model
        var account = new proto.fbe.AccountModel();
        long model_begin = account.createBegin();
        long account_begin = account.model.setBegin();
        account.model.uid.set(1);
        account.model.name.set("Test");
        account.model.state.set(proto.State.good);
        long wallet_begin = account.model.wallet.setBegin();
        account.model.wallet.currency.set("USD");
        account.model.wallet.amount.set(1000.0);
        account.model.wallet.setEnd(wallet_begin);
        account.model.setEnd(account_begin);
        account.createEnd(model_begin);
        assert account.verify();

        // Show the serialized FBE size
        System.out.println("FBE size: " + account.getBuffer().getSize());

        // Access the account using the FBE model
        var access = new proto.fbe.AccountModel();
        access.attach(account.getBuffer());
        assert access.verify();

        int uid;
        String name;
        proto.State state;
        String wallet_currency;
        double wallet_amount;

        account_begin = access.model.getBegin();
        uid = access.model.uid.get();
        name = access.model.name.get();
        state = access.model.state.get();
        wallet_begin = access.model.wallet.getBegin();
        wallet_currency = access.model.wallet.currency.get();
        wallet_amount = access.model.wallet.amount.get();
        access.model.wallet.getEnd(wallet_begin);
        access.model.getEnd(account_begin);

        // Show account content
        System.out.println();
        System.out.println("account.uid = " + uid);
        System.out.println("account.name = " + name);
        System.out.println("account.state = " + state);
        System.out.println("account.wallet.currency = " + wallet_currency);
        System.out.println("account.wallet.amount = " + wallet_amount);
    }
}
