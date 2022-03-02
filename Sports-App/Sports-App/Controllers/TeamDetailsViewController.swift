//
//  TeamDetailsViewController.swift
//  Sports-App
//
//  Created by Ahmed Soultan on 23/02/2022.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var teamStadium: UIImageView!
    @IBOutlet weak var teamBadge: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamBanner: UIImageView!
    @IBOutlet weak var teamJersey: UIImageView!
    @IBOutlet weak var informedYearLabel: UILabel!
    @IBOutlet weak var teamDesc: UITextView!
    @IBOutlet weak var staduimLabel: UILabel!
    @IBOutlet weak var staduimDesc: UITextView!
    
    var selectedTeam = Team()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        teamBadge.sd_setImage(with: URL(string: selectedTeam.strTeamBadge ?? "liverpool_Badge"), placeholderImage: UIImage(named: "imageplaceholder"))
        teamStadium.sd_setImage(with: URL(string: selectedTeam.strStadiumThumb ?? "liverpool_Staduim"), placeholderImage: UIImage(named: "imageplaceholder"))
        teamBanner.sd_setImage(with: URL(string: selectedTeam.strTeamBanner ?? "liverpool_Banner"), placeholderImage: UIImage(named: "imageplaceholder"))
        teamJersey.sd_setImage(with: URL(string: selectedTeam.strTeamJersey ?? "liverpool_Jersey"), placeholderImage: UIImage(named: "imageplaceholder"))
        teamName.text = selectedTeam.strTeam
        
        informedYearLabel.text = selectedTeam.intFormedYear ?? ""
        teamDesc.text = selectedTeam.strDescriptionEN ?? ""
        staduimLabel.text = selectedTeam.strStadium ?? ""
        staduimDesc.text = selectedTeam.strStadiumDescription ?? ""
        
        // Do any additional setup after loading the view.
    }
    @IBAction func facebookBtnAction(_ sender: Any) {
        let fullURL = "https://\(selectedTeam.strFacebook!)"
        print(fullURL)
        if let url = URL(string: fullURL){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func instagramBtnAction(_ sender: Any) {
        let fullURL = "https://\(selectedTeam.strInstagram!)"
        print(fullURL)
        if let url = URL(string: fullURL){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func twitterBtnAction(_ sender: Any) {
        let fullURL = "https://\(selectedTeam.strTwitter!)"
        print(fullURL)
        if let url = URL(string: fullURL){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func websiteBtnAction(_ sender: Any) {
        let fullURL = "https://\(selectedTeam.strWebsite!)"
        print(fullURL)
        if let url = URL(string: fullURL){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
