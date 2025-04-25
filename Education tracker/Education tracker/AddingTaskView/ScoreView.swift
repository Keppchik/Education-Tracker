//
//  ScoreView.swift
//  Education tracker
//
//  Created by Иван Миронов on 26.04.2025.
//

import SwiftUI

struct ScoreView: View {
    @Binding var currentScore: Int
    @Binding var maxScore: Int
    
    var body: some View {
        HStack {
            Text("Score:")
            Spacer()
            
            TextField("", value: $currentScore, formatter: NumberFormatter())
                .textFieldStyle(.roundedBorder)
                .frame(width: 55)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            
            Text("/")
            
            TextField("", value: $maxScore, formatter: NumberFormatter())
                .textFieldStyle(.roundedBorder)
                .frame(width: 55)
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
        }
    }
}

struct PreviewWrapperScore: View {
    @State var current = 80
    @State var max = 100
    
    var body: some View {
        ScoreView(currentScore: $current, maxScore: $max)
    }
}

#Preview {
    PreviewWrapperScore()
}
