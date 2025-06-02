//
//  LocalDataSource.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 02/06/2025.
//

import Foundation
import CoreData
import UIKit

class LocalDataScource : LocalDataSourceProtocol{
    
    static func insertLeagueToDataBase(league: LeagueModel , sportName:String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "CashedFavourites", in: context) else { return }
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(league.leagueName, forKey: "leagueName")
        managedObject.setValue(league.leagueLogo, forKey: "leagueLogo")
        managedObject.setValue(league.leagueID, forKey: "leagueID")
        managedObject.setValue(league.countryName, forKey: "countryName")
        managedObject.setValue(league.countryLogo, forKey: "countryLogo")
        managedObject.setValue(sportName, forKey: "sportName")
        do {
            try context.save()
            print("Favorite status updated to saved")
            
        } catch {
            print("Failed to update favorite status: \(error)")
        }
    }
    
    
    static func deleteLeagueFromDataBase(leagueID: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CashedFavourites")
        fetchRequest.predicate = NSPredicate(format: "leagueID == %d", leagueID)
        do{
            let res = try managedContext.fetch(fetchRequest)
            if let result = res.first{
                managedContext.delete(result)
                print("League deleted from DataBase")
                try managedContext.save()
            }
            else{
                print("No Saved League with this ID")
            }
           
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }
    }
    
   
    static func getLeagueByID(leagueID: Int) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CashedFavourites")
        fetchRequest.predicate = NSPredicate(format: "leagueID == %d", leagueID)
        fetchRequest.fetchLimit = 1 // Optimization

        do {
            let result = try managedContext.fetch(fetchRequest)
            return result.first != nil
        } catch {
            print("Fetch error: \(error)")
            return false
        }
    }

    
    static func getAllLeaguesFromDataBase() -> [CachedFavouritesModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CashedFavourites")
        
        var favouriteLeagues: [CachedFavouritesModel] = []
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            for item in results {
                let league = LeagueModel(
                    leagueName: item.value(forKey: "leagueName") as? String ?? " ",
                    leagueLogo: item.value(forKey: "leagueLogo") as? String,
                    countryName: item.value(forKey: "countryName") as? String,
                    countryLogo: item.value(forKey: "countryLogo") as? String,
                    leagueID: item.value(forKey: "leagueID") as? Int
                )
                let favouriteLeagueObject = CachedFavouritesModel(
                    leagueModel: league ,
                    sportName:item.value(forKey: "sportName") as? String
                )
                favouriteLeagues.append(favouriteLeagueObject)
            }
        } catch {
            print("Failed to fetch favorite status: \(error)")
        }
        return favouriteLeagues
    }
}

