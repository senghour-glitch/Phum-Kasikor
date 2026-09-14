plugins {
    id("com.google.gms.google-services") version "4.5.0" apply false
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory =
        newBuildDir.dir(project.name)

    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

/*
 * Make all Android modules use Java 21.
 * This is needed for plugins such as flutter_facebook_auth.
 *
 * This MUST be registered before evaluationDependsOn below - forcing
 * early evaluation of :app there means this afterEvaluate hook would
 * otherwise be registered on an already-evaluated project and crash.
 */
subprojects {
    afterEvaluate {
        extensions.findByName("android")?.let { androidExtension ->
            try {
                val compileOptions =
                    androidExtension.javaClass
                        .getMethod("getCompileOptions")
                        .invoke(androidExtension)

                compileOptions.javaClass
                    .getMethod(
                        "setSourceCompatibility",
                        JavaVersion::class.java
                    )
                    .invoke(
                        compileOptions,
                        JavaVersion.VERSION_17
                    )

                compileOptions.javaClass
                    .getMethod(
                        "setTargetCompatibility",
                        JavaVersion::class.java
                    )
                    .invoke(
                        compileOptions,
                        JavaVersion.VERSION_17
                    )
            } catch (_: Exception) {
                // Ignore modules that do not expose Android compile options.
            }
        }
    }
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
