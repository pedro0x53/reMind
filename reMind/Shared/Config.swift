//
//  Config.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit

class Config {

    private let homeController      = HomeViewController()
    private let reviewController    = Default404ViewController()
    private let settingsController  = Default404ViewController()

    public func mainController() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .eerieBlack
        
        let boldWeight = UIImage.SymbolConfiguration(weight: .bold)

        let firstItemImageSymbol = UIImage(systemName: "rectangle.stack.fill", withConfiguration: boldWeight)
        homeController.tabBarItem = UITabBarItem(title: "Home", image: firstItemImageSymbol, tag: 0)
        let homeNav = generateBlurredNaviagationController(rootController: homeController)

        let secondItemImageSymbol = UIImage(systemName: "arrow.triangle.2.circlepath", withConfiguration: boldWeight)
        reviewController.tabBarItem = UITabBarItem(title: "Review", image: secondItemImageSymbol, tag: 1)
        let reviewNav = generateBlurredNaviagationController(rootController: reviewController)
        
        let thirdItemImageSymbol = UIImage(systemName: "gear", withConfiguration: boldWeight)
        settingsController.tabBarItem = UITabBarItem(title: "Settings", image: thirdItemImageSymbol, tag: 2)
        let settingsNav = generateBlurredNaviagationController(rootController: settingsController)
        
        tabBarController.viewControllers = [homeNav, reviewNav, settingsNav]
        return tabBarController
    }

    private func generateBlurredNaviagationController(rootController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootController)
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.setBackgroundImage(UIImage(), for: .default)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.backgroundColor = .clear
        nav.navigationBar.tintColor = .eerieBlack
        return nav
    }

}
