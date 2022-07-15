//
//  ApiCaller.swift
//  NewsApp
//
//  Created by Pantos, Thomas on 7/7/22.
//

import Foundation

final class APICaller{
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=8bb0bcc581af42fd82f0b69aa3d0dc66")
    }

    private init(){}
        
        public func getTopstories(completion: @escaping (Result<[Article], Error>) -> Void) {
            guard let url = Constants.topHeadlinesURL else {
                return
            }
            
            let task = URLSession.shared.dataTask(with: url){data , _, error in
                if let error = error {
                    completion(.failure(error))
                }
                else if let data = data {
                    do {
                        let result = try JSONDecoder().decode(APIResponse.self, from:  data)
                        print("Articles: \(result.articles.count)")
                        completion(.success(result.articles))
                    } catch{
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        }
    
    }
//Models

struct APIResponse: Codable {
    let articles: [Article]
}
struct Article : Codable {
    let source: Source
    let title: String
    let description : String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    
}

struct Source: Codable{
    let name: String
}
