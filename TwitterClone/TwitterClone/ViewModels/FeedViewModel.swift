//
//  FeedViewModel.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/25/21.
//

import Foundation

struct FeedViewModel {
    var tweets: Observable<[Tweet]> = Observable([])
    
    func fetchTweets(){
        TweetAPI.shared.fetchTweets { tweets in
            self.tweets.value = tweets
        }
    }
}
