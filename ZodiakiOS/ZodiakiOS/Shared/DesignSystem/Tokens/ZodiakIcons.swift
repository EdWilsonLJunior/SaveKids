// Reason: Exhaustive enum of icon tokens — data-only, single responsibility.
import SwiftUI

// MARK: - ZodiakIconSize

/// Icon size tokens for the Zodiak Design System.
///
/// Each size maps to a predefined stroke weight — do not override the stroke.
///
/// | Case    | Dimension | Stroke |
/// |---------|-----------|--------|
/// | small   | 16pt      | 1.0pt  |
/// | medium  | 24pt      | 1.4pt  |
/// | large   | 32pt      | 1.8pt  |
/// | xLarge  | 56pt      | 2.8pt  |
///
/// ## Usage
/// ```swift
/// ZodiakIconView(.arrowRight, size: .medium)
/// ```
enum ZodiakIconSize {
    /// 16×16pt — stroke 1.0pt. Use only in space-constrained contexts.
    case small
    /// 24×24pt — stroke 1.4pt. Default size.
    case medium
    /// 32×32pt — stroke 1.8pt.
    case large
    /// 56×56pt — stroke 2.8pt.
    case xLarge

    var dimension: CGFloat {
        switch self {
        case .small:  return 16
        case .medium: return 24
        case .large:  return 32
        case .xLarge: return 56
        }
    }

    /// Predefined stroke weight per spec — do not override.
    var strokeWidth: CGFloat {
        switch self {
        case .small:  return 1.0
        case .medium: return 1.4
        case .large:  return 1.8
        case .xLarge: return 2.8
        }
    }
}

// MARK: - ZodiakIcon
// swiftlint:disable:next orphaned_doc_comment
/// Exhaustive catalog of Zodiak Design System icon tokens.
///
/// Each case maps to a named image asset in `Assets.xcassets`.
/// Asset names follow the convention `zodiak-icon-{raw-value-kebab}` —
/// e.g. `.arrowRight` → `"zodiak-icon-arrow-right"`.
///
/// ## Right-to-Left Support
///
/// Icons whose `shouldMirrorForRTL` returns `true` are automatically flipped
/// by ``Image.zodiakIcon(_:size:)`` when the layout direction is RTL.
/// Prefer that helper over constructing `Image` directly.
///
/// ## Asset Export
///
/// ⚠️ SVGs must be exported from Figma as `zodiak-icon-{name}.svg`
/// then imported via `scripts/import-visual-assets.sh`.
///
/// ```
/// Icon name "Arrow_Right" → file "zodiak-icon-arrow-right.svg"
/// Icon name "AI_Brain"    → file "zodiak-icon-ai-brain.svg"
/// ```
///
/// ## Usage
///
/// ```swift
/// Image.zodiakIcon(.arrowRight, size: .medium)
///     .foregroundStyle(Color.zodiakOnSurface)
/// ```
// swiftlint:disable:next type_body_length
enum ZodiakIcon: String, CaseIterable {
    // MARK: A
    case addPlus              = "Add_Plus"
    case addToQueue           = "Add_To_Queue"
    case ai                   = "AI"
    case aiBrain              = "AI_Brain"
    case aiContent            = "AI_Content"
    case aiEditing            = "AI_Editing"
    case aiGenerate           = "AI_Generate"
    case aiImage              = "AI_Picture"
    case aiLibrary            = "AI_Library"
    case aiMagicWand          = "AI_Magic_Wand"
    case aiSearch             = "AI_Search"
    case alarm                = "Alarm"
    case apple                = "Apple"
    case applePodcast         = "Apple-podcasts"
    case archive              = "Archive"
    case arrowDown            = "Arrow_Down"
    case arrowDownLeft        = "Arrow_Down_Left"
    case arrowDownRight       = "Arrow_Down_Right"
    case arrowDownUp          = "Arrow_Down_Up"
    case arrowLeft            = "Arrow_Left"
    case arrowLeftRight       = "Arrow_Left_Right"
    case arrowRight           = "Arrow_Right"
    case arrowUndoDownLeft    = "Arrow_Undo_Down_Left"
    case arrowUndoDownRight   = "Arrow_Undo_Down_Right"
    case arrowUndoUpLeft      = "Arrow_Undo_Up_Left"
    case arrowUndoUpRight     = "Arrow_Undo_Up_Right"
    case arrowUp              = "Arrow_Up"
    case arrowUpLeft          = "Arrow_Up_Left"
    case arrowUpRight         = "Arrow_Up_Right"
    case arrowsReload01       = "Arrows_Reload01"
    case arrowsReload02       = "Arrows_Reload02"

