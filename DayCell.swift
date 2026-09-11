import SwiftUI

struct DayCell: View {
    var date: Date
    var inMonth: Bool
    var accent: Color
    var textColor: Color

    private let calendar = Calendar.current

    var body: some View {
        VStack {
            Text("\(calendar.component(.day, from: date))")
                .font(.system(.body, design: .rounded))
                .fontWeight(inMonth ? .regular : .light)
                .foregroundColor(inMonth ? textColor : .secondary)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(6)
                .background(isToday(date) ? accent.opacity(0.9).cornerRadius(8) : Color.clear)
        }
    }

    func isToday(_ d: Date) -> Bool {
        calendar.isDateInToday(d)
    }
}
