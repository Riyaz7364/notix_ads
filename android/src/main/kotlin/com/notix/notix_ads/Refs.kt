package com.notix.notix_ads

import java.util.UUID

internal class Refs<T> {
    private val map = mutableMapOf<String, T>()

    operator fun get(key: String) = map[key]
    operator fun set(key: String, value: T?) {
        if (value == null) {
            map.remove(key)
        } else {
            map[key] = value
        }
    }

    fun add(value: T) = UUID.randomUUID().toString().also { map[it] = value }

    fun remove(key: String) = map.remove(key)
}