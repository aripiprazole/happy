package com.lorenzoog.happy.services

import com.lorenzoog.happy.database.tables.Orphanages
import com.lorenzoog.happy.dtos.CreateOrphanageData
import com.lorenzoog.happy.models.Orphanage
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction

interface OrphanageService {
    suspend fun findAllOrphanages(): Collection<Orphanage>
    suspend fun findOrphanageById(id: Long): Orphanage?
    suspend fun createOrphanage(data: CreateOrphanageData): Orphanage
}

class DefaultOrphanageService(private val database: Database) : OrphanageService {
    override suspend fun findAllOrphanages() = newSuspendedTransaction(db = database) {
        Orphanages.selectAll().map(ResultRow::asOrphanage)
    }

    override suspend fun findOrphanageById(id: Long) = newSuspendedTransaction(db = database) {
        Orphanages.select { Orphanages.id eq id }.firstOrNull()?.asOrphanage()
    }

    override suspend fun createOrphanage(data: CreateOrphanageData) = newSuspendedTransaction(db = database) {
        val result = Orphanages.insert { query ->
            query[name] = data.name
            query[latitude] = data.latitude.toBigDecimal()
            query[longitude] = data.longitude.toBigDecimal()
            query[about] = data.about
            query[instructions] = data.instructions
            query[openOnWeekends] = data.openOnWeekends
            query[openingHours] = data.openingHours
        }

        Orphanage(
            result[Orphanages.id].value,
            result[Orphanages.name],
            result[Orphanages.latitude],
            result[Orphanages.longitude],
            result[Orphanages.about],
            result[Orphanages.instructions],
            result[Orphanages.openOnWeekends],
            result[Orphanages.openingHours],
        ).also { println("CARALHINHO")}
    }
}

private fun ResultRow.asOrphanage() = Orphanage(
    this[Orphanages.id].value,
    this[Orphanages.name],
    this[Orphanages.latitude],
    this[Orphanages.longitude],
    this[Orphanages.about],
    this[Orphanages.instructions],
    this[Orphanages.openOnWeekends],
    this[Orphanages.openingHours],
)
