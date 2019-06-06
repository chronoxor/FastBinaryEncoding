package examples;

import java.nio.ByteBuffer;
import java.util.EnumSet;

import com.chronoxor.test.*;

public class Print
{
    public static void main(String[] args)
    {
        System.out.println(new StructSimple());
        System.out.println();

        System.out.println(new StructOptional());
        System.out.println();

        System.out.println(new StructNested());
        System.out.println();

        // Print bytes struct
        var structBytes = new StructBytes();
        structBytes.f1 = ByteBuffer.wrap("ABC".getBytes());
        structBytes.f2 = ByteBuffer.wrap("test".getBytes());
        System.out.println(structBytes);
        System.out.println();

        // Print array struct
        var structArray = new StructArray();
        structArray.f1[0] = 48;
        structArray.f1[1] = 65;
        structArray.f2[0] = 97;
        structArray.f2[1] = null;
        structArray.f3[0] = ByteBuffer.wrap("000".getBytes());
        structArray.f3[1] = ByteBuffer.wrap("AAA".getBytes());
        structArray.f4[0] = ByteBuffer.wrap("aaa".getBytes());
        structArray.f4[1] = null;
        structArray.f5[0] = EnumSimple.ENUM_VALUE_1;
        structArray.f5[1] = EnumSimple.ENUM_VALUE_2;
        structArray.f6[0] = EnumSimple.ENUM_VALUE_1;
        structArray.f6[1] = null;
        structArray.f7[0] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum()));
        structArray.f7[1] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum()));
        structArray.f8[0] = FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum()));
        structArray.f8[1] = null;
        structArray.f9[0] = new StructSimple();
        structArray.f9[1] = new StructSimple();
        structArray.f10[0] = new StructSimple();
        structArray.f10[1] = null;
        System.out.println(structArray);
        System.out.println();

        // Print vector struct
        var structVector = new StructVector();
        structVector.f1.add((byte)48);
        structVector.f1.add((byte)65);
        structVector.f2.add((byte)97);
        structVector.f2.add(null);
        structVector.f3.add(ByteBuffer.wrap("000".getBytes()));
        structVector.f3.add(ByteBuffer.wrap("AAA".getBytes()));
        structVector.f4.add(ByteBuffer.wrap("aaa".getBytes()));
        structVector.f4.add(null);
        structVector.f5.add(EnumSimple.ENUM_VALUE_1);
        structVector.f5.add(EnumSimple.ENUM_VALUE_2);
        structVector.f6.add(EnumSimple.ENUM_VALUE_1);
        structVector.f6.add(null);
        structVector.f7.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        structVector.f7.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        structVector.f8.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        structVector.f8.add(null);
        structVector.f9.add(new StructSimple());
        structVector.f9.add(new StructSimple());
        structVector.f10.add(new StructSimple());
        structVector.f10.add(null);
        System.out.println(structVector);
        System.out.println();

        // Print list struct
        var structList = new StructList();
        structList.f1.addLast((byte)48);
        structList.f1.addLast((byte)65);
        structList.f2.addLast((byte)97);
        structList.f2.addLast(null);
        structList.f3.addLast(ByteBuffer.wrap("000".getBytes()));
        structList.f3.addLast(ByteBuffer.wrap("AAA".getBytes()));
        structList.f4.addLast(ByteBuffer.wrap("aaa".getBytes()));
        structList.f4.addLast(null);
        structList.f5.addLast(EnumSimple.ENUM_VALUE_1);
        structList.f5.addLast(EnumSimple.ENUM_VALUE_2);
        structList.f6.addLast(EnumSimple.ENUM_VALUE_1);
        structList.f6.addLast(null);
        structList.f7.addLast(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        structList.f7.addLast(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        structList.f8.addLast(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        structList.f8.addLast(null);
        structList.f9.addLast(new StructSimple());
        structList.f9.addLast(new StructSimple());
        structList.f10.addLast(new StructSimple());
        structList.f10.addLast(null);
        System.out.println(structList);
        System.out.println();

        // Print set struct
        var structSet = new StructSet();
        structSet.f1.add((byte)48);
        structSet.f1.add((byte)65);
        structSet.f1.add((byte)97);
        structSet.f2.add(EnumSimple.ENUM_VALUE_1);
        structSet.f2.add(EnumSimple.ENUM_VALUE_2);
        structSet.f3.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        structSet.f3.add(FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        var s1 = new StructSimple();
        s1.id = 48;
        structSet.f4.add(s1);
        var s2 = new StructSimple();
        s2.id = 65;
        structSet.f4.add(s2);
        System.out.println(structSet);
        System.out.println();

        // Print map struct
        var structMap = new StructMap();
        structMap.f1.put(10, (byte)48);
        structMap.f1.put(20, (byte)65);
        structMap.f2.put(10, (byte)97);
        structMap.f2.put(20, null);
        structMap.f3.put(10, ByteBuffer.wrap("000".getBytes()));
        structMap.f3.put(20, ByteBuffer.wrap("AAA".getBytes()));
        structMap.f4.put(10, ByteBuffer.wrap("aaa".getBytes()));
        structMap.f4.put(20, null);
        structMap.f5.put(10, EnumSimple.ENUM_VALUE_1);
        structMap.f5.put(20, EnumSimple.ENUM_VALUE_2);
        structMap.f6.put(10, EnumSimple.ENUM_VALUE_1);
        structMap.f6.put(20, null);
        structMap.f7.put(10, FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        structMap.f7.put(20, FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        structMap.f8.put(10, FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        structMap.f8.put(20, null);
        s1.id = 48;
        structMap.f9.put(10, s1);
        s2.id = 65;
        structMap.f9.put(20, s2);
        structMap.f10.put(10, s1);
        structMap.f10.put(20, null);
        System.out.println(structMap);
        System.out.println();

        // Print hash struct
        var structHash = new StructHash();
        structHash.f1.put("10", (byte)48);
        structHash.f1.put("20", (byte)65);
        structHash.f2.put("10", (byte)97);
        structHash.f2.put("20", null);
        structHash.f3.put("10", ByteBuffer.wrap("000".getBytes()));
        structHash.f3.put("20", ByteBuffer.wrap("AAA".getBytes()));
        structHash.f4.put("10", ByteBuffer.wrap("aaa".getBytes()));
        structHash.f4.put("20", null);
        structHash.f5.put("10", EnumSimple.ENUM_VALUE_1);
        structHash.f5.put("20", EnumSimple.ENUM_VALUE_2);
        structHash.f6.put("10", EnumSimple.ENUM_VALUE_1);
        structHash.f6.put("20", null);
        structHash.f7.put("10", FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        structHash.f7.put("20", FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum(), FlagsSimple.FLAG_VALUE_3.getEnum())));
        structHash.f8.put("10", FlagsSimple.fromSet(EnumSet.of(FlagsSimple.FLAG_VALUE_1.getEnum(), FlagsSimple.FLAG_VALUE_2.getEnum())));
        structHash.f8.put("20", null);
        s1.id = 48;
        structHash.f9.put("10", s1);
        s2.id = 65;
        structHash.f9.put("20", s2);
        structHash.f10.put("10", s1);
        structHash.f10.put("20", null);
        System.out.println(structHash);
        System.out.println();

        // Print extended hash struct
        var structHashEx = new StructHashEx();
        s1.id = 48;
        structHashEx.f1.put(s1, new StructNested());
        s2.id = 65;
        structHashEx.f1.put(s2, new StructNested());
        structHashEx.f2.put(s1, new StructNested());
        structHashEx.f2.put(s2, null);
        System.out.println(structHashEx);
        System.out.println();
    }
}
