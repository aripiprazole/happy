package com.lorenzoog.happy.dtos

import com.lorenzoog.happy.models.Orphanage
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class CreateOrphanageData(
    val name: String,
    val latitude: String,
    val longitude: String,
    val about: String,
    val instructions: String,
    @SerialName("open_on_weekends") val openOnWeekends: Boolean = false,
    @SerialName("opening_hours") val openingHours: String,
)

@Serializable
data class OrphanageResponse(
    val id: Long,
    val name: String,
    val latitude: String,
    val longitude: String,
    val about: String,
    val instructions: String,
    @SerialName("open_on_weekends") val openOnWeekends: Boolean = false,
    @SerialName("opening_hours") val openingHours: String,

    val images: List<String>
)

fun Orphanage.asResponseDto(images: List<String>) = OrphanageResponse(
    id,
    name,
    latitude.toString(),
    longitude.toString(),
    about,
    instructions,
    openOnWeekends,
    openingHours,
    images
)
