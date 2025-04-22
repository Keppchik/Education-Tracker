//
//  StatusView.swift
//  Education tracker
//
//  Created by Иван Миронов on 22.04.2025.
//

import SwiftUI

enum StatusOptions:  Int, Identifiable, CaseIterable {
    case Todo
    case InProgress
    case Done
    
    var name: String {
        switch self {
            case .Todo:
            return "To do"
        case .InProgress:
            return "In progress"
        case .Done:
            return "Done"
        }
    }
    var id: Int {
        rawValue
    }
}

struct StatusView: View {
    @State var selectedStatus: StatusOptions = .Todo
    @State var showStatus: Bool = false
    var body: some View {
        VStack {
            HStack{
                Text("Status")
                Spacer()
                Text(selectedStatus.name)
            }
            .padding(.vertical,10)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)){
                    showStatus.toggle()
                }
            }
            if showStatus{
                ForEach(StatusOptions.allCases){ index in
                    HStack{
                        Spacer()
                        Text(index.name)
                            .padding(.vertical, 5)
                            .foregroundColor(selectedStatus == index ? .blue : .gray)
                        if selectedStatus == index {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.trailing,10)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)){
                            selectedStatus = index
                            showStatus = false
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    StatusView()
}
