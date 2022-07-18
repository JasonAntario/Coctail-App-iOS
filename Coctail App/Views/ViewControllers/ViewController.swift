//
//  ViewController.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 14.06.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    let viewModel = ViewModel()
    
    var coctailsList = [CoctailsListDao.DrinkDao]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.keyboardDismissMode = .onDrag
        registerTableViewCell()
        
        viewModel.coctailsListBind.bind { coctailsList in
            self.coctailsList = coctailsList
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
                if coctailsList.isEmpty {
                    self.messageLabel.isHidden = false
                    self.messageLabel.text = "No drinks founded"
                } else {
                    self.messageLabel.isHidden = true
                }
            }
        }
    }
    
    private func registerTableViewCell(){
        let textFieldCell = UINib(nibName: K.ID.coctailCellNib,bundle: nil)
        mainTableView.register(textFieldCell, forCellReuseIdentifier: K.ID.coctailCellID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.ID.coctailShowDetailsID {
            let controller = segue.destination as! DetailsViewController
            controller.item = coctailsList[(mainTableView.indexPathForSelectedRow?.row)!]
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ID.coctailCellID, for: indexPath) as! CoctailCell
        let item = coctailsList[indexPath.row]
        cell.coctailName.text = item.strDrink
        let imageUrl = URL(string: "\(item.strDrinkThumb)/preview")
        if let saveUrl = imageUrl {
            cell.coctailImage.load(url: saveUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coctailsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.ID.coctailShowDetailsID, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.delegate = self
        let coctailName = searchBar.text
        if let saveCoctailName = coctailName{
            viewModel.searchCoctails(saveCoctailName)
        }
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
