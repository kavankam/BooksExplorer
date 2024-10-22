//
//  BooksDetailView.swift
//  BooksExplorer
//
//  Created by Kavan Kamangar on 10/22/24.
//

import SwiftUI

struct BooksDetailView: View {
    
    let book: Item
    @Binding var isShowingDetail: Bool
    
    var body: some View {
        VStack {
            BooksRemoteImage(urlString: book.volumeInfo.imageLinks.thumbnail)
                .aspectRatio(contentMode: .fit)
                .frame(width: 350, height: 150)
            
            VStack {
                Text(book.volumeInfo.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(book.volumeInfo.description)
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .lineLimit(10)
                    .padding()
                
                Text(book.volumeInfo.publishedDate)
                    .font(.system(size: 10))
                    .foregroundStyle(.secondary)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
            }
    
        }
        .frame(width: 350, height: 525)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(Button {
            isShowingDetail = false
        } label: {
            XDismissButton()
        }, alignment: .topTrailing)
    }
}

#Preview {
    BooksDetailView(book: MockData.sampleBooks, isShowingDetail: .constant(true))
}
