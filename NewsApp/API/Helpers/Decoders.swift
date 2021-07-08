//
//  Decoders.swift
//  NewsApp
//
//  Created by Bedirhan Turhan on 6/16/21.
//

//"2021-06-16T10:21:32Z"

import Foundation

public enum Decoders {
    static let plainDateDecoder : JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
