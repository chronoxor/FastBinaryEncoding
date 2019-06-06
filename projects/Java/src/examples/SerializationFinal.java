package examples;

import java.util.*;

import com.chronoxor.proto.*;
import com.chronoxor.proto.fbe.*;

public class SerializationFinal
{
    public static void main(String[] args)
    {
        // Create a new account with some orders
        var account = new Account(1, "Test", State.good, new Balance("USD", 1000.0), new Balance("EUR", 100.0), new ArrayList<Order>());
        account.orders.add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0));
        account.orders.add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0));
        account.orders.add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0));

        // Serialize the account to the FBE stream
        var writer = new AccountFinalModel();
        writer.serialize(account);
        assert writer.verify();

        // Show the serialized FBE size
        System.out.println("FBE final size: " + writer.getBuffer().getSize());

        // Deserialize the account from the FBE stream
        var reader = new AccountFinalModel();
        reader.attach(writer.getBuffer());
        assert reader.verify();
        reader.deserialize(account);

        // Show account content
        System.out.println();
        System.out.println(account);
    }
}
