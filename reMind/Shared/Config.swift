//
//  Config.swift
//  FlashCards
//
//  Created by Pedro Sousa on 20/10/20.
//

import UIKit

class Config {

    private let homeController      = NewHomeViewController()
    private let termListController  = TermListViewController()

    public func mainController() -> UIViewController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .eerieBlack
        
        let boldWeight = UIImage.SymbolConfiguration(weight: .bold)

        let firstItemImageSymbol = UIImage(systemName: "rectangle.stack.fill", withConfiguration: boldWeight)
        homeController.tabBarItem = UITabBarItem(title: "Home", image: firstItemImageSymbol, tag: 0)
        let homeNav = generateBlurredNaviagationController(rootController: homeController)

        let secondItemImageSymbol = UIImage(systemName: "list.dash", withConfiguration: boldWeight)
        termListController.tabBarItem = UITabBarItem(title: "My Terms", image: secondItemImageSymbol, tag: 1)
        let wordNav = generateBlurredNaviagationController(rootController: termListController)
        
        tabBarController.viewControllers = [homeNav, wordNav]
        return tabBarController
    }

    private func generateBlurredNaviagationController(rootController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootController)
        nav.navigationBar.isTranslucent = true
        nav.navigationBar.tintColor = .eerieBlack
        return nav
    }

}
