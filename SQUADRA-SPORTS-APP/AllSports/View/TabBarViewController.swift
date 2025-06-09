//
//  TabBarViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 03/06/2025.
//

import UIKit
import AVFoundation

class TabBarViewController: UITabBarController , UITabBarControllerDelegate {
    
   
    @IBOutlet weak var soundImage: UIButton!
    
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        updateSoundIconColor()
    }
    
    

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 0 {
            self.navigationItem.title = NSLocalizedString("AllSportsTitle", comment: "Title for sports categories tab")
        } else if tabBarController.selectedIndex == 1 {
            self.navigationItem.title = NSLocalizedString("FavouritesTitle", comment: "Title for favourites leagues tab")
        }
    }

    @IBAction func playAndStopSound(_ sender: Any) {
        if let navController = self.navigationController as? MainNavigationViewController {
            let isPlayed = navController.isPlayed ?? false
            let tabplayer = navController.navPlayer
            print("isPlayed = \(isPlayed)")
            
            if isPlayed {
                navController.isPlayed = false
                if let player = tabplayer {
                    player.pause()
                } else {
                    print("Player is nil — nothing to pause.")
                }
            } else {
                if let player = player, player.isPlaying {
                    player.pause()
                } else {
                    playSoundTrack(sender as! UIButton)
                }
            }
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
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateSoundIconColor()
        }
    }

    func updateSoundIconColor() {
        let isDarkMode = traitCollection.userInterfaceStyle == .dark
        let imageName = isDarkMode ? "Sound-White" : "Sound-Black"

        if let image = UIImage(named: imageName) {
            soundImage.setImage(image, for: .normal)
            soundImage.tintColor = nil
        }
    }


}
