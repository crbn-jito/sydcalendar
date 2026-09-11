import SwiftUI
import Combine

final class CalendarStore: ObservableObject {
    @Published var calendars: [CalendarModel] = []
    @Published var selectedIndex: Int = 0

    private let userDefaultsKey = "minprompt.calendars.v1"

    init() {
        load()
        if calendars.isEmpty {
            // seed example calendars
            calendars = [
                CalendarModel(name: "Work", accentHex: "2D9CDB", textHex: "FFFFFF", backgroundImageData: nil),
                CalendarModel(name: "Personal", accentHex: "6FCF97", textHex: "000000", backgroundImageData: nil)
            ]
        }
    }

    func add(_ cal: CalendarModel) {
        calendars.append(cal)
        persist()
    }
    func update(_ cal: CalendarModel) {
        if let idx = calendars.firstIndex(where: { $0.id == cal.id }) {
            calendars[idx] = cal
            persist()
        }
    }
    func remove(at offsets: IndexSet) {
        calendars.remove(atOffsets: offsets)
        persist()
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(calendars) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }

    private func load() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([CalendarModel].self, from: data) {
            calendars = decoded
        }
    }
}
