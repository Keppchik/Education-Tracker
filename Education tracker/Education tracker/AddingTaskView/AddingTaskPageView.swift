//
//  AddingTaskPageView.swift
//  Education tracker
//
//  Created by Иван Миронов on 22.04.2025.
//

import SwiftUI


struct AddingTaskPageView: View {
    @State var name: String = ""
    @State var name2: String = ""
    @State var SelectedType: TypeOptions = .ToDo
    @State var SelectedStatus: StatusOptions = .Todo
    
    var body: some View {
        NavigationView {
            ScrollView{
                
                //===== Task Name =====
                HStack {
                    TextField("Task name", text: $name)
                        .padding()
                        .background(.gray.opacity(0.2))
                        .cornerRadius(10)
                }
                    .padding(.bottom)
                
                
                //===== Type =====
                TypeTask()
                    .padding(.vertical)
                
                //===== Deadline =====
                DeadlineView()
                    .padding(.vertical)
                
                //===== Attachment =====
                AttachmentView()
                    .padding(.vertical)
                
                //===== Status =====
                StatusView()
                    .padding(.vertical)
                
                //===== Notes/Describtion =====
                DescribtionView()
                    .padding(.vertical)
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            .navigationTitle(Text("Task"))
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
        }
        Button(action: {}) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
    }
}


#Preview {
    AddingTaskPageView()
}
