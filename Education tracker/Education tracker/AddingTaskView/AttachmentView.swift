//
//  AttachmentView.swift
//  Education tracker
//
//  Created by Иван Миронов on 22.04.2025.
//

import SwiftUI

struct AttachmentView: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Text("Attachment")
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "paperclip")
                    .foregroundColor(.black)
            }
        }
    }
}


#Preview {
    AttachmentView()
}
