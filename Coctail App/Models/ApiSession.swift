//
//  UrlManager.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 24.06.22.
//

import Foundation

protocol ApiSessionDelegate{
    func didCoctailsListRecieved(coctailsList: CoctailsListDao)
}

class ApiSession {
    
    var apiSessionDelegate: ApiSessionDelegate?
    
    func getCoctailsByFirstLetter(_ letter: String){
        let url = URL(string: K.Request.urlGetCoctailsByFirstLetter+letter)
        if let saveUrl = url {
            let session = URLSession(configuration: .default)
            let request = URLRequest(url: saveUrl)
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil {
                    print("Error in getCoctailsByFirstLetter request: \(error!)")
                    return
                }
                if let saveData = data {
                    let coctailsList = self.parseJsonToCoctailsList(saveData)
                    if let savedList = coctailsList {
                        self.apiSessionDelegate?.didCoctailsListRecieved(coctailsList: savedList)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getCoctailsByFullName(_ name: String){
        let trimmingName = name.trimmingLeadingAndTrailingSpaces()
        let encodedName = trimmingName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        if encodedName == nil {
            return
        }
        let url = URL(string: K.Request.urlGetCoctailByFullName+encodedName!)
        if let saveUrl = url {
            let session = URLSession(configuration: .default)
            let request = URLRequest(url: saveUrl)
            let task = session.dataTask(with: request) { data, response, error in
                if error != nil {
                    print("Error in getCoctailsByFullName request: \(error!)")
                    return
                }
                if let saveData = data {
                    let coctailsList = self.parseJsonToCoctailsList(saveData)
                    if let savedList = coctailsList {
                        self.apiSessionDelegate?.didCoctailsListRecieved(coctailsList: savedList)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJsonToCoctailsList(_ data: Data) -> CoctailsListDao? {
        let decoder = JSONDecoder()
        do{
            let coctailsList = try decoder.decode(CoctailsListDao.self, from: data)
            return coctailsList
        } catch {
            print("Error in JSON decoding: \(error)")
            return nil
        }
    }
}

extension String {
    func trimmingLeadingAndTrailingSpaces(using characterSet: CharacterSet = .whitespacesAndNewlines) -> String {
        return trimmingCharacters(in: characterSet)
    }
}
