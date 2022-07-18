//
//  CoctailDao.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 24.06.22.
//

import Foundation

struct CoctailsListDao: Codable {
    let drinks: [DrinkDao]?
    
    struct DrinkDao: Codable{
        let idDrink: String
        let strDrink: String
        let strAlcoholic: String
        let strGlass: String
        let strInstructions: String
        let strDrinkThumb: String
        private let strIngredient1: String
        private let strIngredient2: String?
        private let strIngredient3: String?
        private let strIngredient4: String?
        private let strIngredient5: String?
        private let strIngredient6: String?
        private let strIngredient7: String?
        private let strIngredient8: String?
        private let strIngredient9: String?
        private let strIngredient10: String?
        private let strIngredient11: String?
        private let strIngredient12: String?
        private let strIngredient13: String?
        private let strIngredient14: String?
        private let strIngredient15: String?
        private let strMeasure1: String
        private let strMeasure2: String?
        private let strMeasure3: String?
        private let strMeasure4: String?
        private let strMeasure5: String?
        private let strMeasure6: String?
        private let strMeasure7: String?
        private let strMeasure8: String?
        private let strMeasure9: String?
        private let strMeasure10: String?
        private let strMeasure11: String?
        private let strMeasure12: String?
        private let strMeasure13: String?
        private let strMeasure14: String?
        private let strMeasure15: String?
        
        var ingredientsList: [Ingredient] {
            get {
                var list: [Ingredient] = []
                list.append(Ingredient(name: strIngredient1, measure: strMeasure1))
                if strIngredient2 != nil {
                    list.append(Ingredient(name: strIngredient2!, measure: strMeasure2!))
                } else {
                    return list
                }
                if strIngredient3 != nil {
                    list.append(Ingredient(name: strIngredient3!, measure: strMeasure3!))
                } else {
                    return list
                }
                if strIngredient4 != nil {
                    list.append(Ingredient(name: strIngredient4!, measure: strMeasure4!))
                } else {
                    return list
                }
                if strIngredient5 != nil {
                    list.append(Ingredient(name: strIngredient5!, measure: strMeasure5!))
                } else {
                    return list
                }
                if strIngredient6 != nil {
                    list.append(Ingredient(name: strIngredient6!, measure: strMeasure6!))
                } else {
                    return list
                }
                if strIngredient7 != nil {
                    list.append(Ingredient(name: strIngredient7!, measure: strMeasure7!))
                } else {
                    return list
                }
                if strIngredient8 != nil {
                    list.append(Ingredient(name: strIngredient8!, measure: strMeasure8!))
                } else {
                    return list
                }
                if strIngredient9 != nil {
                    list.append(Ingredient(name: strIngredient9!, measure: strMeasure9!))
                } else {
                    return list
                }
                if strIngredient10 != nil {
                    list.append(Ingredient(name: strIngredient10!, measure: strMeasure10!))
                } else {
                    return list
                }
                if strIngredient11 != nil {
                    list.append(Ingredient(name: strIngredient11!, measure: strMeasure11!))
                } else {
                    return list
                }
                if strIngredient12 != nil {
                    list.append(Ingredient(name: strIngredient12!, measure: strMeasure12!))
                } else {
                    return list
                }
                if strIngredient13 != nil {
                    list.append(Ingredient(name: strIngredient13!, measure: strMeasure13!))
                } else {
                    return list
                }
                if strIngredient14 != nil {
                    list.append(Ingredient(name: strIngredient14!, measure: strMeasure14!))
                } else {
                    return list
                }
                if strIngredient15 != nil {
                    list.append(Ingredient(name: strIngredient15!, measure: strMeasure15!))
                } else {
                    return list
                }
                return list
            }
        }
    }
    
    struct Ingredient {
        let name: String
        let measure: String
    }
}
