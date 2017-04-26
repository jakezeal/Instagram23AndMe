//
//  InstagramRouter.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/22/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation
import Alamofire

enum InstagramRouter: URLRequestConvertible {
    
    case fetchRecentUserPhotos(Bool)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .fetchRecentUserPhotos:
                return .get
            }
        }
        
        let params: ([String : Any]?) = {
            switch self {
            case .fetchRecentUserPhotos:
                return nil
            }
        }()
        
        let relativePath: String = {
            switch self {
            case .fetchRecentUserPhotos:
                return "users/self/media/recent/"

            }
        }()
        
        let url: URL = {
            var url = URL(string: APIManager.baseURLString)!
            url.appendPathComponent(relativePath, isDirectory: false)
            
            return url
        }()
        
        let encoding: ParameterEncoding = {
            switch self {
            case .fetchRecentUserPhotos:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return try encoding.encode(urlRequest, with: params)
    }
}

