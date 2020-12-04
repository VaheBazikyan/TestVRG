//
//  Neteorking.swift
//  TestVRGSoft
//
//  Created by Ваге Базикян on 01.12.2020.
//

//https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=PY4D272yOGLSA4y85cbkGFLj5ovE8sNc
//https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=PY4D272yOGLSA4y85cbkGFLj5ovE8sNc
//https://api.nytimes.com/svc/mostpopular/v2/shared/7.json?api-key=PY4D272yOGLSA4y85cbkGFLj5ovE8sNc


import Alamofire
import Foundation

enum Path {
    static let apiKey: String = {
        return "PY4D272yOGLSA4y85cbkGFLj5ovE8sNc"
    }()
    static let baseUrl = "https://api.nytimes.com/svc/mostpopular/v2"
    
    case emailed
    case viewed
    case shared
    
    var endPoint: URL {
        switch self {
        case .emailed:
            var urlComponents = URLComponents(string: Path.baseUrl.appending("/emailed/30.json"))
            urlComponents?.queryItems = [
                URLQueryItem(name: "api-key", value: Path.apiKey)
            ]
            return urlComponents!.url!
            
        case .shared:
            var urlComponents = URLComponents(string: Path.baseUrl.appending("/shared/30.json"))
            urlComponents?.queryItems = [
                URLQueryItem(name: "api-key", value: Path.apiKey)
            ]
            return urlComponents!.url!
        case .viewed:
            var urlComponents = URLComponents(string: Path.baseUrl.appending("/viewed/30.json"))
            urlComponents?.queryItems = [
                URLQueryItem(name: "api-key", value: Path.apiKey)
            ]
            return urlComponents!.url!
        }
    }
}

protocol APIClientProtocol {
    associatedtype M: Decodable
    func fetch(path: Path, completion: @escaping(M?, Error?) -> ())
}


struct APIClien<M: Decodable>: APIClientProtocol {
    
    func fetch(path: Path, completion: @escaping(M?, Error?) -> ()) {
        AF.request(path.endPoint, method: .get, parameters: nil)
            .responseDecodable(of: M.self, queue: .global(qos: .utility)) { (response) in
            
            switch response.result {
            case .success(let answer):
                DispatchQueue.main.async {
                    completion(answer, nil)
                }
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
