import SwiftUI

struct ScoreEditorView: View {
    @Binding var score: Int
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Stepper(value: $score, in: 0...100) {
                        Text("Score: \(score)/100")
                    }
                }
            }
            .navigationTitle("Edit Score")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ScoreEditorView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreEditorView(score: .constant(85))
    }
}
