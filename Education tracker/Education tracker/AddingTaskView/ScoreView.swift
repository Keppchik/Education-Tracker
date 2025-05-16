//
//  ScoreView.swift
//  Education tracker
//
//  Создан Иваном Миронов 26.04.2025.
//

import SwiftUI

/// Поле ввода «баллы / максимум» с простейшей валидацией.
///
/// Отображает два `TextField`, позволяя пользователю ввести текущий результат и
/// максимальное количество баллов.
/// Если `maxScore` меньше `currentScore`, показывается строка ошибки.
///
/// - Parameters:
///   - currentScore: Двусторонняя привязка к текущему количеству баллов.
///   - maxScore: Двусторонняя привязка к максимальному количеству баллов.
///   - showMaxScoreError: Флаг, контролирующий вывод сообщения об ошибке.
struct ScoreView: View {
    // MARK: - Привязки
    @Binding var currentScore: Int16
    @Binding var maxScore: Int16
    @Binding var showMaxScoreError: Bool
    
    // MARK: - UI
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("Score:")
                Spacer()
                
                // Поле ввода текущего результата
                TextField("", value: $currentScore, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 55)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                
                Text("/")
                
                // Поле ввода максимального результата
                TextField("", value: $maxScore, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 55)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
            }
            
            // Сообщение о некорректном вводе
            if showMaxScoreError && maxScore < currentScore {
                Text("Max score cannot be less then score")
                    .foregroundColor(.red)
                    .font(.caption)
            }
        }
    }
}

// MARK: - Превью
#Preview {
    ScoreView(currentScore: .constant(80), maxScore: .constant(10), showMaxScoreError: .constant(true))
}
