import SwiftUI
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct FirebaseProjectApp: App {
    
    @StateObject private var userManager = UserManager()
    
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            if userManager.isLoading {
                LoadingView()
            } else {
                if userManager.isLoggedIn {
                    MainMenuView()
                } else {
                    AuthView()
                }
            }
        }
    }
}

class UserManager: ObservableObject {
    @Published var isLoggedIn = false
    @Published var isLoading = true
    
    init() {
        checkUserStatus()
    }
    
    private func checkUserStatus() {
        if let user = Auth.auth().currentUser {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }

        isLoading = false
    }
}

