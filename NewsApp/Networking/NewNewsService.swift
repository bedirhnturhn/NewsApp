//
//  NewNewsService.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 12.07.2022.
//

import Foundation

protocol NewNewsServiceProtocol {
    func fetchNews<Request : DataRequest>(_ request : Request, completion : @escaping(Result<Request.Response, NetworkResponse>) -> Void)
}


final class NewNewsService : NewNewsServiceProtocol{
    func fetchNews<Request : DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, NetworkResponse>) -> Void)  {
        
        guard var urlComponent = URLComponents(string: request.createUrlString()) else {
            return completion(.failure(.badRequest))
        }
        
        var queryItems = [URLQueryItem]()
        
        request.queryItems.forEach {
            let urlQueryItem = URLQueryItem(name: $0.key, value: $0.value)
            urlComponent.queryItems?.append(urlQueryItem)
            queryItems.append(urlQueryItem)
        }
        
        urlComponent.queryItems = queryItems
        
        guard let url = urlComponent.url else {
            return completion(.failure(.badRequest))
        }
        
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(.failed))
            }
            
            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                return completion(.failure(.failed))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            do{
                try completion(.success(request.decode(data)))
            }catch let error as NSError{
                completion(.failure(.unableToDecode))
            }
        }
        .resume()
    }
}
