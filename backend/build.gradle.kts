import org.jetbrains.kotlin.gradle.tasks.KotlinCompile

val ktorVersion: String by project
val kotlinVersion: String by project
val logbackVersion: String by project
val exposedVersion: String by project
val kotestVersion: String by project
val mockkVersion: String by project
val h2Version: String by project
val postgresqlVersion: String by project
val valiktorVersion: String by project
val hikariVersion: String by project
val arrowVersion: String by project
val jetbrainsAnnotationsVersion: String by project

plugins {
    application
    kotlin("jvm") version "1.4.10"
    kotlin("kapt") version "1.4.10"
    kotlin("plugin.serialization") version "1.4.10"

    id("com.github.johnrengelman.shadow") version "6.1.0"
}

group = "com.gabrielleeg1"
version = "1.0.0"

application {
    mainClassName = "com.gabrielleeg1.happy.ApplicationKt"
}

repositories {
    mavenCentral()
    mavenLocal()
    jcenter()

    maven("https://kotlin.bintray.com/ktor")
    maven("https://oss.sonatype.org/content/repositories/snapshots/")
}

dependencies {
    // kotlin dependencies
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8:$kotlinVersion")

    // ktor dependencies
    implementation("io.ktor:ktor-server-jetty:$ktorVersion")
    implementation("io.ktor:ktor-serialization:$ktorVersion")
    implementation("io.ktor:ktor-server-core:$ktorVersion")
    implementation("io.ktor:ktor-locations:$ktorVersion")
    implementation("io.ktor:ktor-websockets:$ktorVersion")
    implementation("io.ktor:ktor-server-host-common:$ktorVersion")
    implementation("io.ktor:ktor-auth:$ktorVersion")

    // logging dependencies
    implementation("ch.qos.logback:logback-classic:$logbackVersion")
    implementation(project(":logger"))

    // validation dependencies
    implementation("org.valiktor:valiktor-core:$valiktorVersion")

    // database dependencies
    implementation("org.jetbrains.exposed:exposed-core:$exposedVersion")
    implementation("org.jetbrains.exposed:exposed-jodatime:$exposedVersion")
    implementation("org.jetbrains.exposed:exposed-dao:$exposedVersion")
    implementation("org.jetbrains.exposed:exposed-jdbc:$exposedVersion")
    implementation("com.zaxxer:HikariCP:$hikariVersion")
    runtimeOnly("org.postgresql:postgresql:$postgresqlVersion")

    // test dependencies
    testRuntimeOnly("com.h2database:h2:$h2Version")
    testImplementation("io.mockk:mockk:$mockkVersion")
    testImplementation("io.ktor:ktor-server-tests:$ktorVersion")

    // other dependencies
    implementation("org.jetbrains:annotations:$jetbrainsAnnotationsVersion")

    // kotest dependencies
    testImplementation("io.kotest:kotest-runner-junit5-jvm:$kotestVersion")
    testImplementation("io.kotest:kotest-assertions-core-jvm:$kotestVersion")
    testImplementation("io.kotest:kotest-property-jvm:$kotestVersion")
}

tasks.withType<Test> {
    useJUnitPlatform()
}

tasks.withType<KotlinCompile> {
    kotlinOptions.freeCompilerArgs += listOf("-Xopt-in=kotlin.RequiresOptIn")
    kotlinOptions.languageVersion = "1.4"
    kotlinOptions.jvmTarget = "1.8"
}

kotlin.sourceSets["main"].kotlin.srcDirs("src")
kotlin.sourceSets["test"].kotlin.srcDirs("test")

sourceSets["main"].resources.srcDirs("resources")
sourceSets["test"].resources.srcDirs("testresources")
