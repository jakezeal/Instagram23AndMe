//
//  SearchViewModel.swift
//  Instagram23AndMe
//
//  Created by Jake on 4/26/17.
//  Copyright © 2017 Jake. All rights reserved.
//

import Foundation

class SearchViewModel {

    // MARK: - Enums
    enum SearchMode {
        case places
        case tags
    }
    
    // MARK: - Instance Vars
    var filteredPosts: [ImagePost] = []
    
    var searchMode: SearchMode = .places
    
    // MARK: - Helpers
    func userLiked(imagePost: ImagePost, completionHandler: @escaping (String) -> Void) {
        if imagePost.userHasLiked {
            InstagramService.unlikePost(withMediaId: imagePost.mediaId, completionHandler: {
                imagePost.userHasLiked = !imagePost.userHasLiked
                completionHandler("Like")
                
            })
        } else {
            InstagramService.likePost(withMediaId: imagePost.mediaId, completionHandler: {
                imagePost.userHasLiked = !imagePost.userHasLiked
                completionHandler("Unlike")
            })
        }
    }
    
    // Search
    func searchPlace(withLatitude latitude: Float = 37.773972, longitude: Float = -122.431297, completionHandler: @escaping () -> Void) {
        InstagramService.searchPlace(withLatitude: latitude, longitude: longitude, completionHandler: { (filteredPosts) in
            guard let filteredPosts = filteredPosts.value else { return }
            self.filteredPosts = filteredPosts
            completionHandler()
        })
    }
    
    func searchTag(withTagString tagString: String = "snowy", completionHandler: @escaping () -> Void) {
        InstagramService.searchTag(withTagString: tagString, completionHandler: { (filteredPosts) in
            guard let filteredPosts = filteredPosts.value else { return }
            self.filteredPosts = filteredPosts
            completionHandler()
        })
    }
}
