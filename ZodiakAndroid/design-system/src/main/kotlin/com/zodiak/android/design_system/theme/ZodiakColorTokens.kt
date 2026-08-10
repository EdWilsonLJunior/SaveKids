package com.zodiak.android.design_system.theme

import androidx.compose.ui.graphics.Color

// ─── Zodiak Primitive Color Tokens ───────────────────────────────────────────
// ⚠️ Internal reference only. Do NOT use directly in components.
//    Always consume semantic tokens via ZodiakTheme.colors.
// Source: Zodiak Design System – Capgemini (doc-zodiak.capgemini.com)
// Mirrors: iOS ZodiakPrimitives.swift

object ZodiakColorTokens {

    // MARK: CapgeminiBlue Ramp
    object Blue {
        val shade25   = Color(0xFFFCFCFC)
        val shade50   = Color(0xFFEFF0F4)
        val shade100  = Color(0xFFDFE1EB)
        val shade200  = Color(0xFF8EA6D5)
        val shade300  = Color(0xFF5685C6)
        val shade400  = Color(0xFF3573C0)
        /** Brand Blue — Capgemini primary #0058ab */
        val shade500  = Color(0xFF0058AB)
        val shade600  = Color(0xFF264F96)
        val shade700  = Color(0xFF1C4076)
        /** Dark Blue — Capgemini secondary #1d365a */
        val shade800  = Color(0xFF1D365A)
        val shade900  = Color(0xFF121A38)
        val shade950  = Color(0xFF070A16)
        val shade1000 = Color(0xFF010204)
        /** CapgeminiBlue at 6% opacity — rgba(0, 88, 171, 0.06) — hover/focus tint */
        val brand6    = shade500.copy(alpha = 0.06f)
    }

    // MARK: Teal Ramp
    object Teal {
        val shade600 = Color(0xFF00D5D0)
        val shade900 = Color(0xFF29656F)
    }

    // MARK: Neutral Ramp
    object Neutral {
        val shade50   = Color(0xFFF8FAFC)
        val shade100  = Color(0xFFF4F6F9)
        val shade150  = Color(0xFFF1F4F7)
        val shade200  = Color(0xFFE9EDF3)
        val shade250  = Color(0xFFE6E9ED)
        val shade300  = Color(0xFFD9DDE3)
        val shade350  = Color(0xFFC7CCD3)
        val shade400  = Color(0xFFA6ACB5)
        val shade450  = Color(0xFF888F9A)
        val shade500  = Color(0xFF6E7480)
        val shade550  = Color(0xFF595E6A)
        val shade600  = Color(0xFF474C56)
        val shade650  = Color(0xFF3C414A)
        val shade700  = Color(0xFF343840)
        val shade750  = Color(0xFF2E323A)
        val shade800  = Color(0xFF272B33)
        val shade850  = Color(0xFF21252D)
        val shade900  = Color(0xFF1B1F27)
        val shade950  = Color(0xFF171A22)
        val shade1000 = Color(0xFF12151D)
    }

    // MARK: Green Ramp
    object Green {
        val shade50   = Color(0xFFEFF7F5)
        val shade100  = Color(0xFFE7F6EB)
        val shade200  = Color(0xFFCDEDD5)
        val shade300  = Color(0xFFAFE3BD)
        val shade400  = Color(0xFF8AD9A2)
        val shade500  = Color(0xFF57CF80)
        val shade600  = Color(0xFF4EB972)
        /** Status Online / textPositive — vivid medium green #21b87d */
        val shade650  = Color(0xFF21B87D)
        val shade700  = Color(0xFF43A063)
        /** Banner success dark green — #0f664a */
        val shade750  = Color(0xFF0F664A)
        val shade800  = Color(0xFF1E5631)
        val shade900  = Color(0xFF0F2E22)
    }

    // MARK: Red Ramp
    object Red {
        val shade50  = Color(0xFFFBF2F3)
        val shade100 = Color(0xFFFFCACA)
        val shade200 = Color(0xFFFFA7A9)
        val shade300 = Color(0xFFFF848B)
        val shade400 = Color(0xFFFF6270)
        val shade500 = Color(0xFFF64059)
        val shade600 = Color(0xFFDD1D46)
        val shade700 = Color(0xFFC00036)
        val shade800 = Color(0xFF9E0029)
        val shade900 = Color(0xFF5D051A)
    }

    // MARK: Yellow Ramp
    object Yellow {
        val shade50   = Color(0xFFFFFCF5)
        /** Warning surface tint — rgba(255,237,209,1) */
        val shade75   = Color(0xFFFFEDD1)
        val shade100  = Color(0xFFFFF8EB)
        val shade200  = Color(0xFFFFF1D5)
        val shade300  = Color(0xFFFFEABD)
        val shade400  = Color(0xFFFFE2A2)
        val shade500  = Color(0xFFFFDA80)
        val shade600  = Color(0xFFE4C372)
        val shade700  = Color(0xFFC6A963)
        /** Status Away amber */
        val shade750  = Color(0xFFFAB833)
        val shade800  = Color(0xFFA18A51)
        val shade900  = Color(0xFF726139)
        /** Rating star active — #f2b81a */
        val ratingGold = Color(0xFFF2B81A)
    }

    // MARK: Orange Ramp
    object Orange {
        val shade50  = Color(0xFFFFFCFA)
        val shade100 = Color(0xFFFFE5D3)
        val shade200 = Color(0xFFFECFAD)
        val shade300 = Color(0xFFFCB988)
        /** Brand Orange #f9a464 */
        val shade400 = Color(0xFFF9A464)
        val shade500 = Color(0xFFF68F40)
        val shade600 = Color(0xFFF17817)
        /** Warning action orange — #f2991a */
        val shade625 = Color(0xFFF2991A)
        val shade700 = Color(0xFFCC640F)
        val shade800 = Color(0xFF9F500D)
        /** Banner warning dark amber — #9e6100 */
        val shade810 = Color(0xFF9E6100)
        val shade900 = Color(0xFF743C0B)
    }

    // MARK: B/W Overlay Primitives
    object Overlay {
        val blackTransparent = Color.Black.copy(alpha = 0f)
        val black5  = Color.Black.copy(alpha = 0.05f)
        val black6  = Color.Black.copy(alpha = 0.06f)
        val black8  = Color.Black.copy(alpha = 0.08f)
        val black10 = Color.Black.copy(alpha = 0.10f)
        val black15 = Color.Black.copy(alpha = 0.15f)
        val black40 = Color.Black.copy(alpha = 0.40f)
        val black55 = Color.Black.copy(alpha = 0.55f)
        val black75 = Color.Black.copy(alpha = 0.75f)
        val black   = Color.Black
        val whiteTransparent = Color.White.copy(alpha = 0f)
        val white5  = Color.White.copy(alpha = 0.05f)
        val white50 = Color.White.copy(alpha = 0.50f)
        val white   = Color.White
    }
}
