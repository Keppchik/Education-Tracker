import SwiftUI

struct DetailItemView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
    }
}

struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DetailItemView(title: "Type", value: "Meeting")
            DetailItemView(title: "Deadline", value: "May 22, 2023")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
