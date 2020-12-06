//
//  ViewController.swift
//  TestVRGSoft
//
//  Created by Ваге Базикян on 01.12.2020.
//

import UIKit
import SafariServices



enum RequestType: Int {
    case emailed = 0
    case shared = 1
    case viewed = 2
}

class ViewController: UIViewController {
    
    //MARK:- Variable
    var pageNumber = 1
    var searchText = ""
    private var apiClient = APIClien<ResponseModel>()

    
    //MARK:- Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mostEmailed: UITabBarItem!
    @IBOutlet weak var mostShared: UITabBarItem!
    @IBOutlet weak var mostViewed: UITabBarItem!
    @IBOutlet weak var favorit: UIBarButtonItem!
    @IBOutlet weak var tabBar: UITabBar!
    
    
    
    var model: [ArticleResponce] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tabBar.delegate = self
        
    }
    
    func fetch(path: Path) {
        apiClient.fetch(path: path) { (data, error) in
            if let data = data {
                self.model = data.results
            }
        }
    }
    
    func showTutorial(_url: String) {
        guard let url = URL(string: _url) else {return}
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }
    
    
    //MARK:- Atrion
    @IBAction func favoritAction(_ sender: Any) {
        
    }
    
    @objc func handleEmaild() {
        
    }
    
    @objc func handleShared() {
        
    }
    
    @objc func handleViewed() {
        
    }
}

extension ViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case RequestType.emailed.rawValue:
            fetch(path: .emailed)
        case RequestType.shared.rawValue:
            fetch(path: .shared)
        case RequestType.viewed.rawValue:
            fetch(path: .viewed)
        default:
            break
        }
    }
}

//MARK:- Extension
extension ViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = model[indexPath.row]
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailVC") as? DeteilController else {return}
        controller.model = item
        present(controller, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model[indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

