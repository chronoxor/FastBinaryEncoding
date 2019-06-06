package examples;

import com.chronoxor.test.*;

public class PrintJson
{
    public static void main(String[] args)
    {
        System.out.println(new StructSimple().toJson());
        System.out.println();

        System.out.println(new StructOptional().toJson());
        System.out.println();

        System.out.println(new StructNested().toJson());
        System.out.println();
    }
}
