//
//  FirebaseCollectionReferences.swift
//  LetsMeet
//
//  Created by Heang Ly on 11/4/21.
//

import FirebaseFirestore

enum FirebaseCollectionReference: String {
    case User
}

func firebaseReference(_ collectionReference: FirebaseCollectionReference) -> CollectionReference {
    return Firestore.firestore().collection(collectionReference.rawValue)
}

