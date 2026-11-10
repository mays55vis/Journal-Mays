import SwiftUI

@main
struct MyApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .task {
                        try? await Task.sleep(for: .seconds(2))
                        showSplash = false
                    }
            } else {
                ContentView()
            }
        }
    }
}
