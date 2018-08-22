package examples;

public class PrintJson
{
    public static void main(String[] args)
    {
        System.out.println(new test.StructSimple().toJson());
        System.out.println();

        System.out.println(new test.StructOptional().toJson());
        System.out.println();

        System.out.println(new test.StructNested().toJson());
        System.out.println();
    }
}
