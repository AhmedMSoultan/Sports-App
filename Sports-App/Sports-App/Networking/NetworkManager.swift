//
//  NetworkManager.swift
//  Sports-App
//
//  Created by Ahmed Soultan on 28/02/2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    func getSportsData() -> [Sports]{
        var sportsResult = [Sports]()
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php") else {return sportsResult}
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
            result in
                switch result.result{
                    case .failure(_):
                        print("Error")
                    case .success(_):
                        guard let data = result.data else {return}
                        let json = try! JSONDecoder().decode(Sport.self, from:data)
                        sportsResult = json.sports!
                }
            }
        return sportsResult
        }
    
    
//    func getSportsData(){
//        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php") else {return}
//        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
//            result in
//                switch result.result{
//                    case .failure(_):
//                        print("Error")
//
//                    case .success(_):
//                        guard let data = result.data else {return}
//                        let json = try! JSONDecoder().decode(Sport.self, from:data)
//                        sports = json.sports!
//                }
//            }
//        }
    
    
}
