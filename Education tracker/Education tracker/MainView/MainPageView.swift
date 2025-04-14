import SwiftUI

struct MainScreenView: View {
    
    var body: some View {
        // Главное «полотно»
        ZStack {
            // 1. Фон – тёмный цвет
            Color(.black)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // 2. Верхняя шапка
                HStack {
                    // «Гамбургер»-кнопка
                    Button(action: {
                        print("Hamburger tapped")
                        // Пока без функционала
                    }) {
                        Image(systemName: "line.horizontal.3") // SF Symbol
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("Education Tracker")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Пустая вью для выравнивания (чтобы текст был по центру)
                    // Либо может быть в будущем иконка профиля и т.п.
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 44) // ширина под кнопку гамбургера
                }
                .padding(.horizontal)
                .padding(.vertical, 12)
                .background(Color(.darkGray)) // или .black, смотря какой тон у вас
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 2)
                
                // 3. Основной белый контейнер
                ZStack {
                    Color.white
                    VStack(alignment: .leading, spacing: 16) {
                        
                        // Заголовок "Tasks" + иконка "+"
                        HStack {
                            Text("Tasks")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Spacer()
                            Button(action: {
                                print("+ button tapped")
                            }) {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.top, 20)
                        
                        // Карточки (Todo, In Progress, Completed)
                        // Можно сделать Grid, но упрощённо - HStack/VStack
                        VStack(spacing: 12) {
                            HStack(spacing: 12) {
                                TaskCardView(iconName: "arrow.down", title: "Todo", count: 4)
                                TaskCardView(iconName: "arrow.right", title: "In Progress", count: 2)
                            }
                            HStack(spacing: 12) {
                                TaskCardView(iconName: "checkmark", title: "Completed", count: 1)
                                Spacer() // Чтобы было 2 штуки в ряду (третья не нужна?)
                            }
                        }
                        
                        // Заголовок "My Lists"
                        Text("My Lists")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.top, 16)
                        
                        // Перечень списков
                        VStack(spacing: 10) {
                            ListRowView(title: "Weekly To Do", count: 2)
                            ListRowView(title: "Workout plan", count: 2)
                            ListRowView(title: "Onboarding", count: 18)
                            ListRowView(title: "Charlie's birthday", count: 8)
                            ListRowView(title: "Fitness plan", count: 4)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                }
                
                // 4. Нижняя панель (табы)
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            print("Home tapped")
                        }) {
                            Image(systemName: "house")
                                .font(.title3)
                        }
                        Text("Home")
                            .font(.caption)
                    }
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            print("Lists tapped")
                        }) {
                            Image(systemName: "list.bullet")
                                .font(.title3)
                        }
                        Text("Lists")
                            .font(.caption)
                    }
                    Spacer()
                    
                    VStack {
                        Button(action: {
                            print("Settings tapped")
                        }) {
                            Image(systemName: "gearshape")
                                .font(.title3)
                        }
                        Text("Settings")
                            .font(.caption)
                    }
                    Spacer()
                }
                .padding(.vertical, 8)
                .background(Color.white)
                .foregroundColor(.black)
                
            } // end VStack
        }
    }
}

// Дополнительные вью для карточек задач и строк списков
struct TaskCardView: View {
    let iconName: String
    let title: String
    let count: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(systemName: iconName)
                .font(.title2)
            Text(title)
                .font(.headline)
            Text("\(count) tasks")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
        )
    }
}

struct ListRowView: View {
    let title: String
    let count: Int
    
    var body: some View {
        HStack {
            // Иконка с «тремя полосками»
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
                .frame(width: 40, height: 40)
                .overlay(
                    Image(systemName: "line.horizontal.3")
                )
            
            Text(title)
                .lineLimit(1)
            Spacer()
            Text("\(count)")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

// Предпросмотр
struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
