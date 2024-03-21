//
//  ContentView.swift
//  BookProject
//


import SwiftUI


struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let imageName: String
    var notes: String // Added notes property
}

struct ContentView: View {
    @State private var selectedBook: Book? = nil // Track the selected book
        @State private var books: [Book] // Use @State for books
        
        init() {
            // Initialize books with the list of books
            self._books = State(initialValue: [
                Book(title: "Babel", author: "RF Kuang", imageName: "Babel", notes: ""),
                Book(title: "The Secret History", author: "Donna Tartt", imageName: "secret", notes: ""),
                Book(title: "Song of Åchilles", author: "Madelline Miller", imageName: "achilles", notes: ""),
                Book(title: "Pride and Prejudice", author: "Jane Austen", imageName: "pride", notes: "")
            ])
            
            // Load notes from UserDefaults and update the books with notes
            for index in books.indices {
                let notes = UserDefaults.standard.string(forKey: "\(books[index].id)-notes") ?? ""
                books[index].notes = notes
            }
        }
        
        var body: some View {
            NavigationView {
                List(books) { book in
                    NavigationLink(destination: BookDetailView(book: book, onSave: { notes in
                        // Update the notes for the book
                        if let index = self.books.firstIndex(where: { $0.id == book.id }) {
                            self.books[index].notes = notes
                            UserDefaults.standard.set(notes, forKey: "\(book.id)-notes") // Save notes to UserDefaults
                        }
                    })) {
                        BookRow(book: book)
                    }
                }
                .navigationTitle("Books")
            }
        }
    }

struct BookRow: View {
    let book: Book
    
    var body: some View {
        HStack {
            Image(book.imageName)
                .resizable()
                .frame(width: 50, height: 70)
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}

struct BookDetailView: View {
    let book: Book
    let onSave: (String) -> Void // Closure to save notes
    
    @State private var notes: String // Use a state variable for notes
    
    init(book: Book, onSave: @escaping (String) -> Void) {
        self.book = book
        self.onSave = onSave
        _notes = State(initialValue: book.notes) // Initialize notes with initial value
    }
    
    var body: some View {
        VStack {
            Image(book.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Text(book.title)
                .font(.title)
                .padding(.top)
            Text("by \(book.author)")
                .font(.subheadline)
                .foregroundColor(.gray)
            TextField("Notes", text: $notes)
                .padding()
            Button("Save", action: {
                // Call onSave closure to save notes
                onSave(notes)
            })
            .padding()
            Spacer()
        }
        .navigationTitle(book.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
