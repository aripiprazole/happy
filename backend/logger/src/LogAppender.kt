package com.lorenzoog.happy.logger

import ch.qos.logback.classic.spi.ILoggingEvent
import ch.qos.logback.core.OutputStreamAppender
import org.fusesource.jansi.AnsiConsole
import java.io.PrintStream
import java.time.format.DateTimeFormatter

/**
 * https://github.com/nekkan/kodya/blob/development/core/src/main/kotlin/kodya/core/utils/io/logger/LoggingAppender.kt
 */
@Suppress("unused")
class LogAppender : OutputStreamAppender<ILoggingEvent>() {
  init {
    encoder = LogEncoder(DateTimeFormatter.ofPattern("HH:mm:ss.SSS"))
  }

  override fun start() {
    outputStream = runCatching {
      AnsiConsole.wrapSystemOut(PrintStream(outputStream))
    }.getOrElse { System.out }

    super.start()
  }
}
