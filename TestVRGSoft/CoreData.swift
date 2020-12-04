//
//  CoreData.swift
//  TestVRGSoft
//
//  Created by Ваге Базикян on 03.12.2020.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContiner:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestVRGSoft")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error{
                fatalError("Loading of stroe Failed with \(error)")
            }
        }
        return container
    }()
    
}

class CorDataWorker {
    private init() {}
    static let instance = CorDataWorker()
    private let context = CoreDataManager.shared.persistentContiner.viewContext
    var favoriteDidRemoved: () -> () = {}
    
    func fetch() -> [Articles]{
        let fetchRequset = NSFetchRequest<Articles>(entityName: "Articles")
        do{
            let favorite = try context.fetch(fetchRequset)
            return favorite
            
        } catch let fetchErr{
            print("failed, when tried to fetch \(fetchErr)")
        }
        
        return []
    }
    
    func updateFavorites(handler: @escaping(Bool) -> (), m: ArticleResponce?){
        isContain(m: m) ? delete(handler: { (bool) in handler(bool)}, m: m) : save(handler: { (bool) in handler(bool)}, m)
    }
    
    private func save(handler: @escaping(Bool) -> (), _ m: ArticleResponce?) {
        let articles = NSEntityDescription.insertNewObject(forEntityName: "Articles", into: context) as! Articles
        
        articles.setValue(m?.title, forKey: "title")
        articles.setValue(m?.url, forKey: "url")
        articles.setValue(m?.media[0].copyright, forKey: "copyright")
        articles.setValue(m?.id, forKey: "id")
        do{
            try context.save()
            handler(true)
        } catch let saveIncErr {
            print("Failed to save \(saveIncErr)")
        }
    }
    
    func isContain(m: ArticleResponce?) -> Bool {
        return self.fetch().map({Int($0.id)}).contains(m?.id)
    }
    
    private func delete(handler: @escaping(Bool) -> (), m: ArticleResponce?) {
        guard self.fetch().map({Int($0.id)}).contains(m?.id) else { return }
        self.fetch().filter({Int($0.id) == m?.id}).forEach { (obj) in
            self.context.delete(obj)
            do{
                try context.save()
                self.favoriteDidRemoved()
                handler(false)
            } catch let saveIncErr {
                print("Failed to delete \(saveIncErr)")
            }
        }
        
    }
}
