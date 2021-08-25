//
//  PostService.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/22/21.
//

import UIKit
import Firebase

struct PostService {
    static func uploadPost(caption: String, image: UIImage, user: User, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data: [String: Any] = [
                "caption": caption,
                "timestamp": Timestamp(date: Date()),
                "likes": 0,
                "imageUrl": imageUrl,
                "ownerUid": uid,
                "ownerUsername": user.username,
                "ownerImageUrl": user.profileImageUrl
            ]
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }

    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map { Post(postId: $0.documentID, dictionary: $0.data()) }
            completion(posts)
        }
    }

    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void) {
        let query = COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map { Post(postId: $0.documentID, dictionary: $0.data()) }
            completion(posts)
        }
    }
}
