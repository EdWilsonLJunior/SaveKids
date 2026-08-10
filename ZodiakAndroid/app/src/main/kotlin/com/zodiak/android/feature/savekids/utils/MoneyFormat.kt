package com.zodiak.android.feature.savekids.utils

import java.text.NumberFormat
import java.util.Locale

private val brCurrencyFormatter = NumberFormat.getCurrencyInstance(Locale("pt", "BR"))

fun Double.toMoneyLabel(): String = brCurrencyFormatter.format(this)
