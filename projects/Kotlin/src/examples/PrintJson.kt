package examples

object PrintJson
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        System.out.println(test.StructSimple().toJson())
        println()

        System.out.println(test.StructOptional().toJson())
        println()

        System.out.println(test.StructNested().toJson())
        println()
    }
}
