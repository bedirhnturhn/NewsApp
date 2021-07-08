//
//  TopNewsObject.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/16/21.
//

import Foundation

struct NewsObject : Decodable {
    private enum RootCodingKeys : String , CodingKey {
        case articles
    }
    
    let result : [News]
    
    init(from decoder: Decoder) throws {
        //eger ic ice olsaydi yani daha ck gitmen gerekseydi
        //feedContainer = try rootcontainer.nestedContainer(keyB
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        self.result = try rootContainer.decode([News].self, forKey: .articles)
    }
}


