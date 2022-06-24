//
//  ViewController.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 14.06.22.
//

import UIKit

class ViewController: UIViewController {

    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getCoctailsByFullName("Lemon Elderflower Spritzer")
        
        viewModel.coctailsListBind.bind { coctailsList in
            print(coctailsList.count)
        }
    }
}
