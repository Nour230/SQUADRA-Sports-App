//
//  TabBarViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 03/06/2025.
//

import UIKit

class TabBarViewController: UITabBarController , UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 0 {
            self.navigationItem.title = NSLocalizedString("AllSportsTitle", comment: "Title for sports categories tab")
        } else if tabBarController.selectedIndex == 1 {
            self.navigationItem.title = NSLocalizedString("FavouritesTitle", comment: "Title for favourites leagues tab")
        }
    }

}
