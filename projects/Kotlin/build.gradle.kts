plugins {
    kotlin("jvm") version "2.4.21"
}

group = "FastBinaryEncoding"
version = "1.0"

repositories {
    mavenCentral()
}

dependencies {
    implementation("com.google.code.gson:gson:2.15.0")
    implementation("org.openjdk.jmh:jmh-core:1.37")

    testImplementation("org.testng:testng:7.12.0")
    testImplementation("org.jetbrains.kotlin:kotlin-test-testng:2.4.21")
    testRuntimeOnly("org.slf4j:slf4j-nop:2.0.20")
}

// Builds with the JDK Gradle runs on (IDEA project JDK), emitting JVM 26 bytecode (newest target Kotlin 2.4 supports)
java {
    sourceCompatibility = JavaVersion.VERSION_26
    targetCompatibility = JavaVersion.VERSION_26
}

kotlin {
    compilerOptions {
        jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_26)
    }
}

// Library sources, examples and benchmarks are main sources; tests are a separate source set
sourceSets {
    main {
        kotlin.setSrcDirs(listOf("src/com", "src/examples", "src/benchmarks"))
    }
    test {
        kotlin.setSrcDirs(listOf("src/tests"))
    }
}

tasks.test {
    useTestNG()
    testLogging {
        events("passed", "failed", "skipped")
        showStandardStreams = false
    }
}

// Run an example with: gradlew runExample -PexampleClass=examples.Serialization
tasks.register<JavaExec>("runExample") {
    group = "application"
    description = "Runs an example main class given by -PexampleClass=<fully.qualified.Class>"
    classpath = sourceSets.main.get().runtimeClasspath
    mainClass.set(providers.gradleProperty("exampleClass").orElse("examples.Serialization"))
}
