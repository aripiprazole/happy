package com.gabrielleeg1.happy.models

import java.math.BigDecimal

data class Orphanage(
    val id: Long,
    val name: String,
    val latitude: BigDecimal,
    val longitude: BigDecimal,
    val about: String,
    val instructions: String,
    val openOnWeekends: Boolean,
    val openingHours: String,
)