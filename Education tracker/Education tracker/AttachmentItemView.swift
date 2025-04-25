import SwiftUI

struct AttachmentItemView: View {
    let icon: String
    let name: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            Text(name)
                .font(.subheadline)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct AttachmentItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AttachmentItemView(icon: "doc", name: "Client_briefing.pdf")
            AttachmentItemView(icon: "folder", name: "Client_assets.zip")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
