//
//  TypeTask.swift
//  Education tracker
//
//  Created by Иван Миронов on 22.04.2025.
//

import SwiftUI

enum TypeOptions: Int, Identifiable, CaseIterable{
    case ToDo
    case Meeting
    case Remind
    case Learn
        
    var name: String{
        switch self {
            case .ToDo:
            return "To Do"
        case .Meeting:
            return "Meeting"
        case .Remind:
            return "Remind"
        case .Learn:
            return "Learn"
        
        }
    }
    var id: Int{
        rawValue
    }
}

struct TypeTask: View {
    @State var SelectedType: TypeOptions = .ToDo
    @State var showType: Bool = false
    
    var body: some View {
        //===== Type =====
        VStack{
            HStack{
                Text("Type")
                Spacer()
                Text(SelectedType.name)
            }
            .padding(.vertical,10)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)){
                    showType.toggle()
                }
            }
            
            if showType{
                ForEach(TypeOptions.allCases){ index in
                    HStack{
                        Spacer()
                        Text(index.name)
                            .padding(.vertical, 10)
                            .foregroundColor(SelectedType == index ? .blue : .gray)
                        if SelectedType == index {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.trailing,10)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)){
                            SelectedType = index
                            showType = false
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TypeTask()
}
