import SwiftUI

struct TaskDetailsView: View {
    @State var taskName: String
    @State var currentScore: Int
    @State var maxScore: Int
    @State var taskType: String
    @State var taskDeadline: Date
    @State var taskStatus: String
    
    @State private var showingAttachmentAlert = false
    @State private var selectedAttachment = ""
    @State private var isMarkedDone = false
    @Environment(\.presentationMode) var presentationMode
    
    @State private var editScore = false
    
    let predefinedTypes = ["Meeting", "Documentation", "Design", "Development", "Review"]
    
    var formattedDeadline: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: taskDeadline)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Task: \(taskName)")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .padding(.vertical, 20)
                        
                    DetailItemView(title: "Current status:", value: isMarkedDone ? "Completed" : "In progress")
                        
                    Divider()
                        
                    DetailItemView(title: "Type", value: taskType)
                        
                    Divider()
                        
                    DetailItemView(title: "Deadline", value: formattedDeadline)
                        
                    Divider()
                        
                    DetailItemView(title: "Score", value: "\(currentScore)/\(maxScore)")
                        .padding(.bottom, 20)
                        
                    Text("Attachments")
                        .font(.headline)
                        .foregroundColor(.primary)
                        
                    VStack {
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
                .padding()
            }
            
            Button(action: {
                editScore = true
            }) {
                Text("Edit Score")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(.gray)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            
            Button(action: {
                
            }) {
                Text("Done")
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: Button(action: {
                
            }) {
                Image(systemName: "pencil")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.primary)
                    .padding(.trailing, 8)
            }
        )
        .sheet(isPresented: $editScore) {
            ScoreEditorView(score: $currentScore)
        }
        .alert("Attachment Selected", isPresented: $showingAttachmentAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("You selected: \(selectedAttachment)")
        }
    }
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskDetailsView(taskName: "Client Feedback Session", currentScore: 80, maxScore: 100, taskType: "Type", taskDeadline: Date(), taskStatus: "Status")
        }
    }
}
