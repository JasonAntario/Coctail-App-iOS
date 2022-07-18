//
//  DetailsViewController.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 18.07.22.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    
    var item: CoctailsListDao.DrinkDao? = nil
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var drinkLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.preferredContentSize = self.view.systemLayoutSizeFitting(
                UIView.layoutFittingCompressedSize
            )
    }
    
    override func viewDidLoad() {
        textView.text = ""
        if let saveItem = item {
            drinkLabel.text = saveItem.strDrink
            saveItem.ingredientsList.forEach { ingredient in
                appendLine("\(ingredient.name) - \(ingredient.measure)")
            }
            appendLine("\nHow to make: \n\(saveItem.strInstructions)")
        }
    }
    
    private func appendLine(_ content: String){
        textView.text.append("\(content) \n")
    }
}
