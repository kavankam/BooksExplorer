//
//  NetworkManager.swift
//  BooksExplorer
//
//  Created by Kavan Kamangar on 10/22/24.
//

import Foundation
import UIKit

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let cashe = NSCache<NSString, UIImage>()
    
    private let baseURL = "https://www.googleapis.com/books/v1/volumes?q=https://openlibrary.org/search.json?title"
    
    private init() {}
    
    
    func getBooks(completed: @escaping (Result<[Item], BooksError>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error  {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(Book.self, from: data)
                completed(.success(decodedResponse.items))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(fromURLString urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let casheKey = NSString(string: urlString)
        
        if let image = cashe.object(forKey: casheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            
            guard let data = data, let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cashe.setObject(image, forKey: casheKey)
            completed(image)
        }
        
        task.resume()
    }
}
