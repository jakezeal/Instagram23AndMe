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
    
    case fetchRecentUserPhotos(String)
    case likePost(String, String)
    case unlikePost(String, String)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .fetchRecentUserPhotos:
                return .get
            case .likePost:
                return .post
            case .unlikePost:
                return .delete
            }
        }
        
        let params: ([String : Any]?) = {
            switch self {
            case .fetchRecentUserPhotos(let token), .likePost(_, let token), .unlikePost(_, let token):
                return ["access_token": token]
            }
        }()
        
        let relativePath: String = {
            switch self {
            case .fetchRecentUserPhotos:
                return "users/self/media/recent/"
            case .likePost(let mediaId, _), .unlikePost(let mediaId, _):
                return "/media/\(mediaId)/likes"
            }
        }()
        
        let url: URL = {
            var url = URL(string: APIManager.baseURLString)!
            url.appendPathComponent(relativePath, isDirectory: false)
            
            return url
        }()
        
        let encoding: ParameterEncoding = {
            switch self {
            case .fetchRecentUserPhotos, .likePost, .unlikePost:
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

