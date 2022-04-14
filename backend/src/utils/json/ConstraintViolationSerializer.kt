package com.gabrielleeg1.happy.utils.json

import kotlinx.serialization.json.buildJsonObject
import org.valiktor.ConstraintViolation

fun ConstraintViolation.asJsonObject() = buildJsonObject {
    put("constraint", constraint.asJsonObject())
    put("property", property)
    put("value", value)
}