//
//  TweetAPI.swift
//  TwitterClone
//
//  Created by Heang Ly on 9/23/21.
//

import Firebase

struct TweetAPI {
    static let shared = TweetAPI()

    func uploadTweet(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let timestamp = Date().timeIntervalSince1970
        let values: [String: Any] = [
            "uid": uid,
            "timestamp": timestamp,
            "likes": 0,
            "retweet": 0,
            "caption": caption
        ]
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
    }
}
