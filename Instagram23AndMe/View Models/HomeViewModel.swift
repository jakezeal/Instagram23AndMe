//
//  HomeViewModel.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/28/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation

class HomeViewModel {
    var imagePosts: [ImagePost] = []
    
    func fetchRecentUserPhotos(completionHandler: @escaping ([ImagePost]) -> Void) {
        InstagramService.fetchRecentUserPhotos { (result) in
            switch result {
            case .success(let imagePosts):
                // TODO: completion handler or set it in view model here?
                completionHandler(imagePosts)
                
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
        }
    }
}
