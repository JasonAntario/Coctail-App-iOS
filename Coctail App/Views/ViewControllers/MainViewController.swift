//
//  ViewController.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 14.06.22.
//

import UIKit

class MainViewController: UITableViewController {

    let viewModel = ViewModel()
    
    var coctailsList = [CoctailsListDao.DrinkDao]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        
        viewModel.getCoctailsByFirstLetter("a")
        
        viewModel.coctailsListBind.bind { coctailsList in
            DispatchQueue.main.async {
                self.coctailsList = coctailsList
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ID.coctailCellID, for: indexPath) as! CoctailCell
        let item = coctailsList[indexPath.row]
        cell.coctailName.text = item.strDrink
        let imageUrl = URL(string: "\(item.strDrinkThumb)/preview")
        if let saveUrl = imageUrl {
            cell.coctailImage.load(url: saveUrl)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coctailsList.count
    }
    
    private func registerTableViewCell(){
        let textFieldCell = UINib(nibName: K.ID.coctailCellNib,bundle: nil)
        tableView.register(textFieldCell, forCellReuseIdentifier: K.ID.coctailCellID)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

    
        
