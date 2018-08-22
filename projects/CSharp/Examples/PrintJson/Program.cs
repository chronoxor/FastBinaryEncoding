using System;

namespace PrintJson
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(test.StructSimple.Default.ToJson());
            Console.WriteLine();

            Console.WriteLine(test.StructOptional.Default.ToJson());
            Console.WriteLine();

            Console.WriteLine(test.StructNested.Default.ToJson());
            Console.WriteLine();
        }
    }
}
