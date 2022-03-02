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
    
    @IBAction func youtubeBtnAction(_ sender: Any) {
        let fullURL = "https://\(youtubeURL!)"
        print(fullURL)
        if let url = URL(string: fullURL){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    
}
