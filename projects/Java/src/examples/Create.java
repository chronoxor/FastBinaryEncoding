package examples;

import com.chronoxor.proto.*;
import com.chronoxor.proto.fbe.*;

public class Create
{
    public static void main(String[] args)
    {
        // Create a new account using FBE model
        var account = new AccountModel();
        long modelBegin = account.createBegin();
        long accountBegin = account.model.setBegin();
        account.model.id.set(1);
        account.model.name.set("Test");
        account.model.state.set(State.good);
        long walletBegin = account.model.wallet.setBegin();
        account.model.wallet.currency.set("USD");
        account.model.wallet.amount.set(1000.0);
        account.model.wallet.setEnd(walletBegin);
        account.model.setEnd(accountBegin);
        account.createEnd(modelBegin);
        assert account.verify();

        // Show the serialized FBE size
        System.out.println("FBE size: " + account.getBuffer().getSize());

        // Access the account using the FBE model
        var access = new AccountModel();
        access.attach(account.getBuffer());
        assert access.verify();

        int id;
        String name;
        State state;
        String walletCurrency;
        double walletAmount;

        accountBegin = access.model.getBegin();
        id = access.model.id.get();
        name = access.model.name.get();
        state = access.model.state.get();
        walletBegin = access.model.wallet.getBegin();
        walletCurrency = access.model.wallet.currency.get();
        walletAmount = access.model.wallet.amount.get();
        access.model.wallet.getEnd(walletBegin);
        access.model.getEnd(accountBegin);

        // Show account content
        System.out.println();
        System.out.println("account.id = " + id);
        System.out.println("account.name = " + name);
        System.out.println("account.state = " + state);
        System.out.println("account.wallet.currency = " + walletCurrency);
        System.out.println("account.wallet.amount = " + walletAmount);
    }
}
