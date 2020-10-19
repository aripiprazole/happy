package com.lorenzoog.happy.validators

import com.lorenzoog.happy.dtos.CreateOrphanageData
import org.valiktor.functions.hasSize
import org.valiktor.functions.isNotBlank
import org.valiktor.functions.isNotEmpty

fun validate(data: CreateOrphanageData) = org.valiktor.validate(data) {
    validate(CreateOrphanageData::name)
        .hasSize(max = 30)
        .isNotBlank()
        .isNotEmpty()

    validate(CreateOrphanageData::openingHours)
        .hasSize(max = 30)
        .isNotBlank()
        .isNotEmpty()

    validate(CreateOrphanageData::about)
        .hasSize(max = 300)
        .isNotBlank()
        .isNotEmpty()

    validate(CreateOrphanageData::instructions)
        .hasSize(max = 300)
        .isNotBlank()
        .isNotEmpty()
}