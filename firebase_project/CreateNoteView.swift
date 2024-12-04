import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct CreateNoteView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    private let db = Firestore.firestore()

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.pink, .red], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            VStack(spacing: 20) {
                Text("Create Note")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                
                TextField("Title", text: $title)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .frame(width: 350)

                TextField("Description", text: $description)
                    .padding()
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(10)
                    .frame(width: 350)

                Button(action: saveNote) {
                    Text("Save Note")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Note Status"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }

    func saveNote() {
        guard let userId = Auth.auth().currentUser?.uid else {
            alertMessage = "No user is logged in. Please log in to save notes."
            showAlert = true
            return
        }
        
        guard !title.isEmpty, !description.isEmpty else {
            alertMessage = "Please provide both a title and description for the note."
            showAlert = true
            return
        }

        db.collection("notes").addDocument(data: [
            "userId": userId,
            "title": title,
            "description": description,
            "timestamp": Date()
        ]) { error in
            if let error = error {
                alertMessage = "Error saving note: \(error.localizedDescription)"
            } else {
                title = ""
                description = ""
                alertMessage = "Note saved successfully."
            }
            showAlert = true
        }
    }
}
