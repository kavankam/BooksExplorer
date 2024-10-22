//
//  Book.swift
//  BooksExplorer
//
//  Created by Kavan Kamangar on 10/21/24.
//

import Foundation

// MARK: - Book
struct Book: Codable {
    let totalItems: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable, Identifiable {
    let id = UUID()
    let volumeInfo: VolumeInfo
}

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let publishedDate, description: String
    let imageLinks: ImageLinks
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String
}

// MARK: -MockData
struct MockData {
    static let sampleBooks = Item(volumeInfo: VolumeInfo(title: "good book", subtitle: "this is sybtitle", authors: ["anyone"], publishedDate: "2002", description: "this is the description", imageLinks: ImageLinks(smallThumbnail: "", thumbnail: "")))
    
    static let books = [sampleBooks, sampleBooks, sampleBooks, sampleBooks]
}
