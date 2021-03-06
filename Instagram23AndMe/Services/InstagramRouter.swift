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
    case searchPlace(Float, Float, String)
    case searchTag(String, String)
    
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .fetchRecentUserPhotos, .searchPlace, .searchTag:
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
            case .searchPlace(let latitude, let longitude, let token):
                return ["lat": latitude, "lng": longitude, "access_token": token]
            case .searchTag(let tagString, let token):
                return ["q": tagString, "access_token": token]
            }
        }()
        
        let relativePath: String = {
            switch self {
            case .fetchRecentUserPhotos:
                return "users/self/media/recent/"
            case .likePost(let mediaId, _), .unlikePost(let mediaId, _):
                return "/media/\(mediaId)/likes"
            case .searchPlace:
                return "media/search"
            case .searchTag:
                return "tags/search"
            }
        }()
        
        let url: URL = {
            var url = URL(string: APIManager.baseURLString)!
            url.appendPathComponent(relativePath, isDirectory: false)
            
            return url
        }()
        
        let encoding: ParameterEncoding = {
            switch self {
            case .fetchRecentUserPhotos, .likePost, .unlikePost, .searchPlace, .searchTag:
                return URLEncoding.queryString
            }
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return try encoding.encode(urlRequest, with: params)
    }
}

