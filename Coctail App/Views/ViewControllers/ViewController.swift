//
//  ViewController.swift
//  Coctail App
//
//  Created by Dmitry Sankovsky on 14.06.22.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBarView: UISearchBar!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    private let viewModel = ViewModel()
    
    var coctailsList = [CoctailsListDao.DrinkDao]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.dataSource = self
        mainTableView.keyboardDismissMode = .onDrag
        registerTableViewCell()
        binding()
    }
    
    private func binding(){
        searchBarView.searchTextField.textPublisher
            .assign(to: \.inputString, on: viewModel)
            .store(in: &cancellable)
        
        viewModel.$outputCoctailsDao
            .sink { [weak self] result in
                self?.coctailsList = result.drinks ?? []
                self?.mainTableView.reloadData()
                if let list = self?.coctailsList {
                    if list.isEmpty {
                        self?.messageLabel.isHidden = false
                        self?.messageLabel.text = "No drinks founded"
                    } else {
                        self?.messageLabel.isHidden = true
                    }
                }
            }.store(in: &cancellable)
    }
    
    private var cancellable = Set<AnyCancellable>()
    
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

extension UISearchTextField {
    var textPublisher: AnyPublisher<String, Never>{
        NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification, object: self)
            .compactMap { $0.object as? UISearchTextField }
            .map{ $0.text ?? ""}
            .eraseToAnyPublisher()
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
