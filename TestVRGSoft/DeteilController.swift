//
//  DeteilController.swift
//  TestVRGSoft
//
//  Created by Ваге Базикян on 02.12.2020.
//

import UIKit

class DeteilController: UIViewController {
    
    var model: ArticleResponce?
    var media: ArticleResponce.Media?
    
    var favoriteController = FavoritController()
    
    //MARK:- Outlet
    @IBOutlet weak var urlLbl: UILabel!
    @IBOutlet weak var copyright: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var addToFavoritOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDetailInfo()
        isFavorite(CorDataWorker.instance.isContain(m: model))
    }
    
    private func configureDetailInfo() {
           urlLbl.text = model?.url
           titleLbl.text = model?.title
           copyright.text = media?.copyright
           idLbl.text = String(model!.id)
       }
    func isFavorite(_ isFavorite: Bool) {
        let title = isFavorite ? "Remove from favorites" : "Add to favorites"
        let backgroundColor: UIColor = isFavorite ? .red : .green
        addToFavoritOutlet.setTitle(title, for: .normal)
        addToFavoritOutlet.backgroundColor = backgroundColor
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func addFavoriteAction(_ sender: UIButton) {
        favoriteController.delegate?.updateFavorite(model)
        CorDataWorker.instance.updateFavorites(handler: { (addOrDelete) in
            self.isFavorite(addOrDelete)
        }, m: model)
    }
    
}
