//
//  DescribtionView.swift
//  Education tracker
//
//  Created by Иван Миронов on 23.04.2025.
//

import SwiftUI

struct DescribtionView: View {
    @Binding var descriptionText: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $descriptionText)
                .frame(minHeight: 200, maxHeight: 500)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .scrollContentBackground(.hidden)
            
            if descriptionText.isEmpty {
                Text("Description")
                    .foregroundColor(Color(.placeholderText))
                    .padding(.horizontal, 21)
                    .padding(.vertical, 23)
            }
        }
    }
}

struct PreviewWrapperDescribtion: View {
        @State private var text = ""
        
        var body: some View {
            DescribtionView(descriptionText: $text)
        }
    }

#Preview {
    PreviewWrapperDescribtion()
}
