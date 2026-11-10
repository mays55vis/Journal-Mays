import SwiftUI

extension Color {
    init(hex: UInt32) {
        let red   = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8)  & 0xFF) / 255
        let blue  = Double(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue)
    }
}

extension Color {
    static let primaryAccent = Color(hex: 0x7F81FF)
    static let textAccent    = Color(hex: 0xAF99FD)
    static let textPrimary   = Color(hex: 0xFFFFFF)
    static let textSecondary = Color(hex: 0xA39A9A)
    static let surfaceCard   = Color(hex: 0x1C1C1E)
    static let destructive   = Color(hex: 0xFD453C)
}

extension Font {
    static let display        = Font.system(size: 42, weight: .black)
    static let headingL       = Font.system(size: 34, weight: .bold)
    static let headingM       = Font.system(size: 24, weight: .bold)
    static let titleCard      = Font.system(size: 24, weight: .semibold)
    static let bodyL          = Font.system(size: 20, weight: .regular)
    static let bodyM          = Font.system(size: 18, weight: .regular)
    static let bodySupporting = Font.system(size: 18, weight: .light)
    static let captionM       = Font.system(size: 16, weight: .regular)
    static let captionS       = Font.system(size: 14, weight: .regular)
}
