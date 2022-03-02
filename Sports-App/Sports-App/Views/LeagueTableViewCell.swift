//
//  LeagueTableViewCell.swift
//  Sports-App
//
//  Created by Ahmed Soultan on 25/02/2022.
//

import UIKit


class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueLabel: UILabel!
    var youtubeURL:String?
    var selectedLeague : Leagues?
    
    @IBAction func youtubeBtnAction(_ sender: Any) {
        
        if(selectedLeague!.strYoutube! == ""){
            
        }else{
            let fullURL = "https://\(String(describing: selectedLeague!.strYoutube!))"
            print(fullURL)
            if let url = URL(string: fullURL){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
         
    }
    
}
