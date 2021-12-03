//
//  Tweet.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/25/21.
//

import Foundation

struct Tweet {
    let caption: String
    let tweetID: String
    let uid: String
    let likes: Int
    let timestamp: Date
    let retweetCount: Int

    init(tweetID: String, dictionary: [String: Any]) {
        self.tweetID = tweetID
        self.caption = dictionary["caption"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        } else {
            self.timestamp = Date()
        }
        self.retweetCount = dictionary["retweets"] as? Int ?? 0
    }
}
