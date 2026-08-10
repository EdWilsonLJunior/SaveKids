package com.zodiak.android.feature.savekids.data.local.room

import androidx.room.TypeConverter
import com.zodiak.android.feature.savekids.model.HistoryEventType
import com.zodiak.android.feature.savekids.model.MissionStatus

class SaveKidsTypeConverters {

    @TypeConverter
    fun fromMissionStatus(value: MissionStatus): String = value.name

    @TypeConverter
    fun toMissionStatus(value: String): MissionStatus = MissionStatus.valueOf(value)

    @TypeConverter
    fun fromHistoryEventType(value: HistoryEventType): String = value.name

    @TypeConverter
    fun toHistoryEventType(value: String): HistoryEventType = HistoryEventType.valueOf(value)
}
