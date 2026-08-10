import OSLog

// MARK: - Log Category

/// Logging categories for the Zodiak iOS app.
/// Each value maps to a dedicated `Logger` instance surfaced in Console.app
/// and Instruments under subsystem `com.capgemini.zodiakios`.
enum ZodiakLogCategory: String {
    case lifecycle
    case navigation
    case viewModel
    case network
    case service
    case error
    case audit

    /// Returns the `Logger` instance for this category.
    var logger: Logger {
        Logger(subsystem: ZodiakLogger.subsystem, category: rawValue)
    }
}

// MARK: - Logger Namespace

/// Central access point for native `Logger` instances.
///
/// Use `ZodiakLog` for all standard logging — it writes to OSLog and dispatches
/// to `ZodiakLogBus`. Use `ZodiakLogger.*` directly only when attaching
/// privacy-sensitive fields via `privacy: .private(mask: .hash)`.
enum ZodiakLogger {
    static let subsystem = "com.capgemini.zodiakios"

    static let lifecycle  = ZodiakLogCategory.lifecycle.logger
    static let navigation = ZodiakLogCategory.navigation.logger
    static let viewModel  = ZodiakLogCategory.viewModel.logger
    static let network    = ZodiakLogCategory.network.logger
    static let service    = ZodiakLogCategory.service.logger
    static let error      = ZodiakLogCategory.error.logger
    static let audit      = ZodiakLogCategory.audit.logger
}
