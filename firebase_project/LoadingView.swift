import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Loading...")
                .font(.title)
                .foregroundColor(.white)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        }
        .background(Color.black.ignoresSafeArea())
    }
}
