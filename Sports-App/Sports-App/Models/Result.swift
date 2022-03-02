//
//  Result.swift
//  Sports-App
//
//  Created by Ahmed Soultan on 28/02/2022.
//

import Foundation

struct Result: Codable{
    
    var idEvent:String?
    var strEvent:String? //the names of team vs team
    var strFilename:String?
    var strLeague:String?
    var strSeason:String?
    
    var strHomeTeam:String?
    var strAwayTeam:String?
    var intHomeScore:String? //Home team result
    var intAwayScore:String? //Away team result
    
    var dateEvent:String?
    var strTime:String?
    
    var strVenue:String? // Match staduim
    var strThumb:String? // Event logo
    var strVideo:String? // Youtube Video
    var strStatus:String? //Finished or not
    
    // URL Results for Season 2021-2022
    //https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=4328&s=2021-2022
    
    enum CodingKeys: String, CodingKey {
        case idEvent
        case strEvent
        case strFilename
        case strLeague
        case strSeason
        case strHomeTeam
        case strAwayTeam
        case intHomeScore
        case intAwayScore
        case dateEvent
        case strTime
        case strVenue
        case strThumb
        case strVideo
        case strStatus
    }
}
