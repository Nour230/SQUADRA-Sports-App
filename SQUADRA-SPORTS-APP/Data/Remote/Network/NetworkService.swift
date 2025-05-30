//
//  NetworkService.swift
//  SQUADRA-SPORTS-APP
//
//  Created by Adham Mohamed on 30/05/2025.
//

import Foundation
import Alamofire

class NetworkService {
    static func getLeagues(sportName: String, handler: @escaping (LeaguesResponse)->Void) {
        AF.request("https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=\(APIKeys.NourAPIKey)")
            .responseDecodable(of: LeaguesResponse.self) { response in
                switch response.result {
                case .success(let items):
                    handler(items)
                    print(items.result.count)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