    // MARK: B
    case backward15           = "Backward15"
    case bell                 = "Bell"
    case bellNotification     = "Bell_Notification"
    case bellOff              = "Bell_Off"
    case bellRing             = "Bell_Ring"
    case bold                 = "Bold"
    case bookOpen             = "Book_Open"
    case bookmark             = "Bookmark"
    case bot                  = "Bot"
    case building             = "Building"
    case bulb                 = "Bulb"

    // MARK: C
    case calendarAdd          = "Calendar_Add"
    case calendarClose        = "Calendar_Close"
    case calendarDays         = "Calendar_Days"
    case calendarOk           = "Calendar_OK"
    case calendarWeek         = "Calendar_Week"
    case camera               = "Camera"
    case chartBarVertical     = "Chart_Bar_Vertical"
    case chartLine            = "Chart_Line"
    case chartPie             = "Chart_Pie"
    case chatCircle           = "Chat_Circle"
    case chatCircleAdd        = "Chat_Circle_Add"
    case chatCircleCheck      = "Chat_Circle_Check"
    case chatCircleClose      = "Chat_Circle_Close"
    case chatCircleDots       = "Chat_Circle_Dots"
    case chatCircleRemove     = "Chat_Circle_Remove"
    case chatConversationCircle = "Chat_Conversation_Circle"
    case check                = "Check"
    case checkAll             = "Check_All"
    case checkboxCheck        = "Checkbox_Check"
    case checkboxUnchecked    = "Checkbox_Unchecked"
    case chevronDown          = "Chevron_Down"
    case chevronFirstPage     = "Chevron_First_Page"
    case chevronLastPage      = "Chevron_Last_Page"
    case chevronLeft          = "Chevron_Left"
    case chevronRight         = "Chevron_Right"
    case chevronUp            = "Chevron_Up"
    case circleCheck          = "Circle_Check"
    case circleHelp           = "Circle_Help"
    case clock                = "Clock"
    case close                = "Close"
    case cloud                = "Cloud"
    case cloudAdd             = "Cloud_Add"
    case cloudCheck           = "Cloud_Check"
    case cloudClose           = "Cloud_Close"
    case cloudDownload        = "Cloud_Download"
    case cloudOff             = "Cloud_Off"
    case cloudRemove          = "Cloud_Remove"
    case cloudUpload          = "Cloud_Upload"
    case code                 = "Code"
    case coffeToGo            = "Coffe_To_Go"
    case coffee               = "Coffee"
    case command              = "Command"
    case compass              = "Compass"
    case cookie               = "Cookie"
    case copy                 = "Copy"
    case creditCard           = "Credit_Card"
    case crop                 = "Crop"
    case cupcake              = "Cupcake"

    // MARK: D
    case data                 = "Data"
    case desktopTower         = "Desktop_Tower"
    case devices              = "Devices"
    case doubleQuotes         = "Double_Quotes"
    case download             = "Download"
    case downloadPackage      = "Download_Package"

    // MARK: E
    case editPencil           = "Edit_Pencil"
    case editPencilLine       = "Edit_Pencil_Line"
    case expand               = "Expand"
    case externalLink         = "External_Link"

    // MARK: F
    case facebook             = "Facebook"
    case figma                = "Figma"
    case fileAdd              = "File_Add"
    case fileBlank            = "File_Blank"
    case fileCheck            = "File_Check"
    case fileClose            = "File_Close"
    case fileCode             = "File_Code"
    case fileDocument         = "File_Document"
    case fileDownload         = "File_Download"
    case fileEdit             = "File_Edit"
    case fileRemove           = "File_Remove"
    case fileSearch           = "File_Search"
    case fileUpload           = "File_Upload"
    case files                = "Files"
    case filter               = "Filter"
    case firstAid             = "First_Aid"
    case flag                 = "Flag"
    case folder               = "Folder"
    case folderAdd            = "Folder_Add"
    case folderCheck          = "Folder_Check"
    case folderClose          = "Folder_Close"
    case folderCode           = "Folder_Code"
    case folderDocument       = "Folder_Document"
    case folderDownload       = "Folder_Download"
    case folderEdit           = "Folder_Edit"
    case folderOpen           = "Folder_Open"
    case folderRemove         = "Folder_Remove"
    case folderSearch         = "Folder_Search"
    case folderUpload         = "Folder_Upload"
    case folders              = "Folders"
    case font                 = "Font"
    case forward              = "Forward"
    case forward15            = "Forward15"

    // MARK: G
    case gift                 = "Gift"
    case github               = "Github"
    case glassdoor            = "Glassdoor"
    case globe                = "Globe"
    case google               = "Google"
    case googlePodcasts       = "Google-podcasts"

