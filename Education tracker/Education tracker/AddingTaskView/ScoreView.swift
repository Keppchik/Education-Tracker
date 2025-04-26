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
    @Binding var showMaxScoreError: Bool
    
    var body: some View {
        VStack(alignment: .trailing) {
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
            
            if showMaxScoreError && maxScore < currentScore {
                Text("Max score cannot be less then score")
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
}

#Preview {
    ScoreView(currentScore: .constant(80), maxScore: .constant(10), showMaxScoreError: .constant(true))
}
