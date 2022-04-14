package com.gabrielleeg1.happy.utils

import io.ktor.http.content.*

inline fun <reified T : PartData> List<PartData>.readOne(name: String): T? {
    return filterIsInstance<T>().find { it.name == name }
}

inline fun <reified T : PartData> List<PartData>.readMany(name: String): List<T> {
    return filterIsInstance<T>().filter { it.name == name }
}
