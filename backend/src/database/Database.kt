package com.gabrielleeg1.happy.database

import com.gabrielleeg1.happy.database.tables.OrphanageImage
import com.gabrielleeg1.happy.database.tables.Orphanages
import com.zaxxer.hikari.HikariConfig
import com.zaxxer.hikari.HikariDataSource
import io.ktor.config.*
import io.ktor.util.*
import kotlinx.coroutines.runBlocking
import org.jetbrains.exposed.sql.*
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction

object DatabaseConnector {
    private val tables = arrayOf(Orphanages, OrphanageImage)

    @OptIn(KtorExperimentalAPI::class)
    fun connect(config: ApplicationConfig): Database {
        val type = config.property("type").getString()
        val host = config.property("host").getString()
        val port = config.property("port").getString().toInt()
        val name = config.property("name").getString()
        val username = config.property("username").getString()
        val password = config.property("password").getString()

        val hikari = HikariDataSource(HikariConfig().apply {
            jdbcUrl = "jdbc:$type://$host:$port/$name"

            this.username = username
            this.password = password
        })

        return Database.connect(hikari)
    }

    fun createTables(database: Database) = runBlocking {
        newSuspendedTransaction(db = database) {
            SchemaUtils.createMissingTablesAndColumns(*tables)
        }
    }
}

