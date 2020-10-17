import SwiftUI

struct MessageRow: View {
    var message = ""
    var isMyMessage = false
    var user = ""

    var body: some View {
        HStack {
            if isMyMessage {
                Spacer()

                Text(message)
                .padding(8)
                .background(Color.blue)
                .cornerRadius(6)
                .foregroundColor(Color.white)
            } else {
                VStack(alignment: .leading) {
                    Text(message)
                    .padding(8)
                    .background(Color.green)
                    .cornerRadius(6)
                    .foregroundColor(Color.white)

                    Text(user)
                }

                Spacer()
            }
        }
    }
}

struct messageRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageRow(message: "Hoge", isMyMessage: false, user: "other")
    }
}
