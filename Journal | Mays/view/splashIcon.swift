import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 12) {
                Image("card2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)

                Text("Journali")
                    .font(.display)
                    .foregroundColor(.textPrimary)

                Text("Your thoughts, your story")
                    .font(.captionM)
                    .foregroundColor(.textPrimary)
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SplashView()
}
