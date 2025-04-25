import SwiftUI

struct TaskDetailsView: View {
    let taskName: String
    @State private var currentScore = 85
    @State private var showingScoreEditor = false
    @State private var showingAttachmentAlert = false
    @State private var selectedAttachment = ""
    @State private var isMarkedDone = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(taskName)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text(isMarkedDone ? "Completed" : "In progress")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 4)
                            .background(isMarkedDone ? Color.green.opacity(0.2) : Color.orange.opacity(0.2))
                            .foregroundColor(isMarkedDone ? .green : .orange)
                            .clipShape(Capsule())
                        
                        Spacer()
                    }
                }
                .padding(.bottom, 25)
                
                VStack(alignment: .leading, spacing: 20) {
                    DetailItemView(label: "Type", value: "Meeting", isType: true)
                    DetailItemView(label: "Deadline", value: "May 22nd, 2025")
                    
                    Button(action: {
                        showingScoreEditor = true
                    }) {
                        DetailItemView(label: "Score", value: "\(currentScore)/100", isScore: true)
                    }
                }
                .padding(.bottom, 30)
                
                Text("Attachments")
                    .font(.headline)
                    .padding(.bottom, 15)
                
                VStack(spacing: 10) {
                    Button(action: {
                        selectedAttachment = "Client_briefing.pdf"
                        showingAttachmentAlert = true
                    }) {
                        AttachmentItemView(icon: "doc", name: "Client_briefing.pdf")
                    }
                    
                    Button(action: {
                        selectedAttachment = "Client_assets.zip"
                        showingAttachmentAlert = true
                    }) {
                        AttachmentItemView(icon: "folder", name: "Client_assets.zip")
                    }
                }
                .padding(.bottom, 25)
                
                Button(action: {
                    if let url = URL(string: "https://example.com/feedback-form") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Spacer()
                        Text("Feedback form link")
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.bottom, 20)
                
                Button(action: {
                    withAnimation {
                        isMarkedDone.toggle()
                    }
                }) {
                    HStack {
                        Spacer()
                        Text(isMarkedDone ? "Completed ✓" : "Mark as Done")
                            .fontWeight(.medium)
                        Spacer()
                    }
                    .padding()
                    .background(isMarkedDone ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingScoreEditor) {
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
            TaskDetailsView(taskName: "Client Feedback Session")
        }
    }
}