    // MARK: H
    case hamburger            = "Hamburger"
    case headphones           = "Headphones"
    case heart                = "Heart"
    case hide                 = "Hide"
    case house                = "House"

    // MARK: I
    case image                = "Image"
    case info                 = "Info"
    case instagram            = "Instagram"
    case italic               = "Italic"

    // MARK: K
    case keyboard = "Keyboard"

    // MARK: L
    case label                = "Label"
    case laptop               = "Laptop"
    case layers               = "Layers"
    case leaf                 = "Leaf"
    case link                 = "Link"
    case linkBreak            = "Link_Break"
    case linkedin             = "Linkedin"
    case listAdd              = "List_Add"
    case listCheck            = "List_Check"
    case listChecklist        = "List_Checklist"
    case listOrdered          = "List_Ordered"
    case listRemove           = "List_Remove"
    case lock                 = "Lock"
    case lockOpen             = "Lock_Open"
    case logOut               = "Log_Out"

    // MARK: M
    case magnifyingGlassBlock = "Magnifying_Glass_Block"
    case magnifyingGlassMinus = "Magnifying_Glass_Minus"
    case magnifyingGlassPlus  = "Magnifying_Glass_Plus"
    case mail                 = "Mail"
    case mailOpen             = "Mail_Open"
    case map                  = "Map"
    case mapPin               = "Map_Pin"
    case mention              = "Mention"
    case messenger            = "Messenger"
    case mobileButton         = "Mobile_Button"
    case monitor              = "Monitor"
    case monitorPlay          = "Monitor_Play"
    case moon                 = "Moon"
    case moreGrid             = "More_Grid"
    case moreHorizontal       = "More_Horizontal"
    case moreVertical         = "More_Vertical"
    case mouse                = "Mouse"
    case move                 = "Move"

    // MARK: N
    case navigation           = "Navigation"
    case note                 = "Note"
    case noteEdit             = "Note_Edit"
    case noteSearch           = "Note_Search"
    case notebook             = "Notebook"

    // MARK: O
    case octagonWarning       = "Octagon_Warning"
    case openAIChatGPT        = "Open_AI_Chat_GPT"

    // MARK: P
    case paperPlane           = "Paper_Plane"
    case paperclipAttachment  = "Paperclip_Attachment_Tilt"
    case paragraph            = "Paragraph"
    case pause                = "Pause"
    case pauseFilled          = "Pause_Filled"
    case phone                = "Phone"
    case planet               = "Planet"
    case play                 = "Play"
    case playFilled           = "Play_Filled"
    case printer              = "Printer"
    case puzzle               = "Puzzle"

    // MARK: Q-R
    case qrCode               = "Qr_Code"
    case radioFill            = "Radio_Fill"
    case radioUnchecked       = "Radio_Unchecked"
    case rainbow              = "Rainbow"
    case redo                 = "Redo"
    case removeMinus          = "Remove_Minus"
    case rewind               = "Rewind"
    case ruler                = "Ruler"

    // MARK: S
    case save                 = "Save"
    case searchMagnifyingGlass = "Search_Magnifying_Glass"
    case selectMultiple       = "Select_Multiple"
    case settings             = "Settings"
    case share                = "Share"
    case shareAndroid         = "Share_Android"
    case shareiOSExport       = "Share_iOS_Export"
    case shoppingBag          = "Shopping_Bag"
    case shoppingCart         = "Shopping_Cart"
    case show                 = "Show"
    case shrink               = "Shrink"
    case shuffle              = "Shuffle"
    case skipBack             = "Skip_Back"
    case skipForward          = "Skip_Forward"
    case slack                = "Slack"
    case slideshare           = "Slide_Share"
    case sortAscending        = "Sort_Ascending"
    case sortDescending       = "Sort_Descending"
    case soundcloud           = "Soundcloud"
    case speed                = "Speed"
    case spotify              = "Spotify"
    case star                 = "Star"
    case stop                 = "Stop"
    case stopFilled           = "Stop_Filled"
    case strikethrough        = "Strikethrough"
    case suitcase             = "Suitcase"
    case sun                  = "Sun"
    case swatchesPalette      = "Swatches_Palette"
    case switchLeft           = "Switch_Left"
    case switchRight          = "Switch_Right"

    // MARK: T
    case table                = "Table"
    case tableAdd             = "Table_Add"
    case tableRemove          = "Table_Remove"
    case tabletButton         = "Tablet_Button"
    case tag                  = "Tag"
    case teams                = "Teams"
    case text                 = "Text"
    case textAlignCenter      = "Text_Align_Center"
    case textAlignJustify     = "Text_Align_Justify"
    case textAlignLeft        = "Text_Align_Left"
    case textAlignRight       = "Text_Align_Right"
    case threads              = "Threads"
    case ticketVoucher        = "Ticket_Voucher"
    case tiktok               = "Tiktok"
    case trashEmpty           = "Trash_Empty"
    case trashFull            = "Trash_Full"
    case trendingDown         = "Trending_Down"
    case trendingUp           = "Trending_Up"

