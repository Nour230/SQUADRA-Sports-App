//
//  FirstOnboardingViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 04/06/2025.
//

import UIKit

class FirstOnboardingViewController: UIViewController {

    @IBOutlet weak var chooseACategoryLabel: UILabel!
    @IBOutlet weak var firstDescriptionTxt: UITextView!
    @IBOutlet weak var squadraLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateAppearance()
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
            chooseACategoryLabel.textColor = UIColor.white
            firstDescriptionTxt.textColor = UIColor.white
            firstDescriptionTxt.backgroundColor = UIColor.black
            squadraLogo.image = UIImage(named: "SQUADRALogoWhite")
        } else {
            self.view.backgroundColor = UIColor.white
            chooseACategoryLabel.textColor = UIColor.black
            firstDescriptionTxt.textColor = UIColor.black
            firstDescriptionTxt.backgroundColor = UIColor.white
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
