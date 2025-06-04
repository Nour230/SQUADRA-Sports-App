//
//  ThirdOnboardingViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 04/06/2025.
//

import UIKit

class ThirdOnboardingViewController: UIViewController {
    
    @IBOutlet weak var justAClickLabel: UILabel!
    @IBOutlet weak var thirdDescriptionTxt: UITextView!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var squadraLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateAppearance()
    }
    
    @IBAction func navigateToSportsCategories(_ sender: Any) {
        let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarVC = MainStoryboard.instantiateViewController(withIdentifier: "MainNavigation") as? MainNavigationViewController {
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateAppearance()
        }
    }
    
    private func updateAppearance() {
        if traitCollection.userInterfaceStyle == .dark {
            self.view.backgroundColor = UIColor.black
            justAClickLabel.textColor = UIColor.white
            thirdDescriptionTxt.textColor = UIColor.white
            thirdDescriptionTxt.backgroundColor = UIColor.black
            getStartedButton.tintColor = UIColor.black
            getStartedButton.backgroundColor = UIColor.white
            squadraLogo.image = UIImage(named: "SQUADRALogoWhite")
        } else {
            self.view.backgroundColor = UIColor.white
            justAClickLabel.textColor = UIColor.black
            thirdDescriptionTxt.textColor = UIColor.black
            thirdDescriptionTxt.backgroundColor = UIColor.white
            getStartedButton.tintColor = UIColor.white
            getStartedButton.backgroundColor = UIColor.black
            squadraLogo.image = UIImage(named: "SQUADRALogo")
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
