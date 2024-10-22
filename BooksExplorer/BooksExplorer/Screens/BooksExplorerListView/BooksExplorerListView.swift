//
//  ContentView.swift
//  BooksExplorer
//
//  Created by Kavan Kamangar on 10/21/24.
//
import SwiftUI

struct BooksExplorerListView: View {
    
    @StateObject var viewModel = BooksExplorerListViewModel()
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    
                    if !viewModel.books.isEmpty || !viewModel.searchText.isEmpty {
                        TextField("Search Books", text: $viewModel.searchText)
                            .padding(8)
                            .background(Color(.systemGray5))
                            .cornerRadius(8)
                            .padding([.leading, .trailing])
                    }
                    
                 
                    if viewModel.isBooksListEmpty {
                        Spacer()
                        Text("No books available")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    } else if viewModel.filteredBooks.isEmpty && !viewModel.searchText.isEmpty {
                    
                        Spacer()
                        Text("No results found")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .padding()
                        Spacer()
                    } else {
                        
                        List(viewModel.filteredBooks) { book in
                            BooksExplorerListCell(book: book)
                                .onTapGesture {
                                    viewModel.selectedBook = book
                                    viewModel.isShowingDetial = true
                                }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
               
                .navigationTitle(viewModel.books.isEmpty ? "" : "📚 Books")
                .disabled(viewModel.isShowingDetial)
            }
            .blur(radius: viewModel.isShowingDetial ? 20 : 0)
            
            if viewModel.isShowingDetial {
                BooksDetailView(book: viewModel.selectedBook!, isShowingDetail: $viewModel.isShowingDetial)
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .onAppear {
            viewModel.getBooks()
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}
