//
//  TestTests.swift
//  TestTests
//
//  Created by Champ on 06/03/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import XCTest
@testable import Test

class TestTests: XCTestCase {

    var vc : CountryDetailsViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        vc = CountryDetailsViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testForAPI() {
        let url = URL(string : "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                XCTAssert(false)
            }
            
            guard let data = data else {
                XCTAssert(false)
                return
            }
            
            let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                XCTAssert(false)
                return
            }
            
            do {
                let _ = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                XCTAssert(true)
            } catch {
                XCTAssert(false)
            }
            }.resume()
    }


}
