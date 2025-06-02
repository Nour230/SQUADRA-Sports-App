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
    
    func insertLeagueToDataBase(league: LeagueModel) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "CashedFavourites", in: context) else { return }
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(league.leagueName, forKey: "leagueName")
        managedObject.setValue(league.leagueLogo, forKey: "leagueLogo")
        managedObject.setValue(league.leagueID, forKey: "leagueID")
        managedObject.setValue(league.countryName, forKey: "countryName")
        managedObject.setValue(league.countryLogo, forKey: "countryLogo")
        do {
            try context.save()
            print("Favorite status updated to saved")
            
        } catch {
            print("Failed to update favorite status: \(error)")
        }
    }
    
    
    func deleteLeagueFromDataBase(leagueid: Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Fav")
        fetchRequest.predicate = NSPredicate(format: "leagueid == %d", leagueid)
        do{
            let res = try managedContext.fetch(fetchRequest)
            if let result = res.first{
                managedContext.delete(result)
                print("league deleted from DataBase")
            }
            else{
                print("No Saved League with this ID")
            }
           
        }catch {
            print("Fetch error: \(error.localizedDescription)")
        }
    }
    
   
    func getLeagueByID(leagueID: Int) ->Bool{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Fav")
        fetchRequest.predicate = NSPredicate(format: "leagueid == %d", leagueID)
        do{
            let res = try managedContext.fetch(fetchRequest)
            if let result = res.first{
                return true
                print("league found in DataBase")
            }
            else{
                return false
                print("No Saved League with this ID")
            }
           
        }catch {
            return false
            print("Fetch error: \(error.localizedDescription)")
        }
    }
    
    func getAllLeaguesFromDataBase() {
        <#code#>
    }
}

