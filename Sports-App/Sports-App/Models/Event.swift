//
//  Event.swift
//  Sports-App
//
//  Created by Ahmed Soultan on 28/02/2022.
//

import Foundation

struct Event: Codable{
    
    var idEvent:String?
    var strEvent:String? //the names of team vs team
    var strFilename:String?
    var strLeague:String?
    var strSeason:String?

    var strHomeTeam:String?
    var strAwayTeam:String?

    var dateEvent:String?
    var strTime:String?

    var strVenue:String? // Match staduim
    var strThumb:String? // Event logo
    var strStatus:String? //Finished or not
    
    // URL Events by Round for 2021-2022 Season
    //https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=4328&r=38&s=2021-2022
    
    enum CodingKeys: String, CodingKey {
        case idEvent
        case strEvent
        case strFilename
        case strLeague
        case strSeason
        case strHomeTeam
        case strAwayTeam
        case dateEvent
        case strTime
        case strVenue
        case strThumb
        case strStatus
    }
}
