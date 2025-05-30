//
//  NetworkService.swift
//  SQUADRA-SPORTS-APP
//
//  Created by nourhan essam on 31/05/2025.
//

import Foundation
import Alamofire
enum APIKeys {
    static let NourAPIKey = "02c36a40019a925e2e5f1ae5a9627cc5e4a1022b7b15fda424ae9297f90b87f3"
}
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
