//
//  BooksExplorerListCell.swift
//  BooksExplorer
//
//  Created by Kavan Kamangar on 10/22/24.
//

import SwiftUI

struct BooksExplorerListCell: View {
    
    let book: Item
    
    var body: some View {
        HStack {
            BooksRemoteImage(urlString: book.volumeInfo.imageLinks.smallThumbnail)
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 90)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(book.volumeInfo.title)
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                
                
                HStack(spacing: 5) {
                    Text(book.volumeInfo.authors.first ?? "")
                        .font(.system(size: 12))
                        
                    Text(book.volumeInfo.publishedDate)
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                        .fontWeight(.semibold)
                }
            }
            .padding(.leading)
        }
    }
}

#Preview {
    BooksExplorerListCell(book: MockData.sampleBooks)
}
