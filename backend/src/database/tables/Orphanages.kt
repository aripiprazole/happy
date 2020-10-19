package com.lorenzoog.happy.database.tables

import org.jetbrains.exposed.dao.id.LongIdTable

object Orphanages : LongIdTable("orphanages") {
    val name = varchar("name", 30)
    val latitude = decimal("latitude", 11,7)
    val longitude = decimal("longitude", 11,7)
    val about = varchar("about", 300)
    val instructions = varchar("instructions", 300)
    val openOnWeekends = bool("open_on_weekends").default(false)
    val openingHours = varchar("opening_hours", 30)
}