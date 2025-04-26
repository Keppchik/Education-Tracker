import SwiftUI

struct AttachmentItemView: View {
    let icon: String
    let name: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.primary)
                .frame(width: 30)
            
            Text(name)
                .font(.subheadline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "arrow.down.circle.fill")
                .foregroundColor(.primary)
        }
        .padding(.vertical, 6)
        .cornerRadius(8)
    }
}

struct AttachmentItemView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            AttachmentItemView(icon: "doc.fill", name: "Document.pdf")
            AttachmentItemView(icon: "folder.fill", name: "Assets.zip")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
