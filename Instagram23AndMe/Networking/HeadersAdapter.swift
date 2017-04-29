//
//  HeadersAdapter.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/28/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation
import Alamofire

class HeadersAdapter: RequestAdapter {
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("application/vnd.api+json", forHTTPHeaderField: Constants.HeaderFields.contentType)
        urlRequest.setValue("application/vnd.api+json", forHTTPHeaderField: Constants.HeaderFields.accept)
        
        if let token = KeychainHelper.shared.retrieveAccessToken() {
            urlRequest.setValue(token, forHTTPHeaderField: Constants.HeaderFields.authorization)
        }
        
        return urlRequest
    }
}


