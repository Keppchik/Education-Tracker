//
//  TypeTask.swift
//  Education tracker
//
//  Created by Иван Миронов on 22.04.2025.
//

import SwiftUI

struct TypeTask: View {
    @Binding var selectedType: TypeOptions
    @State var ShowType: Bool = false
    
    var body: some View {
        //===== Type =====
        VStack{
            HStack{
                Text("Type")
                Spacer()
                Text(selectedType.name)
            }
            .padding(.vertical,10)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)){
                    ShowType.toggle()
                }
            }
            
            if ShowType{
                ForEach(TypeOptions.allCases){ index in
                    HStack{
                        Spacer()
                        Text(index.name)
                            .padding(.vertical, 5)
                            .foregroundColor(selectedType == index ? .blue : .gray)
                        if selectedType == index {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.trailing,10)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.2)){
                            selectedType = index
                            ShowType = false
                        }
                    }
                }
            }
        }
    }
}

struct PreviewWrapperType: View {
    @State private var selectedType: TypeOptions = .ToDo
    
    var body: some View {
        TypeTask(selectedType: $selectedType)
    }
}

#Preview {
    PreviewWrapperType()
}

