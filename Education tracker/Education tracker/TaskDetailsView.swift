import SwiftUI

struct TaskDetailsView: View {
    let taskName: String
    @State private var currentScore = 85
    @State private var showingEditor = false
    @State private var showingAttachmentAlert = false
    @State private var selectedAttachment = ""
    @State private var isMarkedDone = false
    @State private var taskType = "Meeting"
    @State private var taskDeadline = Date()
    @Environment(\.presentationMode) var presentationMode
    
    let predefinedTypes = ["Meeting", "Documentation", "Design", "Development", "Review"]
    
    var formattedDeadline: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: taskDeadline)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(taskName)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        DetailItemView(title: "Current status:", value: isMarkedDone ? "Completed" : "In progress")
                            .addDivider()
                    }
                    .padding(.bottom, 25)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        DetailItemView(title: "Type", value: taskType)
                            .addDivider()
                        
                        DetailItemView(title: "Deadline", value: formattedDeadline)
                            .addDivider()
                        
                        DetailItemView(title: "Score", value: "\(currentScore)/100")
                    }
                    .padding(.bottom, 30)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Attachments")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.bottom, 15)
                        
                        VStack(spacing: 10) {
                            Button(action: {
                                selectedAttachment = "Client_briefing.pdf"
                                showingAttachmentAlert = true
                            }) {
                                AttachmentItemView(icon: "doc.fill", name: "Client_briefing.pdf")
                            }
                            
                            Button(action: {
                                selectedAttachment = "Client_assets.zip"
                                showingAttachmentAlert = true
                            }) {
                                AttachmentItemView(icon: "folder.fill", name: "Client_assets.zip")
                            }
                        }
                    }
                    .padding(.bottom, 25)
                }
                .padding()
            }
            
            // Новая кнопка Done
            Button(action: {
                withAnimation {
                    isMarkedDone.toggle()
                }
            }) {
                Text("Done")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.blue)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
            },
            trailing: Button(action: {
                showingEditor = true
            }) {
                Image(systemName: "pencil")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
            }
        )
        .navigationTitle("Task Details")
        .sheet(isPresented: $showingEditor) {
            NavigationView {
                ScoreEditorView(
                    type: $taskType,
                    deadline: $taskDeadline,
                    score: $currentScore,
                    predefinedTypes: predefinedTypes
                )
            }
        }
        .alert("Attachment Selected", isPresented: $showingAttachmentAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("You selected: \(selectedAttachment)")
        }
    }
}

extension View {
    func addDivider() -> some View {
        VStack(spacing: 0) {
            self
            Divider()
                .background(Color.gray.opacity(0.2))
                .padding(.top, 8)
        }
    }
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskDetailsView(taskName: "Client Feedback Session")
        }
    }
}
