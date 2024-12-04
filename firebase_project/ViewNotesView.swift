import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ViewNotesView: View {
    @State private var notes: [(id: String, title: String, description: String)] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    private let db = Firestore.firestore()

    var body: some View {
            
            VStack {
                Text("Your Notes")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.black)
                
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding()
                } else if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()
                } else if notes.isEmpty {
                    Spacer()
                    Text("No Notes Yet")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List(notes, id: \.id) { note in
                        VStack(alignment: .leading) {
                            Text(note.title)
                                .font(.headline)
                                .foregroundColor(.black)
                            Text(note.description)
                                .font(.subheadline)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .padding()
            .onAppear(perform: fetchNotes)
    }

    func fetchNotes() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("No user is logged in.")
            errorMessage = "No user is logged in. Please log in to view your notes."
            isLoading = false
            return
        }

        db.collection("notes")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error fetching notes: \(error.localizedDescription)")
                    errorMessage = "Error fetching notes: \(error.localizedDescription)"
                } else if let snapshot = snapshot {
                    notes = snapshot.documents.map { doc in
                        let data = doc.data()
                        let id = doc.documentID
                        let title = data["title"] as? String ?? "Untitled"
                        let description = data["description"] as? String ?? "No description"
                        return (id, title, description)
                    }
                    if notes.isEmpty {
                        errorMessage = "No notes available."
                    }
                }
                isLoading = false
            }
    }
}
