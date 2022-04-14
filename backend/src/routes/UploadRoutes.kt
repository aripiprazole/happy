@file:OptIn(KtorExperimentalLocationsAPI::class)
package com.gabrielleeg1.happy.routes

import com.gabrielleeg1.happy.services.OrphanageImageService
import io.ktor.application.*
import io.ktor.locations.*
import io.ktor.response.*
import io.ktor.routing.*

@OptIn(KtorExperimentalLocationsAPI::class)
fun Route.uploadRoutes(orphanageImageService: OrphanageImageService) {
    get<Upload> { (path) ->
        call.respondFile(orphanageImageService.retrieve(path))
    }
}

@Location("/upload/{path}")
data class Upload(val path: String)