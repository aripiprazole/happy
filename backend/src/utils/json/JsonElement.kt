package com.lorenzoog.happy.utils.json

import kotlinx.serialization.json.JsonElement
import kotlinx.serialization.json.JsonObjectBuilder
import kotlinx.serialization.json.put

fun JsonObjectBuilder.put(key: String, value: Any?) = when (value) {
    is Number? -> put(key, value)
    is String? -> put(key, value)
    is Boolean? -> put(key, value)
    is JsonElement -> put(key, value)
    null -> null
    else -> put(key, value.toString())
}