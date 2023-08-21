//
//  SceneDelegate.swift
//  SmallWorldTest
//
//  Created by shairjeel ahmed on 20/08/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        launchInitialVC()
    }
    
    func launchInitialVC(){
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "ScreenNameViewController") as? ScreenNameViewController else {
            return
        }
        DispatchQueue.main.async {
            let viewModel: MoviesListViewModel = .moviesListViewModelBuilder
            vc.viewModel = viewModel
            let navCon = UINavigationController.init(rootViewController: vc)
            self.window?.rootViewController = navCon
        }
       
    }
}

