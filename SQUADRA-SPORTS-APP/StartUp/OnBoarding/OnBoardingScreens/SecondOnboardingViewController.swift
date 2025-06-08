//
//  SecondOnboardingViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 04/06/2025.
//

import UIKit

class SecondOnboardingViewController: UIViewController {

    
    @IBOutlet weak var everythingAtAPlaceLabel: UILabel!
    @IBOutlet weak var secondDescriptionTxt: UITextView!
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
            everythingAtAPlaceLabel.textColor = UIColor.white
            secondDescriptionTxt.textColor = UIColor.white
            secondDescriptionTxt.backgroundColor = UIColor.black
            squadraLogo.image = UIImage(named: "SQUADRALogoWhite")
        } else {
            self.view.backgroundColor = UIColor.white
            everythingAtAPlaceLabel.textColor = UIColor.black
            secondDescriptionTxt.textColor = UIColor.black
            secondDescriptionTxt.backgroundColor = UIColor.white
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
