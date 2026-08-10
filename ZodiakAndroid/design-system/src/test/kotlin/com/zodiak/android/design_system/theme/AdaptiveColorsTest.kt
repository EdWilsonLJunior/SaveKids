package com.zodiak.android.design_system.theme

import kotlin.test.Test
import kotlin.test.assertEquals
import kotlin.test.assertNotEquals

class AdaptiveColorsTest {
    @Test
    fun verifyColors() {
        val light = ZodiakSemanticColors.light()
        val dark = ZodiakSemanticColors.dark()
        
        // Let's assert directly without reflection
        assertNotEquals(light.brand, dark.brand, "brand should be adaptive")
        assertEquals(light.brandOrange, dark.brandOrange, "brandOrange should be fixed")
        assertNotEquals(light.background, dark.background, "background should be adaptive")
        assertNotEquals(light.surface, dark.surface, "surface should be adaptive")
        assertEquals(light.surfaceAlwaysWhite, dark.surfaceAlwaysWhite, "surfaceAlwaysWhite should be fixed")
        assertEquals(light.surfaceAlwaysBlack, dark.surfaceAlwaysBlack, "surfaceAlwaysBlack should be fixed")
        assertEquals(light.surfaceDecorativeBrand, dark.surfaceDecorativeBrand, "surfaceDecorativeBrand should be fixed")
        assertEquals(light.surfaceDecorativeOrange, dark.surfaceDecorativeOrange, "surfaceDecorativeOrange should be fixed")
        assertEquals(light.textAlwaysWhite, dark.textAlwaysWhite, "textAlwaysWhite should be fixed")
        assertEquals(light.textAlwaysBlack, dark.textAlwaysBlack, "textAlwaysBlack should be fixed")
        assertEquals(light.statusInfoFixo, dark.statusInfoFixo, "statusInfoFixo should be fixed")
        assertEquals(light.statusFixo, dark.statusFixo, "statusFixo should be fixed")
    }
}
