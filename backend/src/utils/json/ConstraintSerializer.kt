package com.gabrielleeg1.happy.utils.json

import kotlinx.serialization.json.buildJsonObject
import org.valiktor.Constraint

fun Constraint.asJsonObject() = buildJsonObject {
    put("name", name)
    put("parameters", buildJsonObject {
        for ((key, value) in messageParams) {
            put(key, value)
        }
    })
}