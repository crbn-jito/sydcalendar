import SwiftUI
import Foundation
import PhotosUI

struct CalendarModel: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var accentHex: String // color hex string
    var textHex: String
    var backgroundImageData: Data? // UIImage PNG/JPEG data
}

extension CalendarModel {
    var accentColor: Color { Color(hex: accentHex) }
    var textColor: Color { Color(hex: textHex) }
}
