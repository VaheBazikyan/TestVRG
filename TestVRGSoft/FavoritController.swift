//
//  FavoritController.swift
//  TestVRGSoft
//
//  Created by Ваге Базикян on 03.12.2020.
//

import UIKit

protocol UpdateModel: class {
    func updateFavorite(_ model: ArticleResponce?)
}

class FavoritController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: UpdateModel?
    
    var favoritArray = [Articles]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritArray = FavoritesData.shared.favorites
    }
    
    
    
}
extension FavoritController: UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        let obj = favoritArray[indexPath.row]
        cell.textLabel?.text = obj.title
        
        return cell
    }
    
    
}

class FavoritesData {
    private init() {}
    static let shared = FavoritesData()
    var favorites: [Articles] {
        return CorDataWorker.instance.fetch()
    }
}

