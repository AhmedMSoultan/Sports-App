//
//  FavoriteTableViewCell.swift
//  Sports-App
//
//  Created by Ahmed Soultan on 03/03/2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    
    var youtubeURL:String?
    

    @IBAction func youtubeBtnAction(_ sender: Any) {
        
        if(youtubeURL! == ""){
                
            }else{
                let fullURL = "https://\(String(describing: youtubeURL!))"
                print(fullURL)
                if let url = URL(string: fullURL){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
             
    }
}
