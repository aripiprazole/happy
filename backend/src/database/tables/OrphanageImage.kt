package com.lorenzoog.happy.database.tables

import org.jetbrains.exposed.sql.ReferenceOption
import org.jetbrains.exposed.sql.Table

object OrphanageImage : Table("orphanage_image") {
    val path = varchar("path", 100)
    val orphanageId = reference(
        name = "orphanage_id",
        refColumn = Orphanages.id,
        onDelete = ReferenceOption.CASCADE,
        onUpdate = ReferenceOption.CASCADE
    )
}