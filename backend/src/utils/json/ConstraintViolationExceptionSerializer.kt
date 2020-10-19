package com.lorenzoog.happy.utils.json

import kotlinx.serialization.json.buildJsonArray
import kotlinx.serialization.json.buildJsonObject
import org.valiktor.ConstraintViolationException

fun ConstraintViolationException.asJsonObject() = buildJsonObject {
    put("message", "Could not process the entity. Check the violations")
    put("violations", buildJsonArray {
        for (violation in constraintViolations) {
            add(violation.asJsonObject())
        }
    })
}