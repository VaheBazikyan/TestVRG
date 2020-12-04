//
//  Model.swift
//  TestVRGSoft
//
//  Created by Ваге Базикян on 01.12.2020.
//

import UIKit


struct AnotherResponse: Decodable {
    var x: String
}

struct ResponseModel: Decodable {
    var results : [ArticleResponce]
}


struct ArticleResponce: Decodable {
    var abstract: String
    var adx_keywords: String
    var asset_id: Int
    var byline: String
    var id: Int
    var media: [Media]
    
   
    
    struct Media: Decodable {
        
        var copyright: String
        var mediaData: [MediaData]
        
        struct MediaData: Decodable {
            var url: String
        }
        
        enum CodingKeys: String, CodingKey {
            case mediaData = "media-metadata"
            case copyright = "copyright"
        }
    }
    
    var source: String
    var title: String
    
    var updated: String
    var uri: String
    var url: String
}
