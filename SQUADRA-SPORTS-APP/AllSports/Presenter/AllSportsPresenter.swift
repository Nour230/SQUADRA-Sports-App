//
//  AllSportsPresenter.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 30/05/2025.
//

import Foundation

class AllSportsPresenter {
    var allSportsViewController: AllSportsProtocol!
    var sportsCat: [AllSportsModel]!

    init(allSportsViewController: AllSportsProtocol!) {
        self.allSportsViewController = allSportsViewController
        
        // Create the list of 4 sports
        self.sportsCat = [
            AllSportsModel(name: "Football", img: "Football"),
            AllSportsModel(name: "Basketball", img: "Basketball"),
            AllSportsModel(name: "Tennis", img: "Tennis"),
            AllSportsModel(name: "Cricket", img: "Cricket")
        ]
    }

    func sendAllSportsCategories() {
        allSportsViewController.displaySports(sports: sportsCat)
    }
}
