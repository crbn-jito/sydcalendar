import SwiftUI

struct ContentView: View {
    @StateObject var store = CalendarStore()
    @State private var showEditor = false
    @State private var editingModel: CalendarModel?

    var body: some View {
        NavigationView {
            Group {
                if store.calendars.isEmpty {
                    Text("No calendars — tap + to add one")
                        .foregroundColor(.secondary)
                } else {
                    TabView(selection: $store.selectedIndex) {
                        ForEach(Array(store.calendars.enumerated()), id: \.1.id) { idx, model in
                            CalendarPageView(model: model)
                                .tag(idx)
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(radius: 2)
                                .padding(.horizontal, 8)
                                .toolbar(.hidden) // keep clean
                                .overlay(
                                    HStack {
                                        Spacer()
                                        VStack {
                                            Button {
                                                editingModel = model
                                                showEditor = true
                                            } label: {
                                                Image(systemName: "pencil.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(.white)
                                                    .padding(8)
                                                    .background(model.accentColor)
                                                    .clipShape(Circle())
                                            }
                                            .padding(.top, 12)
                                            .padding(.trailing, 12)
                                            Spacer()
                                        }
                                    }
                                )
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .always))
                }
            }
            .navigationTitle(store.calendars[safe: store.selectedIndex]?.name ?? "Calendars")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let new = CalendarModel(name: "New Calendar", accentHex: "E07A5F", textHex: "000000", backgroundImageData: nil)
                        editingModel = new
                        showEditor = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
        .environmentObject(store)
        .sheet(isPresented: $showEditor, onDismiss: {
            editingModel = nil
        }) {
            if let model = editingModel {
                CalendarEditorView(model: model) { updated in
                    if store.calendars.contains(where: { $0.id == updated.id }) {
                        store.update(updated)
                    } else {
                        store.add(updated)
                        store.selectedIndex = max(0, store.calendars.count - 1)
                    }
                    showEditor = false
                } onCancel: {
                    showEditor = false
                }
            } else {
                Text("No model")
            }
        }
    }
}
