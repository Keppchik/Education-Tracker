//
//  DescribtionView.swift
//  Education tracker
//
//  Created by Иван Миронов on 23.04.2025.
//

import SwiftUI

struct DescribtionView: View {
    @State var name2: String = ""
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $name2)
                .frame(minHeight: 200, maxHeight: 500)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .scrollContentBackground(.hidden)
            
            if name2.isEmpty {
                Text("Description")
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 21)
                    .padding(.vertical, 23)
            }
        }
    }
}

#Preview {
    DescribtionView()
}
