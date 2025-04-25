import SwiftUI

struct ScoreEditorView: View {
    @Binding var type: String
    @Binding var deadline: Date
    @Binding var score: Int
    let predefinedTypes: [String]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section(header: Text("Task Type")) {
                Picker("Select Type", selection: $type) {
                    ForEach(predefinedTypes, id: \.self) { type in
                        Text(type).tag(type)
                    }
                }
                .pickerStyle(.menu)
                
                if !predefinedTypes.contains(type) {
                    TextField("Custom Type", text: $type)
                        .textFieldStyle(.roundedBorder)
                }
            }
            
            Section(header: Text("Deadline")) {
                DatePicker(
                    "Select Date",
                    selection: $deadline,
                    displayedComponents: .date
                )
                .datePickerStyle(.graphical)
            }
            
            Section(header: Text("Score")) {
                Stepper(value: $score, in: 0...100) {
                    Text("Score: \(score)/100")
                }
            }
        }
        .navigationTitle("Edit Task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
