//
//  Constants.swift
//  InstagramFirestore
//
//  Created by Heang Ly on 8/15/21.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("user")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
