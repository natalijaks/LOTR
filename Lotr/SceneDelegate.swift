//
//  SceneDelegate.swift
//  Lotr
//
//  Created by Natalija Krsnik on 27/05/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    /*let welcomeImg = UIImageView(image: UIImage(named: "lotr_eye"))
    let welcomeImgTitle = UIImageView(image: UIImage(named: "lotr_title"))
    var splashView = UIView()*/
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        //splash()
        guard let scene = (scene as? UIWindowScene) else { return }
        //splashView = UIView(frame: scene.coordinateSpace.bounds)
        
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
        
       // UILabel.appearance().font = UIFont(name: "Baskerville", size: 17)
        defaults.set(true, forKey: "isThemeGaussian")
    }

    func addCharactersVC() -> UINavigationController{
        let characters = CharactersVC()
        characters.title = "Characters"
        characters.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(named: "contacts_tab"), tag: 0)
       
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Baskerville", size: 15)]
        characters.tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        return UINavigationController(rootViewController: characters)
    }
    
    func addPlacesVC() -> UINavigationController {
        let places = PlacesVC()
        places.title = "Middle Earth"
        //places.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        places.tabBarItem = UITabBarItem(title: "Middle Earth", image: UIImage(named: "messages_tab"), tag: 0)
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Baskerville", size: 15)]
        places.tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        return UINavigationController(rootViewController: places)
        
    }
    
    func addSettingsVC() -> UINavigationController {
        let settings = SettingsVC()
        settings.title = "Settings"
        settings.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "messages_tab"), tag: 0)
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Baskerville", size: 15)]
        settings.tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        return UINavigationController(rootViewController: settings)
        
    }
    
    func addGamesVC() -> UINavigationController {
        let games = GamesVC()
        games.title = "Play"
        games.tabBarItem = UITabBarItem(title: "Play", image: UIImage(named: "sword"), tag: 0)
        let attributes = [NSAttributedString.Key.font:UIFont(name: "Baskerville", size: 15)]
        games.tabBarItem.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        return UINavigationController(rootViewController: games)
        
    }
    
   /* func addTasksVC() -> UINavigationController {
        let places = PlacesVC()
        places.title = "Tasks"
        places.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 2)
        return UINavigationController(rootViewController: places)
    }
    
    func addCallsVC() -> UINavigationController {
        let places = PlacesVC()
        places.title = "Calls"
        places.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 3)
      
        return UINavigationController(rootViewController: places)
    }
    
    func addSettingsVC() -> UINavigationController {
        let places = PlacesVC()
        places.title = "Messages"
        places.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 4)
        return UINavigationController(rootViewController: places)
    }*/
    
    func createTabbar() -> UITabBarController {
        //top of screen
        UINavigationBar.appearance().barTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 219/255, green: 186/255, blue: 76/255, alpha: 1)]
        UINavigationBar.appearance().isTranslucent = true
        
        //bottom of screen
        let tabbar = UITabBarController()
 
        UITabBar.appearance().tintColor = UIColor(red: 219/255, green: 186/255, blue: 76/255, alpha: 1)
        tabbar.tabBar.isTranslucent = true
        tabbar.tabBar.barTintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
    
        
        tabbar.viewControllers = [addCharactersVC(), addPlacesVC(), addGamesVC() ,addSettingsVC()]
        return tabbar
    }
    

    
   /* func splash(){
        // splash
        splashView.backgroundColor = UIColor(red: 219/255, green: 186/255, blue: 76/255, alpha: 1)
        window?.addSubview(splashView)
        welcomeImg.contentMode = .scaleAspectFit
        welcomeImgTitle.contentMode = .scaleAspectFill
        splashView.addSubview(welcomeImg)
        splashView.addSubview(welcomeImgTitle)
        
        welcomeImg.frame = CGRect(x: (splashView.frame.maxX / 2) - 50 , y: (splashView.frame.maxY / 2) - 50 , width: 100, height: 100)
        //welcomeImgTitle.frame = CGRect(x: 0 , y: splashView.frame.maxY - ((splashView.frame.maxY / 3) - 60) , width: splashView.bounds.width, height: 100)
        welcomeImgTitle.frame = CGRect(x: 0 , y: splashView.frame.maxY , width: splashView.bounds.width, height: 100)
    }*/
}


