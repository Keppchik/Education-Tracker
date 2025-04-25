//
//  AddingTaskPageView.swift
//  Education tracker
//
//  Created by Иван Миронов on 22.04.2025.
//

import SwiftUI


struct AddingTaskPageView: View {
    
    @State private var isEdit = false
    
    //переменные для дочерних элементов
    @State var name: String = ""
    @State var selectedType: TypeOptions = .ToDo
    @State var selectedStatus: StatusOptions = .ToDo
    @State var deadline: Date = Date()
    @State var currentScore: Int = 80
    @State var maxScore: Int = 100
    @State var description: String = ""
    @State var showNameError = false
    
    
    var body: some View {
        NavigationView {
            ScrollView{
                
                //===== Task Name =====
                VStack(alignment: .leading) {
                        TextField("Task name", text: $name)
                            .padding()
                            .background(.gray.opacity(0.2))
                            .cornerRadius(10)
                        
                        if showNameError && name.isEmpty {
                            Text("Task name cannot be empty")
                                .foregroundColor(.red)
                                .font(.caption)
                                .padding(.leading, 8)
                                
                        }
                    }
                    .padding(.bottom)
                
                
                //===== Type =====
                TypeTask(selectedType: $selectedType)
                    .padding(.vertical)
                
                //===== Deadline =====
                DeadlineView(selectedDate: $deadline)
                    .padding(.vertical)
                
                //===== Attachment =====
                AttachmentView()  //TODO: добавить функционал добавления файлов и их сохранения
                    .padding(.vertical)
                
                //===== Status =====
                StatusView(selectedStatus: $selectedStatus)
                    .padding(.vertical)
                
                //===== Score =====
                ScoreView(currentScore: $currentScore, maxScore: $maxScore)
                    .padding(.vertical)
                
                //===== Notes/Describtion =====
                DescribtionView(descriptionText: $description)
                    .padding(.vertical)
                
            }
            .padding(.horizontal)
            .padding(.vertical)
            .navigationTitle(Text("Task"))
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
        }
        Button(action: {
                    if name.isEmpty {
                        showNameError = true
                    } else {
                        //TODO: добавить полноценный функционал кнопки, с схохранением и созданием таска
                        
                    }
                }) {
                Text(isEdit ? "Update" : "Save")
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

#Preview {
    AddingTaskPageView(
        name: "Test",
        selectedType: .Learn,
        selectedStatus: .InProgress,
        deadline: Date(),
        currentScore: 10,
        maxScore: 10,
        description: "testing",
        showNameError: false
    )
}
