//
//  NewsService.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 27.06.2022.

import Foundation
import RxSwift


protocol NewsServiceProtocol {

    func fetchDataForSearchController(_ searchedQuery: String, _ page: Int) -> Observable<ENewsModel>
    func fetchSources(_ from: SRequest) -> Observable<SourcesModel>
    func fetchNewsWithSources(_ page: Int, _ source: String) -> Observable<ENewsModel>
    func fetchTHNews(_ page: Int, _ category: THCategories) -> Observable<THNewsModel>
    func fetch(_ page: Int) -> Observable<ENewsModel>

}

class NewsService: NewsServiceProtocol {
    func fetchSources(_ from: SRequest) -> Observable<SourcesModel> {

        return apiRequest(NewsAPI.fetchSources(from).createUrlRequest()!)
    }

    func fetch(_ page: Int) -> Observable<ENewsModel> {

        return apiRequest(NewsAPI.fetch(page).createUrlRequest()!)
    }
    
    func fetchDelegate(_ page: Int, completion : ((Result<[News], NetworkResponse>) -> Void)?) {
        apiRequest2(NewsAPI.fetch(page).createUrlRequest()!) { result in
            completion!(result)
        }
    }

    func fetchTHNews(_ page: Int, _ category: THCategories) -> Observable<THNewsModel> {
        return apiRequest(NewsAPI.fetchTHNews(page, category).createUrlRequest()!)
    }

    func fetchTHNewsDelegate(_ page: Int, _ category: THCategories, completion : ((Result<[News], NetworkResponse>) -> Void)?) {
        apiRequest2(NewsAPI.fetchTHNews(page, category).createUrlRequest()!) { responce in
            completion!(responce)
        }

    }
    
    func fetchDataForSearchController(_ searchedQuery: String, _ page: Int) -> Observable<ENewsModel> {

        return apiRequest(NewsAPI.fetchDataForSearchController(searchedQuery, page).createUrlRequest()!)
    }

    func fetchNewsWithSources(_ page: Int, _ source: String) -> Observable<ENewsModel> {

        return apiRequest(NewsAPI.fetchNewsWithSources(page, source).createUrlRequest()!)
    }

    func apiRequest<T: Decodable>(_ urlRequest: URLRequest) -> Observable<T> {
        return Observable<T>.create { observer in

            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in

                if let _ = error {
                    observer.onError(NetworkResponse.badRequest)
                }
                guard let data = data else {
                    observer.onError(NetworkResponse.noData)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    observer.onError(NetworkResponse.badRequest)
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let news = try decoder.decode(T.self, from: data)
                    observer.onNext(news)
                    observer.onCompleted()
                } catch {
                    observer.onError(NetworkResponse.unableToDecode)
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    
    func apiRequest2(_ urlRequest: URLRequest,completion: @escaping((Result<[News], NetworkResponse>) -> Void)) {
            let task = URLSession.shared.dataTask(with: urlRequest) { [self] (data, response, error) in

                if let _ = error {
                    completion(.failure(NetworkResponse.badRequest))
                }
                guard let data = data else {
                    completion(.failure(NetworkResponse.noData))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(NetworkResponse.badRequest))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let sourceJsonDecoded = try decoder.decode(SourceStatus.self, from: data)
                    let news = sourceJsonDecoded.articles
                    completion(.success(news))
                } catch {
                    completion(.failure(NetworkResponse.unableToDecode))
                }
            }
            task.resume()
    }

}
