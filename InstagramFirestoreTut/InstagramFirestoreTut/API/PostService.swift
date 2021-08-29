//
//  PostService.swift
//  InstagramFirestoreTut
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

    static func fetchPost(completion: @escaping([Post]) -> Void) {
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
            var posts = documents.map { Post(postId: $0.documentID, dictionary: $0.data()) }
            posts.sort { $0.timestamp.seconds > $1.timestamp.seconds }
            completion(posts)
        }
    }

    static func likePost(post: Post, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_POSTS.document(post.postId).updateData(["likes": post.likes + 1])
        COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid).setData([:]) { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).setData([:], completion: completion)
        }
    }
    
    static func unlikePost(post: Post, completion: @escaping(FirestoreCompletion)){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_POSTS.document(post.postId).updateData(["likes": post.likes - 1])
        COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid).setData([:]) { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).delete(completion: completion)
        }    }
}
