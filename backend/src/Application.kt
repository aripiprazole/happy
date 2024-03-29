@file:OptIn(KtorExperimentalLocationsAPI::class)

package com.gabrielleeg1.happy

import com.gabrielleeg1.happy.database.DatabaseConnector
import com.gabrielleeg1.happy.routes.orphanagesRoutes
import com.gabrielleeg1.happy.routes.uploadRoutes
import com.gabrielleeg1.happy.services.*
import com.gabrielleeg1.happy.utils.json.asJsonObject
import io.ktor.application.*
import io.ktor.features.*
import io.ktor.http.*
import io.ktor.locations.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.serialization.*
import io.ktor.util.*
import java.io.File
import kotlinx.serialization.SerializationException
import kotlinx.serialization.json.Json
import org.slf4j.event.Level
import org.valiktor.ConstraintViolationException

fun main(args: Array<String>): Unit = io.ktor.server.jetty.EngineMain.main(args)

@OptIn(KtorExperimentalAPI::class)
@Suppress("unused") // Referenced in application.conf
fun Application.module() {
    val database = DatabaseConnector.connect(environment.config.config("database")).also {
        DatabaseConnector.createTables(it)
    }

    val orphanageService: OrphanageService = DefaultOrphanageService(database)
    val orphanageImageService: OrphanageImageService = environment.config
        .config("storage").property("orphanage_image_storage").getString()
        .let { path -> StorageOrphanageImageService(File(path).apply { mkdirs() }) }
        .let { delegate -> DatabaseOrphanageImageService(database, delegate) }

    install(Locations)

    install(CallLogging) {
        level = Level.INFO

        filter { call -> call.request.path().startsWith("/") }
    }

    install(CORS) {
        method(HttpMethod.Options)
        method(HttpMethod.Put)
        method(HttpMethod.Delete)
        method(HttpMethod.Patch)
        header(HttpHeaders.Authorization)
        header(HttpHeaders.ContentType)
        allowCredentials = true
        anyHost()
    }

    install(ContentNegotiation) {
        json(Json {
            ignoreUnknownKeys = true
        })
    }

    routing {
        orphanagesRoutes(orphanageService, orphanageImageService)
        uploadRoutes(orphanageImageService)

        install(StatusPages) {
            exception<ConstraintViolationException> { cause ->
                call.respond(HttpStatusCode.UnprocessableEntity, cause.asJsonObject())
            }

            exception<SerializationException> { cause ->
                call.respond(HttpStatusCode.BadRequest, cause.asJsonObject())
            }
        }
    }
}
