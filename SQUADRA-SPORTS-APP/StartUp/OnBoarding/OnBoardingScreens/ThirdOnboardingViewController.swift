//
//  ThirdOnboardingViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 04/06/2025.
//

import UIKit
import AVFoundation

class ThirdOnboardingViewController: UIViewController {
    
    @IBOutlet weak var justAClickLabel: UILabel!
    @IBOutlet weak var thirdDescriptionTxt: UITextView!
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var squadraLogo: UIImageView!
    @IBOutlet weak var playSoundButton: UIButton!
    
    var player: AVAudioPlayer!
    
    var isPlaying : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        updateAppearance()
    }
    
    @IBAction func navigateToSportsCategories(_ sender: Any) {
        let MainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let tabBarVC = MainStoryboard.instantiateViewController(withIdentifier: "MainNavigation") as? MainNavigationViewController {
            tabBarVC.modalPresentationStyle = .fullScreen
            tabBarVC.isPlayed = self.isPlaying
            tabBarVC.navPlayer = player
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
            playSoundButton.tintColor = UIColor.white
            let soundImage = UIImage(named: "Sound-White")?.withRenderingMode(.alwaysTemplate)
            playSoundButton.setImage(soundImage, for: .normal)
            playSoundButton.tintColor = UIColor.white
        } else {
            self.view.backgroundColor = UIColor.white
            justAClickLabel.textColor = UIColor.black
            thirdDescriptionTxt.textColor = UIColor.black
            thirdDescriptionTxt.backgroundColor = UIColor.white
            getStartedButton.tintColor = UIColor.white
            getStartedButton.backgroundColor = UIColor.black
            squadraLogo.image = UIImage(named: "SQUADRALogo")
            playSoundButton.tintColor = UIColor.black
            let soundImage = UIImage(named: "Sound-White")?.withRenderingMode(.alwaysTemplate)
            playSoundButton.setImage(soundImage, for: .normal)
            playSoundButton.tintColor = UIColor.black
        }
    }
    
    @IBAction func playSound(_ sender: Any) {
        if let player = player, player.isPlaying {
            player.pause()
            self.isPlaying = false
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
            ]
            let attributedTitle = NSAttributedString(string: "   Play Sound", attributes: attributes)
            playSoundButton.setAttributedTitle(attributedTitle, for: .normal)
        } else {
            playSoundTrack(sender as! UIButton)
            self.isPlaying = true
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
            ]
            let attributedTitle = NSAttributedString(string: "   Pause Sound", attributes: attributes)
            playSoundButton.setAttributedTitle(attributedTitle, for: .normal)
        }
    }

    
    func playSoundTrack(_ sender: UIButton) {
        if player == nil {
            guard let url = Bundle.main.url(forResource: "SquadraTrack", withExtension: "mp3") else { return }
            do {
                player = try AVAudioPlayer(contentsOf: url)
            } catch {
                print("Error initializing sound: \(error)")
                return
            }
        }
        player?.play()
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