    // MARK: U
    case underline            = "Underline"
    case undo                 = "Undo"
    case unfoldLess           = "Unfold_Less"
    case unfoldMore           = "Unfold_More"
    case user                 = "User"
    case userAdd              = "User_Add"
    case userCardID           = "User_Card_ID"
    case userCheck            = "User_Check"
    case userClose            = "User_Close"
    case userRemove           = "User_Remove"
    case userVoice            = "User_Voice"
    case users                = "Users"

    // MARK: V–Z
    case volumeMax            = "Volume_Max"
    case volumeMin            = "Volume_Min"
    case volumeOff            = "Volume_Off"
    case waterDrop            = "Water_Drop"
    case weChat               = "We_Chat"
    case weibo                = "Weibo"
    case whatsapp             = "Whatsapp"
    case wifiHigh             = "Wifi_High"
    case wifiOff              = "Wifi_Off"
    case wifiProblem          = "Wifi_Problem"
    case windows              = "Windows"
    case x                    = "X"
    case youtube              = "Youtube"

    // MARK: - Asset name
    /// e.g. "zodiak-icon-add-plus", "zodiak-icon-ai-brain"
    var imageName: String {
        "zodiak-icon-" + rawValue
            .replacingOccurrences(of: "_", with: "-")
            .replacingOccurrences(of: " ", with: "-")
            .lowercased()
    }

    // MARK: - Accessibility

    /// Human-readable label for VoiceOver, derived from the raw asset name.
    var accessibilityLabel: String {
        rawValue
            .replacingOccurrences(of: "_", with: " ")
            .replacingOccurrences(of: "-", with: " ")
    }

    // MARK: - RTL Support

    /// Returns `true` if this icon should be mirrored in right-to-left layouts.
    ///
    /// Directional icons — those whose visual meaning depends on reading direction
    /// (e.g. forward/back arrows, chevrons) — must be flipped so that "next" still
    /// points in the natural reading direction.
    ///
    /// Non-directional icons (play, stop, media controls, logos) are **not** mirrored.
    var shouldMirrorForRTL: Bool {
        switch self {
        // Arrows — horizontal direction
        case .arrowLeft, .arrowRight, .arrowLeftRight,
             .arrowUndoDownLeft, .arrowUndoDownRight,
             .arrowUndoUpLeft, .arrowUndoUpRight,
             .arrowDown, .arrowDownLeft, .arrowDownRight,
             .arrowUp, .arrowUpLeft, .arrowUpRight,
             .arrowDownUp:
            return true

        // Chevrons
        case .chevronLeft, .chevronRight,
             .chevronFirstPage, .chevronLastPage:
            return true

        // Media transport — time-direction-sensitive
        case .backward15, .rewind, .skipBack, .skipForward,
             .undo, .redo:
            return true

        // Sort / unfold — directional indicators
        case .unfoldLess, .unfoldMore:
            return true

        // Reload / sync
        case .arrowsReload01, .arrowsReload02:
            return true

        default:
            return false
        }
    }
}

// MARK: - Image rendering helper

extension Image {
    /// Creates a view from a Zodiak icon token, resized to the given ``ZodiakIconSize``.
    ///
    /// Uses the same asset-existence check as ``ZodiakIconView``: if the imageset is absent
    /// from `Assets.xcassets`, renders a red `questionmark.circle` as a deliberate signal
    /// to add the missing asset — matching the fallback behaviour of ``ZodiakIconView``.
    ///
    /// The image is automatically mirrored in RTL layouts when
    /// `ZodiakIcon.shouldMirrorForRTL` is `true` for the supplied icon.
    ///
    /// - Parameters:
    ///   - icon: The icon token to render.
    ///   - size: The desired icon size. Defaults to `.medium` (24pt).
    /// - Returns: A view scaled to `size.dimension × size.dimension`.
    static func zodiakIcon(_ icon: ZodiakIcon, size: ZodiakIconSize = .medium) -> some View {
        Group {
            if UIImage(named: icon.imageName) != nil {
                Image(icon.imageName)
                    .resizable()
                    .scaledToFit()
                    .flipsForRightToLeftLayoutDirection(icon.shouldMirrorForRTL)
            } else {
                // Red indicator: asset missing from Assets.xcassets — add the imageset to fix.
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.red)
            }
        }
        .frame(width: size.dimension, height: size.dimension)
    }
}
