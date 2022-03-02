//
//  Team.swift
//  Sports-App
//
//  Created by Ahmed Soultan on 28/02/2022.
//

import Foundation

struct Team: Codable{
    var idTeam:String?
    var strTeam:String?
    
    var strStadium:String?
    var strStadiumThumb:String? // staduim photo
    
    var strWebsite:String?
    var strFacebook:String?
    var strTwitter:String?
    var strInstagram:String?
    var strYoutube:String?
    
    var strTeamBadge:String? //Logo
    var strTeamLogo:String? //Title logo
    var strTeamJersey:String?
    var strTeamBanner:String?
    
    
    enum CodingKeys :String,CodingKey{
        case idTeam
        case strTeam
        case strStadium
        case strStadiumThumb
        case strWebsite
        case strFacebook
        case strTwitter
        case strInstagram
        case strYoutube
        case strTeamBadge
        case strTeamLogo
        case strTeamJersey
        case strTeamBanner
    }
}
