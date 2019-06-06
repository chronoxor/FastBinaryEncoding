package examples;

import java.util.*;

import com.chronoxor.proto.*;

public class SerializationJson
{
    public static void main(String[] args)
    {
        // Create a new account with some orders
        var account = new Account(1, "Test", State.good, new Balance("USD", 1000.0), new Balance("EUR", 100.0), new ArrayList<Order>());
        account.orders.add(new Order(1, "EURUSD", OrderSide.buy, OrderType.market, 1.23456, 1000.0));
        account.orders.add(new Order(2, "EURUSD", OrderSide.sell, OrderType.limit, 1.0, 100.0));
        account.orders.add(new Order(3, "EURUSD", OrderSide.buy, OrderType.stop, 1.5, 10.0));

        // Serialize the account to the JSON string
        var json = account.toJson();

        // Show the serialized JSON and its size
        System.out.println("JSON: " + json);
        System.out.println("JSON size: " + json.length());

        // Deserialize the account from the JSON string
        account = Account.fromJson(json);

        // Show account content
        System.out.println();
        System.out.println(account);
    }
}
