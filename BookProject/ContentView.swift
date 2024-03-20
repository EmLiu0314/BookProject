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
}

struct ContentView: View {
        let books = [
            Book(title: "Babel", author: "RF Kuang", imageName: "Babel"),
            Book(title: "The Secret History", author: "Donna Tartt", imageName: "SecretHistory"),
            Book(title: "Song of Åchilles", author: "Madelline Miller", imageName: "achilles"),
            Book(title: "Pride and Prejudice", author: "Jane Austen", imageName: "pride_prejudice")
        ]
        
        var body: some View {
            NavigationView {
                List(books) { book in
                    NavigationLink(destination: BookDetailView(book: book)) {
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

                     
