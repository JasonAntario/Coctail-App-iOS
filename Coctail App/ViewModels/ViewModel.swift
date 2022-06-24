//
//  ViewModel.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 24.06.22.
//

import Foundation

class ViewModel {
    
    private let apiSession = ApiSession()
    
    var coctailsListBind = Dynamic([CoctailsListDao.DrinkDao]())
    
    init() {
        apiSession.apiSessionDelegate = self
    }
    
    
    

    func getCoctailsByFirstLetter(_ letter: String){
        apiSession.getCoctailsByFirstLetter(letter)
    }
    
    func getCoctailsByFullName(_ name: String){
        apiSession.getCoctailsByFullName(name)
    }
    
}

extension ViewModel: ApiSessionDelegate {
    func didCoctailsListRecieved(coctailsList: CoctailsListDao) {
        if let safeDrinks = coctailsList.drinks {
            self.coctailsListBind.value = safeDrinks
        } else {
            print("No drinks founded")
            self.coctailsListBind.value = [CoctailsListDao.DrinkDao]()
        }
    }
}
