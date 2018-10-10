package examples

object Print
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        println(test.StructSimple())
        println()

        println(test.StructOptional())
        println()

        println(test.StructNested())
        println()
    }
}
