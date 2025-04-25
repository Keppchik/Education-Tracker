import SwiftUI

struct DetailItemView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.black)
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
