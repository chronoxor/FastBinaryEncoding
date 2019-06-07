package examples

import com.chronoxor.test.*

object PrintJson
{
    @JvmStatic
    fun main(args: Array<String>)
    {
        println(StructSimple().toJson())
        println()

        println(StructOptional().toJson())
        println()

        println(StructNested().toJson())
        println()
    }
}
