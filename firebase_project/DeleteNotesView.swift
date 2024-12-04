import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct DeleteNotesView: View {
    @State private var notes: [(id: String, title: String)] = []
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var noteToDelete: String? = nil
    private let db = Firestore.firestore()

    var body: some View {
        VStack {
            Text("Delete Notes")
                .font(.largeTitle)
                .bold()
            
            List {
                ForEach(notes, id: \.id) { note in
                    HStack {
                        Text(note.title)
                        Spacer()
                        Button(action: {
                            noteToDelete = note.id
                            showAlert = true
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .onAppear(perform: fetchNotes)
            .alert(isPresented: $showAlert) {
                if let noteId = noteToDelete {
                    return Alert(
                        title: Text("Delete Note"),
                        message: Text("Are you sure you want to delete this note?"),
                        primaryButton: .destructive(Text("Delete")) {
                            deleteNote(noteId: noteId)
                        },
                        secondaryButton: .cancel()
                    )
                } else {
                    return Alert(
                        title: Text("Status"),
                        message: Text(alertMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }

    func fetchNotes() {
        guard let userId = Auth.auth().currentUser?.uid else {
            alertMessage = "No user is logged in."
            showAlert = true
            return
        }
        
        db.collection("notes")
            .whereField("userId", isEqualTo: userId)
            .getDocuments { snapshot, error in
                if let error = error {
                    alertMessage = "Error fetching notes: \(error.localizedDescription)"
                    showAlert = true
                } else if let snapshot = snapshot {
                    notes = snapshot.documents.map { doc in
                        let data = doc.data()
                        let id = doc.documentID
                        let title = data["title"] as? String ?? "Untitled"
                        return (id, title)
                    }
                }
            }
    }

    func deleteNote(noteId: String) {
        db.collection("notes").document(noteId).delete { error in
            if let error = error {
                alertMessage = "Error deleting note: \(error.localizedDescription)"
            } else {
                notes.removeAll { $0.id == noteId }
                alertMessage = "Note deleted successfully."
            }
            noteToDelete = nil
            showAlert = true
        }
    }
}
