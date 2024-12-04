import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct AuthView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var isLoggedIn = false
    @State private var isSignUp = true
    @State private var userName = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        if isLoggedIn {
            MainMenuView()
        } else {
            ZStack {
                // Background
                Color.black
                    .ignoresSafeArea()
                
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .foregroundStyle(.linearGradient(colors: [.pink, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 1000, height: 400)
                    .rotationEffect(.degrees(135))
                    .offset(y: -350)
                
                // Form
                VStack(spacing: 20) {
                    if isSignUp {
                        // Sign-Up View
                        Text("Sign Up")
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .offset(x: -100, y: -100)
                        
                        TextField("Name", text: $name)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(10)
                            .frame(width: 350)
                        
                        TextField("Email", text: $email)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(10)
                            .frame(width: 350)
                        
                        SecureField("Password", text: $password)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(10)
                            .frame(width: 350)
                        
                        Button(action: signUp) {
                            Text("Sign Up")
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing)))
                                .foregroundColor(.white)
                        }
                        
                        Button(action: { isSignUp = false }) {
                            Text("Already have an account?")
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        .offset(y: 110)
                    } else {
                        // Login View
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .offset(x: -100, y: -100)
                        
                        TextField("Email", text: $email)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(10)
                            .frame(width: 350)
                        
                        SecureField("Password", text: $password)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(10)
                            .frame(width: 350)
                        
                        Button(action: login) {
                            Text("Login")
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(.linearGradient(colors: [.pink, .red], startPoint: .top, endPoint: .bottomTrailing)))
                                .foregroundColor(.white)
                        }
                        
                        Button(action: { isSignUp = true }) {
                            Text("Don't have an account?")
                                .bold()
                                .foregroundColor(.white)
                        }
                        .padding(.top)
                        .offset(y: 110)
                    }
                }
                .frame(width: 350)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // Sign-Up Function
    func signUp() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                alertMessage = "Error creating user: \(error.localizedDescription)"
                showAlert = true
            } else {
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(result!.user.uid)
                userRef.setData(["name": name, "email": email]) { err in
                    if let err = err {
                        alertMessage = "Error saving user data: \(err.localizedDescription)"
                        showAlert = true
                    } else {
                        isLoggedIn = true
                        userName = name
                    }
                }
            }
        }
    }
    
    // Login Function
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                alertMessage = "Error signing in: \(error.localizedDescription)"
                showAlert = true
            } else {
                let db = Firestore.firestore()
                let userRef = db.collection("users").document(result!.user.uid)
                userRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        if let userData = document.data() {
                            userName = userData["name"] as? String ?? "Unknown"
                            isLoggedIn = true
                        }
                    } else {
                        alertMessage = "User data not found"
                        showAlert = true
                    }
                }
            }
        }
    }
}
