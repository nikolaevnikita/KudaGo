//
//  NetworkManager.swift
//  KudaGo
//
//  Created by Николаев Никита on 13.01.2021.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getURL(for page: Int) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "kudago.com"
        components.path = "/public-api/v1.2/events"
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "page_size", value: "\(Constants.API.pageSize)"),
            URLQueryItem(name: "text_format", value: "text"),
            URLQueryItem(name: "fields", value: "title,images,description,body_text"),
            URLQueryItem(name: "order_by", value: "-date,-rank"),
            URLQueryItem(name: "location", value: "msk")
        ]
        return components.url
    }
    
    func fetchEvents(for page: Int, completion: @escaping (Result<[Event], NetworkError>) -> ()) {
        guard let url = getURL(for: page) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard error == nil else {
                completion(.failure(error as! NetworkError))
                return
            }
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            guard let decodedData = self.parseJSON(data: data, type: EventsResponse.self) else {
                completion(.failure(.decodeError))
                return
            }
            guard let results = decodedData.results else {
                completion(.failure(.emptyResult))
                return
            }
            completion(.success(results))
        }.resume()
    }

    func parseJSON<T: Codable>(data: Data, type: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let responseModel = try decoder.decode(type, from: data)
            return responseModel
        } catch {
            print(error)
        }
        return nil
    }
}

enum NetworkError: Error {
    case invalidURL
    case emptyData
    case decodeError
    case emptyResult
}
