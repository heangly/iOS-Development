//
//  SceneDelegate.swift
//  Checklists
//
//  Created by Heang Ly on 7/11/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let dataModel = DataModel()


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        let navigationsController = window!.rootViewController as! UINavigationController
        let controller = navigationsController.viewControllers[0] as! AllListsViewController
        controller.dataModel = dataModelq
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        saveData()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        saveData()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    //MARK: - Helper Methods
    func saveData() {
        dataModel.saveChecklists()
    }


}

