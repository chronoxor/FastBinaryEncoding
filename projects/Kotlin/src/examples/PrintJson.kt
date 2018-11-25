package examples

object PrintJson
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        println(test.StructSimple().toJson())
        println()

        println(test.StructOptional().toJson())
        println()

        println(test.StructNested().toJson())
        println()
    }
}
