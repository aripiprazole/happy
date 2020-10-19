package com.lorenzoog.happy.utils.json

import kotlinx.serialization.json.buildJsonObject
import org.valiktor.ConstraintViolation

fun ConstraintViolation.asJsonObject() = buildJsonObject {
    put("constraint", constraint.asJsonObject())
    put("property", property)
    put("value", value)
}