//
//  ThirdOnboardingViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 04/06/2025.
//

import UIKit

class ThirdOnboardingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func navigateToSportsCategories(_ sender: Any) {
        let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarVC = MainStoryboard.instantiateViewController(withIdentifier: "Favourites") as? FavouritesTableViewController {
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true)
        }
    }
    
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    
}
