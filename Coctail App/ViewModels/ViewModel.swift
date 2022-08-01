//
//  ViewModel.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 24.06.22.
//

import Foundation
import Combine

class ViewModel {
            
    @Published var inputString: String = ""
    @Published var outputCoctailsDao: CoctailsListDao = CoctailsListDao.placeholder
    
    init() {
        $inputString
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { (inputString: String) -> AnyPublisher<CoctailsListDao, Never> in
                let trimCoctailName = inputString.trimmingLeadingAndTrailingSpaces()
                if trimCoctailName.count > 1 {
                    return self.getCoctailsByFullName(trimCoctailName)
                } else {
                    return self.getCoctailsByFirstLetter(trimCoctailName)
                }
            }
            .assign(to: \.outputCoctailsDao, on: self)
            .store(in: &self.cancellableSet)
    }
    
    private var cancellableSet: Set<AnyCancellable> = []

    func getCoctailsByFirstLetter(_ letter: String) -> AnyPublisher<CoctailsListDao, Never>{
        return ApiSession.shared.getCoctailsByFirstLetter(letter)
    }
    
    func getCoctailsByFullName(_ name: String) -> AnyPublisher<CoctailsListDao, Never>{
        return ApiSession.shared.getCoctailsByFullName(name)
    }
}
