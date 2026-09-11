import SwiftUI
import PhotosUI

struct CalendarEditorView: View {
    @State var model: CalendarModel
    var onSave: (CalendarModel) -> Void
    var onCancel: () -> Void

    @State private var uiImage: UIImage? = nil
    @State private var showingPicker = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Calendar name", text: $model.name)
                }
                Section(header: Text("Colors")) {
                    ColorPicker("Accent color", selection: Binding(get: {
                        model.accentColor
                    }, set: { newColor in
                        model.accentHex = newColor.toHexString()
                    }))
                    ColorPicker("Text color", selection: Binding(get: {
                        model.textColor
                    }, set: { newColor in
                        model.textHex = newColor.toHexString()
                    }))
                }
                Section(header: Text("Background")) {
                    if let img = uiImage {
                        Image(uiImage: img)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(8)
                    } else {
                        Rectangle()
                            .foregroundColor(.secondary.opacity(0.1))
                            .frame(height: 150)
                            .overlay(Text("No photo selected").foregroundColor(.secondary))
                            .cornerRadius(8)
                    }
                    HStack {
                        Button("Choose Photo") {
                            showingPicker = true
                        }
                        Spacer()
                        Button("Clear") {
                            uiImage = nil
                            model.backgroundImageData = nil
                        }
                    }
                }
                Section {
                    Button("Save") {
                        if let img = uiImage {
                            model.backgroundImageData = img.jpegData(compressionQuality: 0.7)
                        }
                        onSave(model)
                    }
                    Button("Cancel", role: .cancel) {
                        onCancel()
                    }
                }
            }
            .navigationTitle("Edit Calendar")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        if let img = uiImage {
                            model.backgroundImageData = img.jpegData(compressionQuality: 0.7)
                        }
                        onSave(model)
                    }
                }
            }
            .onAppear {
                if let data = model.backgroundImageData {
                    uiImage = UIImage(data: data)
                }
            }
            .sheet(isPresented: $showingPicker) {
                PhotoPicker(image: $uiImage)
            }
        }
    }
}
