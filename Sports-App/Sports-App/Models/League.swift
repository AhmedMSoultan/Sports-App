//
//  League.swift
//  Sports-App
//
//  Created by Ahmed Soultan on 24/02/2022.
//

import Foundation

struct League : Codable {
    let leagues : [Leagues]?

    enum CodingKeys: String, CodingKey {

        case leagues = "leagues"
    }
}

    
struct Leagues : Codable {
    let idLeague : String?
    let strLeague : String?
    let strBadge : String?
    let strPoster : String?
    let strYoutube : String?
    let strDescriptionEN : String?

    enum CodingKeys: String, CodingKey {

        case idLeague = "idLeague"
        case strLeague = "strLeague"
        case strBadge = "strBadge"
        case strPoster = "strPoster"
        case strYoutube = "strYoutube"
        case strDescriptionEN = "strDescriptionEN"
    }

}
