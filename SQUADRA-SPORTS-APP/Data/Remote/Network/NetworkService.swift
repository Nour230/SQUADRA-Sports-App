//
//  NetworkService.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 31/05/2025.
//

import Foundation
import Alamofire

class NetworkService :NetworkServiceProtocol{
    
    static func getLeagues(sportName: String, handler: @escaping (LeaguesResponse)->Void) {
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=\(APIKeys.NourAPIKey)")
            .responseDecodable(of: LeaguesResponse.self) { response in
                switch response.result {
                case .success(let items):
                    handler(items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    static func getUpcomingLeagueDetails(sportName: String,leagueID:Int, handler: @escaping (UpcomingEventResponse)->Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDate = Date()
        let oneYearLater = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!
        
        let fromDate = dateFormatter.string(from: currentDate)
        let toDate = dateFormatter.string(from: oneYearLater)
        
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueID)&from=\(fromDate)&to=\(toDate)&APIkey=\(APIKeys.NourAPIKey)")
            .responseDecodable(of: UpcomingEventResponse.self) { response in
                switch response.result {
                case .success(let items):
                    handler(items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    static func getLatestResultsLeagueDetails(sportName: String,leagueID: Int, handler: @escaping (LatestResultsEventResponse)->Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDate = Date()
        let oneYearBefore = Calendar.current.date(byAdding: .year, value: -1, to: currentDate)!

        let fromDate = dateFormatter.string(from: oneYearBefore)
        let toDate = dateFormatter.string(from: currentDate)
        
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueID)&from=\(fromDate)&to=\(toDate)&APIkey=\(APIKeys.NourAPIKey)")
            .responseDecodable(of: LatestResultsEventResponse.self) { response in
                switch response.result {
                case .success(let items):
                    handler(items)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    
    static func getAllTeamsDetails(sportName: String,leagueID: Int, handler: @escaping (AllTeamsResponse)->Void) {
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?met=Teams&leagueId=\(leagueID)&APIkey=\(APIKeys.NourAPIKey)")
            .responseDecodable(of: AllTeamsResponse.self) { response in
                switch response.result {
                case .success(let items):
                    handler(items)
                    print(items.result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    static func getTennisPlayerbyLeagueID(leagueId: Int, handler: @escaping (TennisPlayerResponse)->Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDate = Date()
        let oneYearBefore = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!

        let fromDate = dateFormatter.string(from: oneYearBefore)
        let toDate = dateFormatter.string(from: currentDate)
        
        AF.request("https://apiv2.allsportsapi.com/tennis/?met=Fixtures&from=2024-05-31&to=2025-05-31&leagueId=\(leagueId)&APIkey=\(APIKeys.NourAPIKey)")
            .responseDecodable(of: TennisPlayerResponse.self) { response in
                switch response.result {
                case .success(let items):
                    handler(items)
                case .failure(let error):
                    print("error is : \(error.localizedDescription)")
                }
            }
    }
    
    

    
    static func getAllTennisPlayer(leagueId: Int, handler: @escaping (AllTennisPlayerResponse)->Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentDate = Date()
        let oneYearBefore = Calendar.current.date(byAdding: .year, value: 1, to: currentDate)!

        let fromDate = dateFormatter.string(from: oneYearBefore)
        let toDate = dateFormatter.string(from: currentDate)
        
        AF.request("https://apiv2.allsportsapi.com/tennis/?met=Players&from=\(fromDate)&to=\(toDate)&leagueId=\(leagueId)&APIkey=\(APIKeys.NourAPIKey)")
            .responseDecodable(of: AllTennisPlayerResponse.self) { response in
                switch response.result {
                case .success(let items):
                    handler(items)
                case .failure(let error):
                    print("tennis player error is : \(error.localizedDescription)")
                }
            }
    }
    
}
