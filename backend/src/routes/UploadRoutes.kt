@file:OptIn(KtorExperimentalLocationsAPI::class)
package com.lorenzoog.happy.routes

import com.lorenzoog.happy.services.OrphanageImageService
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