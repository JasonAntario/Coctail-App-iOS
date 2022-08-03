//
//  UrlManager.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 24.06.22.
//

import Foundation
import Combine

class ApiSession {
    
    static let shared = ApiSession()
        
    func getCoctailsByFirstLetter(_ letter: String) -> AnyPublisher<CoctailsListDao, Never>{
        let baseUrlString = Bundle.main.infoDictionary?["BASE_URL"] as! String
        guard let baseUrl = URL(string: baseUrlString) else { return Just(CoctailsListDao.placeholder).eraseToAnyPublisher() }
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "f", value: letter)]
        guard let saveUrl = urlComponents?.url else { return Just(CoctailsListDao.placeholder).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: saveUrl)
            .map { $0.data }
            .decode(type: CoctailsListDao.self, decoder: JSONDecoder())
            .catch { error in
                Just(CoctailsListDao.placeholder)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func getCoctailsByFullName(_ name: String) -> AnyPublisher<CoctailsListDao, Never>{
        let trimmingName = name.trimmingLeadingAndTrailingSpaces()
        guard let encodedName = trimmingName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return Just(CoctailsListDao.placeholder).eraseToAnyPublisher() }
        let baseUrlString = Bundle.main.infoDictionary?["BASE_URL"] as! String
        guard let baseUrl = URL(string: baseUrlString) else { return Just(CoctailsListDao.placeholder).eraseToAnyPublisher()}
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = [URLQueryItem(name: "s", value: encodedName)]
        
        guard let saveUrl = urlComponents?.url else { return Just(CoctailsListDao.placeholder).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: saveUrl)
            .map { $0.data }
            .decode(type: CoctailsListDao.self, decoder: JSONDecoder())
            .catch { error in Just(CoctailsListDao.placeholder) }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

extension String {
    func trimmingLeadingAndTrailingSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return trimmingCharacters(in: characterSet)
    }
}
