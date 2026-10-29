using System;

using com.chronoxor.test;

namespace PrintJson
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(StructSimple.Default.ToJson());
            Console.WriteLine();

            Console.WriteLine(StructOptional.Default.ToJson());
            Console.WriteLine();

            Console.WriteLine(StructNested.Default.ToJson());
            Console.WriteLine();
        }
    }
}
