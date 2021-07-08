//
//  NewsAppTests.swift
//  NewsAppTests
//
//  Created by Bedirhan Turhan on 6/16/21.
//

import XCTest
@testable import NewsApp

class NewsAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParsing() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let bundle = Bundle(for: NewsAppTests.self)
        let url = bundle.url(forResource: "news", withExtension: "json")!
        //yukarda throws kullanmistik hatirla burda try ile isi bitirdik yukardaki throws sayesinbde herhangi bi failde falan test target crash olacak
        let data = try Data(contentsOf: url)
        let decoder = Decoders.plainDateDecoder
        let news = try decoder.decode(SourceStatus.self, from: data)
        print(news)
        
        XCTAssertEqual(news.articles[0].author, "Jared Blikre")
    }
    
}


