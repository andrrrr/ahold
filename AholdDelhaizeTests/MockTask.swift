//
//  MockTask.swift
//  AholdDelhaizeTests
//
//  Created by Andrei Nevar on 27/04/2020.
//  Copyright © 2020 Andrei Nevar. All rights reserved.
//

import Foundation

class MockTask: URLSessionDataTask {

    typealias Response = (data: Data?, URLResponse: URLResponse?, error: Error?)
    var mockResponse: Response
    let completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    init(response: Response, completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) {
        self.mockResponse = response
        self.completionHandler = completionHandler
    }

    override func resume() {
        completionHandler!(mockResponse.data, mockResponse.URLResponse, mockResponse.error)
    }
}
