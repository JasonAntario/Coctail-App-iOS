//
//  K.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 24.06.22.
//

import Foundation

struct K {
    
    struct Request{
        static let urlGetCoctailsByFirstLetter = "https://www.thecocktaildb.com/api/json/v1/1/search.php"
        static let urlGetCoctailByFullName = "https://www.thecocktaildb.com/api/json/v1/1/search.php"
    }
    
    struct ID {
        static let coctailCellID = "CoctailCellID"
        static let coctailCellNib = "CoctailCell"
        static let coctailShowDetailsID = "ShowDetailsID"
    }
}
