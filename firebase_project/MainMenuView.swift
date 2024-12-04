import SwiftUI
import FirebaseAuth

struct MainMenuView: View {
    @State private var showCreateNote = false
    @State private var showViewNotes = false
    @State private var showDeleteNotes = false
    @State private var navigateToAuthView = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.pink, .red],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 1000, height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(y: -350)

                VStack(spacing: 20) {
                    Text("Main Menu")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .padding()
                    
                    NavigationLink(destination: CreateNoteView(), isActive: $showCreateNote) {
                        Button(action: { showCreateNote = true }) {
                            Text("Create Note")
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    NavigationLink(destination: ViewNotesView(), isActive: $showViewNotes) {
                        Button(action: { showViewNotes = true }) {
                            Text("View Notes")
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    NavigationLink(destination: DeleteNotesView(), isActive: $showDeleteNotes) {
                        Button(action: { showDeleteNotes = true }) {
                            Text("Delete Notes")
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    NavigationLink(destination: AuthView(), isActive: $navigateToAuthView) {
                        Button(action: logout) {
                            Text("Logout")
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }

                    Spacer()
                }
                .padding()
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Logout Failed"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            navigateToAuthView = true
        } catch let error {
            errorMessage = error.localizedDescription
            showErrorAlert = true
        }
    }
}
