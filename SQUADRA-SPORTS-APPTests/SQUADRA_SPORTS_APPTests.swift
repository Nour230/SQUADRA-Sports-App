//
//  SQUADRA_SPORTS_APPTests.swift
//  SQUADRA-SPORTS-APPTests
//
//  Created by nourhan essam on 30/05/2025.
//

import XCTest
@testable import SQUADRA_SPORTS_APP
var network :NetworkServiceProtocol!

final class SQUADRA_SPORTS_APPTests: XCTestCase {

    override func setUpWithError() throws {
        network = NetworkService()
    }

    override func tearDownWithError() throws {
        network = nil
    }

    func testGetAllTennisPlayer(){
        let exp = expectation(description: "Waiting for responce ")
        NetworkService.getAllTennisPlayer{ tennisPlayer in
            
            if (!tennisPlayer.result.isEmpty){
                XCTAssert(tennisPlayer.result.count == 974)
            }
            else{
                XCTFail()
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 15)
    }
    

    func testGetTennisPlayerbyLeagueID(){
        let exp = expectation(description: "Waiting for responce ")
        NetworkService.getTennisPlayerbyLeagueID(leagueId: 3173){ tennisPlayer in
            if (!tennisPlayer.result.isEmpty){
                var name = tennisPlayer.result.first?.eventFirstPlayer
                XCTAssertEqual(name , "Europe","Europe isn't the name")
            }
            else{
                XCTFail()
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 15)
    }
    
    func testGetAllTeamsDetails(){
        let exp = expectation(description: "Waiting for responce ")
        NetworkService.getAllTeamsDetails(sportName: "football", leagueID: 4){teams in
            if (!teams.result.isEmpty){
                XCTAssertNotNil(teams)
            }
            else{
                XCTFail()
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 15)
    }
    
    
    func testGetLatestResultsLeagueDetails(){
        let exp = expectation(description: "Waiting for responce ")
        NetworkService.getLatestResultsLeagueDetails(sportName: "football", leagueID: 1){latestEvent in
            
            if(!latestEvent.result.isEmpty){
                let name = latestEvent.result.first?.homeTeamName
                XCTAssertTrue(name == "Spain")
            }
            else{
                XCTFail()
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 15)
    }
    
    func testGetUpcomingLeagueDetails(){
        let exp = expectation(description: "Waiting for responce ")
        NetworkService.getUpcomingLeagueDetails(sportName: "football", leagueID: 4){latestEvent in
            if(!latestEvent.result.isEmpty){
                let name = latestEvent.result.first?.eventAwayTeam
                XCTAssertFalse(name == "Spain")
            }
            else{
                XCTFail()
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 55)
    }
    
    func testGetLeagues(){
        let exp = expectation(description: "Waiting for responce ")
        NetworkService.getLeagues(sportName: "football"){league in
            if (!league.result.isEmpty){
                XCTAssertNotNil(league)
            }
            else{
                XCTFail()
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 15)
    }
    
}
