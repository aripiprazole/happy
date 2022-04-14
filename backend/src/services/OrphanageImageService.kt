package com.gabrielleeg1.happy.services

import com.gabrielleeg1.happy.database.tables.OrphanageImage
import com.gabrielleeg1.happy.database.tables.Orphanages
import io.ktor.http.content.*
import kotlinx.coroutines.*
import org.jetbrains.exposed.dao.DaoEntityID
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.insert
import org.jetbrains.exposed.sql.select
import org.jetbrains.exposed.sql.transactions.experimental.newSuspendedTransaction
import java.io.File
import java.io.InputStream
import java.io.OutputStream
import kotlin.random.Random

interface OrphanageImageService {
    suspend fun store(orphanageId: Long, file: PartData.FileItem): String
    suspend fun findOrphanageImages(orphanageId: Long): List<String>
    suspend fun retrieve(path: String): File
}

class DatabaseOrphanageImageService(
    private val database: Database,
    private val storage: StorageOrphanageImageService
) : OrphanageImageService {
    override suspend fun store(orphanageId: Long, file: PartData.FileItem) = newSuspendedTransaction(db = database) {
        val path = storage.store(orphanageId, file)

        OrphanageImage.insert {
            it[this.orphanageId] = DaoEntityID(orphanageId, Orphanages)
            it[this.path] = path
        } get OrphanageImage.path
    }

    override suspend fun findOrphanageImages(orphanageId: Long) = newSuspendedTransaction(db = database) {
        OrphanageImage.select { OrphanageImage.orphanageId eq orphanageId }.map { result ->
            result[OrphanageImage.path]
        }
    }

    override suspend fun retrieve(path: String) = storage.retrieve(path)
}

class StorageOrphanageImageService(
    private val uploadDir: File,
    private val random: Random = Random
) {
    suspend fun store(orphanageId: Long, file: PartData.FileItem): String {
        val ext = File(file.originalFileName.toString()).extension
        val path = "upload-${System.currentTimeMillis()}-${orphanageId}-${random.nextLong()}-.$ext"
        val outputFile = File(uploadDir, path)

        file.streamProvider().use { input ->
            outputFile.outputStream().buffered().use { output ->
                input.copyToSuspend(output)
            }
        }

        return path
    }

    fun retrieve(path: String): File {
        return File(uploadDir, path)
    }
}

/** https://ktor.io/docs/uploads.html#receiving-files-using-multipart */
@Suppress("BlockingMethodInNonBlockingContext")
suspend fun InputStream.copyToSuspend(
    out: OutputStream,
    bufferSize: Int = DEFAULT_BUFFER_SIZE,
    yieldSize: Int = 4 * 1024 * 1024,
    dispatcher: CoroutineDispatcher = Dispatchers.IO
) = withContext(dispatcher) {
    val buffer = ByteArray(bufferSize)
    var bytesCopied = 0L
    var bytesAfterYield = 0L

    while (true) {
        val bytes = read(buffer).takeIf { it >= 0 } ?: break
        out.write(buffer, 0, bytes)

        if (bytesAfterYield > yieldSize) {
            yield()

            bytesAfterYield %= yieldSize
        }

        bytesCopied += bytes
        bytesAfterYield += bytes
    }

    bytesCopied
}