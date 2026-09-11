import SwiftUI

struct CalendarPageView: View {
    var model: CalendarModel
    @State private var displayDate = Date()

    var body: some View {
        ZStack {
            if let data = model.backgroundImageData, let ui = UIImage(data: data) {
                Image(uiImage: ui)
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .opacity(0.18)
                    .ignoresSafeArea()
            }
            VStack(spacing: 12) {
                header
                MonthGridView(displayMonth: displayDate, accent: model.accentColor, textColor: model.textColor)
                Spacer()
            }
            .padding()
        }
        .background(Color(.systemBackground).opacity(0.6))
        .cornerRadius(12)
    }

    var header: some View {
        HStack {
            Button(action: { displayDate = Calendar.current.date(byAdding: .month, value: -1, to: displayDate) ?? displayDate }) {
                Image(systemName: "chevron.left")
                    .padding(8)
                    .background(model.accentColor.opacity(0.2))
                    .clipShape(Circle())
            }
            Spacer()
            Text(monthTitle(for: displayDate))
                .font(.system(.title2, weight: .semibold))
                .foregroundColor(model.textColor)
            Spacer()
            Button(action: { displayDate = Calendar.current.date(byAdding: .month, value: 1, to: displayDate) ?? displayDate }) {
                Image(systemName: "chevron.right")
                    .padding(8)
                    .background(model.accentColor.opacity(0.2))
                    .clipShape(Circle())
            }
        }
    }

    func monthTitle(for d: Date) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "LLLL yyyy"
        return fmt.string(from: d)
    }
}
