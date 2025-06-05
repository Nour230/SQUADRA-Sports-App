//
//  SplashViewController.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 05/06/2025.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        animationView = .init(name: "SQUADRA")
        
        if let animationView = animationView {
            view.addSubview(animationView)
            
            animationView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                animationView.widthAnchor.constraint(equalToConstant: 400),
                animationView.heightAnchor.constraint(equalToConstant: 400),
                animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
                animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40)
            ])
            
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .repeat(4)
            animationView.animationSpeed = 0.7
            
            animationView.play { [weak self] finished in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self?.goToMainScreen()
                }
            }
        }
    }
    
    private func goToMainScreen() {
        let storyboard = UIStoryboard(name: "OnBoardingScreens", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "OnBarding")
        mainVC.modalTransitionStyle = .crossDissolve
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true)
    }
}
