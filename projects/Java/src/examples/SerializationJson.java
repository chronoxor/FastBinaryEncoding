package examples;

import java.util.*;

public class SerializationJson
{
    public static void main(String[] args)
    {
        // Create a new account with some orders
        var account = new proto.Account(1, "Test", proto.State.good, new proto.Balance("USD", 1000.0), new proto.Balance("EUR", 100.0), new ArrayList<proto.Order>());
        account.orders.add(new proto.Order(1, "EURUSD", proto.OrderSide.buy, proto.OrderType.market, 1.23456, 1000.0));
        account.orders.add(new proto.Order(2, "EURUSD", proto.OrderSide.sell, proto.OrderType.limit, 1.0, 100.0));
        account.orders.add(new proto.Order(3, "EURUSD", proto.OrderSide.buy, proto.OrderType.stop, 1.5, 10.0));

        // Serialize the account to the JSON string
        var json = account.toJson();

        // Show the serialized JSON and its size
        System.out.println("JSON: " + json);
        System.out.println("JSON size: " + json.length());

        // Deserialize the account from the JSON string
        account = proto.Account.fromJson(json);

        // Show account content
        System.out.println();
        System.out.println(account);
    }
}
