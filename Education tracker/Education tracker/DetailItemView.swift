import SwiftUI

struct DetailItemView: View {
    let label: String
    let value: String
    var isType: Bool = false
    var isScore: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
            
            if isType {
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
            } else if isScore {
                HStack(spacing: 4) {
                    Text(value)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.green)
                    
                    Image(systemName: "pencil")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            } else {
                Text(value)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct DetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DetailItemView(label: "Type", value: "Meeting", isType: true)
            DetailItemView(label: "Deadline", value: "May 22nd, 2025")
            DetailItemView(label: "Score", value: "85/100", isScore: true)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
