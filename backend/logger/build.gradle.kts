val logbackVersion: String by project
val jansiVersion: String by project

plugins {
    kotlin("jvm")
}

group = "com.gabrielleeg1"
version = "1.0.0"

repositories {
    mavenCentral()
}

dependencies {
    implementation(kotlin("stdlib"))

    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.3.9")
    implementation("ch.qos.logback:logback-classic:$logbackVersion")
    implementation("org.fusesource.jansi:jansi:$jansiVersion")
}

kotlin.sourceSets["main"].kotlin.srcDirs("src")
kotlin.sourceSets["test"].kotlin.srcDirs("test")

sourceSets["main"].resources.srcDirs("resources")
sourceSets["test"].resources.srcDirs("testresources")
