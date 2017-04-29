//
//  HomeViewModel.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/28/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation

class HomeViewModel {
    // MARK: - Instance Vars
    var imagePosts: [ImagePost] = []
    
    // MARK: - Helpers
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
    
    func userLiked(imagePost: ImagePost, completionHandler: @escaping (String) -> Void) {
        if imagePost.userHasLiked {
            InstagramService.unlikePost(withMediaId: imagePost.mediaId, completionHandler: {
                completionHandler("Like")
                
            })
        } else {
            InstagramService.likePost(withMediaId: imagePost.mediaId, completionHandler: {
                completionHandler("Unlike")
            })
        }
    }
}
