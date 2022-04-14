package com.gabrielleeg1.happy.utils.json

import kotlinx.serialization.SerializationException
import kotlinx.serialization.json.buildJsonObject

fun SerializationException.asJsonObject() = buildJsonObject {
    put("message", message)
}