//
//  SceneDelegate.swift
//  PixabayAPI
//
//  Created by Andras Pal on 12/08/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(frame: windowScene.coordinateSpace.bounds)
    window?.windowScene = windowScene
    window?.makeKeyAndVisible()
    window?.rootViewController = PixabaySearchNavigationController(rootViewController: SearchViewController())
  }
}

