using System;
using System.IO;

using com.chronoxor.test;

namespace Print
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine(StructSimple.Default);
            Console.WriteLine();

            Console.WriteLine(StructOptional.Default);
            Console.WriteLine();

            Console.WriteLine(StructNested.Default);
            Console.WriteLine();

            // Print bytes struct
            var structBytes = StructBytes.Default;
            structBytes.f1 = new MemoryStream(new [] { (byte)'A', (byte)'B', (byte)'C' }, 0, 3, true, true);
            structBytes.f2 = new MemoryStream(new[] { (byte)'t', (byte)'e', (byte)'s', (byte)'t' }, 0, 4, true, true);
            Console.WriteLine(structBytes);
            Console.WriteLine();

            // Print array struct
            var structArray = StructArray.Default;
            structArray.f1[0] = 48;
            structArray.f1[1] = 65;
            structArray.f2[0] = 97;
            structArray.f2[1] = null;
            structArray.f3[0] = new MemoryStream(new[] { (byte)48, (byte)48, (byte)48 }, 0, 3, true, true);
            structArray.f3[1] = new MemoryStream(new[] { (byte)65, (byte)65, (byte)65 }, 0, 3, true, true);
            structArray.f4[0] = new MemoryStream(new[] { (byte)97, (byte)97, (byte)97 }, 0, 3, true, true);
            structArray.f4[1] = null;
            structArray.f5[0] = EnumSimple.ENUM_VALUE_1;
            structArray.f5[1] = EnumSimple.ENUM_VALUE_2;
            structArray.f6[0] = EnumSimple.ENUM_VALUE_1;
            structArray.f6[1] = null;
            structArray.f7[0] = FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2;
            structArray.f7[1] = FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3;
            structArray.f8[0] = FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2;
            structArray.f8[1] = null;
            structArray.f9[0] = StructSimple.Default;
            structArray.f9[1] = StructSimple.Default;
            structArray.f10[0] = StructSimple.Default;
            structArray.f10[1] = null;
            Console.WriteLine(structArray);
            Console.WriteLine();

            // Print vector struct
            var structVector = StructVector.Default;
            structVector.f1.Add(48);
            structVector.f1.Add(65);
            structVector.f2.Add(97);
            structVector.f2.Add(null);
            structVector.f3.Add(new MemoryStream(new[] { (byte)48, (byte)48, (byte)48 }, 0, 3, true, true));
            structVector.f3.Add(new MemoryStream(new[] { (byte)65, (byte)65, (byte)65 }, 0, 3, true, true));
            structVector.f4.Add(new MemoryStream(new[] { (byte)97, (byte)97, (byte)97 }, 0, 3, true, true));
            structVector.f4.Add(null);
            structVector.f5.Add(EnumSimple.ENUM_VALUE_1);
            structVector.f5.Add(EnumSimple.ENUM_VALUE_2);
            structVector.f6.Add(EnumSimple.ENUM_VALUE_1);
            structVector.f6.Add(null);
            structVector.f7.Add(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            structVector.f7.Add(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3);
            structVector.f8.Add(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            structVector.f8.Add(null);
            structVector.f9.Add(StructSimple.Default);
            structVector.f9.Add(StructSimple.Default);
            structVector.f10.Add(StructSimple.Default);
            structVector.f10.Add(null);
            Console.WriteLine(structVector);
            Console.WriteLine();

            // Print list struct
            var structList = StructList.Default;
            structList.f1.AddLast(48);
            structList.f1.AddLast(65);
            structList.f2.AddLast(97);
            structList.f2.AddLast((byte?)null);
            structList.f3.AddLast(new MemoryStream(new[] { (byte)48, (byte)48, (byte)48 }, 0, 3, true, true));
            structList.f3.AddLast(new MemoryStream(new[] { (byte)65, (byte)65, (byte)65 }, 0, 3, true, true));
            structList.f4.AddLast(new MemoryStream(new[] { (byte)97, (byte)97, (byte)97 }, 0, 3, true, true));
            structList.f4.AddLast((MemoryStream)null);
            structList.f5.AddLast(EnumSimple.ENUM_VALUE_1);
            structList.f5.AddLast(EnumSimple.ENUM_VALUE_2);
            structList.f6.AddLast(EnumSimple.ENUM_VALUE_1);
            structList.f6.AddLast((EnumSimple?)null);
            structList.f7.AddLast(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            structList.f7.AddLast(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3);
            structList.f8.AddLast(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            structList.f8.AddLast((FlagsSimple?)null);
            structList.f9.AddLast(StructSimple.Default);
            structList.f9.AddLast(StructSimple.Default);
            structList.f10.AddLast(StructSimple.Default);
            structList.f10.AddLast((StructSimple?)null);
            Console.WriteLine(structList);
            Console.WriteLine();

            // Print set struct
            var structSet = StructSet.Default;
            structSet.f1.Add(48);
            structSet.f1.Add(65);
            structSet.f1.Add(97);
            structSet.f2.Add(EnumSimple.ENUM_VALUE_1);
            structSet.f2.Add(EnumSimple.ENUM_VALUE_2);
            structSet.f3.Add(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            structSet.f3.Add(FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3);
            var s1 = StructSimple.Default;
            s1.id = 48;
            structSet.f4.Add(s1);
            var s2 = StructSimple.Default;
            s2.id = 65;
            structSet.f4.Add(s2);
            Console.WriteLine(structSet);
            Console.WriteLine();

            // Print map struct
            var structMap = StructMap.Default;
            structMap.f1.Add(10, 48);
            structMap.f1.Add(20, 65);
            structMap.f2.Add(10, 97);
            structMap.f2.Add(20, null);
            structMap.f3.Add(10, new MemoryStream(new[] { (byte)48, (byte)48, (byte)48 }, 0, 3, true, true));
            structMap.f3.Add(20, new MemoryStream(new[] { (byte)65, (byte)65, (byte)65 }, 0, 3, true, true));
            structMap.f4.Add(10, new MemoryStream(new[] { (byte)97, (byte)97, (byte)97 }, 0, 3, true, true));
            structMap.f4.Add(20, null);
            structMap.f5.Add(10, EnumSimple.ENUM_VALUE_1);
            structMap.f5.Add(20, EnumSimple.ENUM_VALUE_2);
            structMap.f6.Add(10, EnumSimple.ENUM_VALUE_1);
            structMap.f6.Add(20, null);
            structMap.f7.Add(10, FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            structMap.f7.Add(20, FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3);
            structMap.f8.Add(10, FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            structMap.f8.Add(20, null);
            s1.id = 48;
            structMap.f9.Add(10, s1);
            s2.id = 65;
            structMap.f9.Add(20, s2);
            structMap.f10.Add(10, s1);
            structMap.f10.Add(20, null);
            Console.WriteLine(structMap);
            Console.WriteLine();

            // Print hash struct
            var structHash = StructHash.Default;
            structHash.f1.Add("10", 48);
            structHash.f1.Add("20", 65);
            structHash.f2.Add("10", 97);
            structHash.f2.Add("20", null);
            structHash.f3.Add("10", new MemoryStream(new[] { (byte)48, (byte)48, (byte)48 }, 0, 3, true, true));
            structHash.f3.Add("20", new MemoryStream(new[] { (byte)65, (byte)65, (byte)65 }, 0, 3, true, true));
            structHash.f4.Add("10", new MemoryStream(new[] { (byte)97, (byte)97, (byte)97 }, 0, 3, true, true));
            structHash.f4.Add("20", null);
            structHash.f5.Add("10", EnumSimple.ENUM_VALUE_1);
            structHash.f5.Add("20", EnumSimple.ENUM_VALUE_2);
            structHash.f6.Add("10", EnumSimple.ENUM_VALUE_1);
            structHash.f6.Add("20", null);
            structHash.f7.Add("10", FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            structHash.f7.Add("20", FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2 | FlagsSimple.FLAG_VALUE_3);
            structHash.f8.Add("10", FlagsSimple.FLAG_VALUE_1 | FlagsSimple.FLAG_VALUE_2);
            structHash.f8.Add("20", null);
            s1.id = 48;
            structHash.f9.Add("10", s1);
            s2.id = 65;
            structHash.f9.Add("20", s2);
            structHash.f10.Add("10", s1);
            structHash.f10.Add("20", null);
            Console.WriteLine(structHash);
            Console.WriteLine();

            // Print extended hash struct
            var structHashEx = StructHashEx.Default;
            s1.id = 48;
            structHashEx.f1.Add(s1, StructNested.Default);
            s2.id = 65;
            structHashEx.f1.Add(s2, StructNested.Default);
            structHashEx.f2.Add(s1, StructNested.Default);
            structHashEx.f2.Add(s2, null);
            Console.WriteLine(structHashEx);
            Console.WriteLine();
        }
    }
}
