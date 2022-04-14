@file:OptIn(KtorExperimentalLocationsAPI::class)

package com.gabrielleeg1.happy.routes

import com.gabrielleeg1.happy.dtos.CreateOrphanageData
import com.gabrielleeg1.happy.dtos.asResponseDto
import com.gabrielleeg1.happy.models.Orphanage
import com.gabrielleeg1.happy.services.OrphanageImageService
import com.gabrielleeg1.happy.services.OrphanageService
import com.gabrielleeg1.happy.utils.readMany
import com.gabrielleeg1.happy.utils.readOne
import com.gabrielleeg1.happy.validators.validate
import io.ktor.application.*
import io.ktor.http.*
import io.ktor.http.content.*
import io.ktor.locations.*
import io.ktor.request.*
import io.ktor.response.*
import io.ktor.routing.*
import io.ktor.util.pipeline.*
import kotlinx.serialization.json.buildJsonObject
import kotlinx.serialization.json.put

@OptIn(KtorExperimentalLocationsAPI::class)
fun Route.orphanagesRoutes(orphanageService: OrphanageService, orphanageImageService: OrphanageImageService) {
    suspend fun PipelineContext<*, ApplicationCall>.findOrphanageImages(orphanageId: Long) = orphanageImageService
        .findOrphanageImages(orphanageId).map {
            val scheme = call.request.local.scheme
            val host = call.request.local.host
            val port = call.request.local.port
            val url = "$scheme://$host:$port"
            val path = application.locations.href(Upload(it))

            "$url$path"
        }

    get<Orphanages> {
        call.respond(orphanageService.findAllOrphanages().map {
            it.asResponseDto(findOrphanageImages(it.id))
        })
    }

    get<Orphanages.Id> { (id) ->
        call.respond(
             when (val orphanage = orphanageService.findOrphanageById(id)) {
                is Orphanage -> orphanage.asResponseDto(findOrphanageImages(id))
                else -> HttpStatusCode.NotFound
            }
        )
    }

    contentType(ContentType.Application.Json) {
        post<Orphanages> {
            val data = call.receive<CreateOrphanageData>().also(::validate)

            call.respond(HttpStatusCode.Created, orphanageService.createOrphanage(data).let {
                it.asResponseDto(findOrphanageImages(it.id))
            })
        }
    }

    contentType(ContentType.MultiPart.FormData) {
        post<Orphanages> {
            val parts = call.receiveMultipart().readAllParts()
            val orphanage = orphanageService.createOrphanage(parts.run {
                val name = readOne<PartData.FormItem>("name")?.value
                val latitude = readOne<PartData.FormItem>("latitude")?.value
                val longitude = readOne<PartData.FormItem>("longitude")?.value
                val about = readOne<PartData.FormItem>("about")?.value
                val instructions = readOne<PartData.FormItem>("instructions")?.value
                val openOnWeekends = readOne<PartData.FormItem>("open_on_weekends")?.value.toBoolean()
                val openingHours = readOne<PartData.FormItem>("opening_hours")?.value

                CreateOrphanageData(
                    name ?: return@post  call.respondMissingKey("name"),
                    latitude ?: return@post call.respondMissingKey("latitude"),
                    longitude ?: return@post  call.respondMissingKey("longitude"),
                    about ?: return@post call.respondMissingKey("about"),
                    instructions ?: return@post call.respondMissingKey("instructions"),
                    openOnWeekends,
                    openingHours ?: return@post call.respondMissingKey("opening_hours")
                ).also(::validate)
            })

            parts.readMany<PartData.FileItem>("images").forEach { item ->
                orphanageImageService.store(orphanage.id, item)
            }

            call.respond(HttpStatusCode.Created, orphanage.asResponseDto(findOrphanageImages(orphanage.id)))
        }
    }
}

suspend fun ApplicationCall.respondMissingKey(key: String) {
    return respond(HttpStatusCode.BadRequest, buildJsonObject {
        put("message", "Missing $key")
    })
}

@Location("/orphanages")
class Orphanages {
    @Location("/{id}")
    data class Id(val id: Long, val orphanages: Orphanages)
}