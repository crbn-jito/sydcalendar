import SwiftUI

struct MonthGridView: View {
    var displayMonth: Date
    var accent: Color
    var textColor: Color

    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                ForEach(0..<7) { idx in
                    Text(shortWeekdaySymbol(idx))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(daysInGrid(), id: \.self) { date in
                    DayCell(date: date,
                            inMonth: calendar.isDate(date, equalTo: displayMonth, toGranularity: .month),
                            accent: accent,
                            textColor: textColor)
                        .frame(minHeight: 40)
                }
            }
        }
    }

    func shortWeekdaySymbol(_ index: Int) -> String {
        var symbols = calendar.shortStandaloneWeekdaySymbols // Sunday..Saturday
        // align with calendar.firstWeekday if needed
        return symbols[(index + calendar.firstWeekday - 1) % 7]
    }

    func daysInGrid() -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: displayMonth),
              let firstWeekStart = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start)?.start
        else { return [] }

        // 6 rows x 7 columns
        return (0..<(6*7)).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: firstWeekStart)
        }
    }
}
