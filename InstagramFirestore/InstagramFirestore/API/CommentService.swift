//
//  CommentService.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/27/21.
//

import Firebase

struct CommentService {
    static func uploadComment(comment: String, postID: String, user: User, completion: @escaping(FirestoreCompletion)) {
        let data: [String: Any] = [
            "uid": user.uid,
            "comment": comment,
            "timestamp": Timestamp(date: Date()),
            "username": user.username,
            "profileImageUrl": user.profileImageUrl
        ]

        COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
    }

    static func fetchComments(forPost postID: String, completion: @escaping([Comment]) -> Void) {
        var comments = [Comment]()
        let query = COLLECTION_POSTS.document(postID).collection("comments").order(by: "timestamp", descending: true)

        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach {
                if $0.type == .added {
                    let data = $0.document.data()
                    let comment = Comment(dictionary: data)
                    comments.append(comment)
                }
            }
            
            completion(comments)
        }
    }
}
