import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {

            VStack(spacing: 12) {
                Image("card2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)

                Text("Journali")
                    .font(.display)

                Text("Your thoughts, your story")
                    .font(.captionM)
            }
        }
    }
}

#Preview {
    SplashView()
        .preferredColorScheme(.dark)

}
