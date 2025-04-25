//
//  StatusView.swift
//  Education tracker
//
//  Created by Иван Миронов on 22.04.2025.
//

import SwiftUI

enum StatusOptions:  Int, Identifiable, CaseIterable {
    case ToDo
    case InProgress
    case Done
    
    var name: String {
        switch self {
            case .ToDo:
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
    @Binding var selectedStatus: StatusOptions
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

struct PreviewWrapperStatus: View {
    @State private var selectedStatus: StatusOptions = .ToDo
    
    var body: some View {
        StatusView( selectedStatus: $selectedStatus)
    }
}

#Preview {
    PreviewWrapperStatus()
}
