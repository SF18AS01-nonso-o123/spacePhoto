//
//  photoInfo.swift
//  spacePhoto
//
//  Created by Chinonso Obidike on 3/19/19.
//  Copyright © 2019 Chinonso Obidike. All rights reserved.
//

import Foundation
struct PhotoInfo: Codable {
    var title: String
    var description: String
    var url: URL
    var copyright: String?
    var mediaType: String
    
    enum Keys: String, CodingKey {
        case title
        case description = "explanation"
        case url
        case copyright
        case mediaType = "media_type"
    }
    
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: Keys.self)
        title = try valueContainer.decode(String.self, forKey: Keys.description)
        description = try valueContainer.decode(String.self, forKey: Keys.url)
        url = try valueContainer.decode(URL.self, forKey: Keys.url)
        copyright = try? valueContainer.decode(String.self, forKey: Keys.copyright)
        mediaType = try valueContainer.decode(String.self, forKey: Keys.mediaType)
        
    }
}
