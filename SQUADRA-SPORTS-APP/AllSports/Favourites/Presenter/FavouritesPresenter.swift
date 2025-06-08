//
//  FavouritesPresenter.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 03/06/2025.
//

import Foundation

class FavouritesPresenter{
    
    var favouritesTableVC : FavouritesProtocol
    var favouritesLeaguesArray : [CachedFavouritesModel] = []
    
    init(favouritesTableVC: FavouritesProtocol) {
        self.favouritesTableVC = favouritesTableVC
    }
    
    func getAllFavouritesFromDataBase(){
       favouritesLeaguesArray = LocalDataScource.getAllLeaguesFromDataBase()
        favouritesTableVC.displayAllFavouritesLeagues(result: favouritesLeaguesArray)
    }
    
    func deleteFavouriteLeagueFromDataBase(ID : Int){
         LocalDataScource.deleteLeagueFromDataBase(leagueID:  ID)
    }
}
