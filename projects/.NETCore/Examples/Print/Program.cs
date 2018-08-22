using System;

namespace Print
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(test.StructSimple.Default);
            Console.WriteLine();

            Console.WriteLine(test.StructOptional.Default);
            Console.WriteLine();

            Console.WriteLine(test.StructNested.Default);
            Console.WriteLine();
        }
    }
}
