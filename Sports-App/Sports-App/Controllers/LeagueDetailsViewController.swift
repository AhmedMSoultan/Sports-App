//
//  LeagueDetailsViewController.swift
//  Sports-App
//
//  Created by Ahmed Soultan on 23/02/2022.
//

import UIKit
import CloudKit
import Alamofire
import FavoriteButton

class LeagueDetailsViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    var selectedLeague:Leagues = Leagues(idLeague: "", strLeague: "", strBadge: "", strPoster: "", strYoutube: "", strDescriptionEN: "")
    var leagueName:String?
    var upComingEvents = [Event]()
    var results = [Result]()
    var teams = [Team]()
    var selectedTeam = Team()
    var selectedClass: [String : [Event]]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var eventsCollection: UICollectionView!
    @IBOutlet weak var resultsCollection: UICollectionView!
    @IBOutlet weak var teamsCollection: UICollectionView!
//    @IBOutlet weak var favBtn: FavoriteButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = selectedLeague.strLeague
        self.getUpcomingEvents()
        self.getResults()
        self.getTeams()
//        favBtn.delegate = self
        
        
//        print(selectedLeague.strLeague)
        // Do any additional setup after loading the view.
//        eventsCollection.register(UINib(nibName: "UpComingCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "upComingCell")
    }
    
    @IBAction func favBtnAction(_ sender: Any) {
        saveData()
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == eventsCollection){
            return upComingEvents.count
        }else if (collectionView == resultsCollection){
            return results.count
        }else if (collectionView == teamsCollection){
            return teams.count
        }else{
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        if(collectionView == eventsCollection){
            let eventCell = eventsCollection.dequeueReusableCell(withReuseIdentifier: "upComingEventCell", for: indexPath) as! EventCollectionViewCell
            eventCell.eventImage.sd_setImage(with: URL(string: upComingEvents[indexPath.row].strThumb ?? "imageplaceholder"), placeholderImage: UIImage(named: "imageplaceholder"))
            eventCell.eventImage.layer.cornerRadius = 15
            return eventCell
        }else if (collectionView == resultsCollection){
            let resultCell = resultsCollection.dequeueReusableCell(withReuseIdentifier: "resultCell", for: indexPath) as! ResultCollectionViewCell
            resultCell.resultImage.sd_setImage(with: URL(string: results[indexPath.row].strThumb ?? "imageplaceholder"), placeholderImage: UIImage(named: "imageplaceholder"))
            resultCell.resultImage.layer.cornerRadius = 20
            resultCell.resultScore.text = "\(String(describing: results[indexPath.row].strHomeTeam!))  \(String(describing: results[indexPath.row].intHomeScore!)) : \(String(describing: results[indexPath.row].intAwayScore!))  \(String(describing: results[indexPath.row].strAwayTeam!))"
            return resultCell
        }else if (collectionView == teamsCollection){
            let teamCell = teamsCollection.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
            teamCell.teamLogo.sd_setImage(with: URL(string: teams[indexPath.row].strTeamBadge ?? "imageplaceholder"), placeholderImage: UIImage(named: "imageplaceholder"))
            return teamCell
        }else{
            let cell = teamsCollection.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamCollectionViewCell
            return cell
        }
    }
    
    
    
    func getUpcomingEvents(){
        leagueName = selectedLeague.strLeague?.replacingOccurrences(of: " ", with: "%20")
        print(leagueName!)
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/searchfilename.php?e=\(String(describing: leagueName!))") else {return}
//        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/searchfilename.php?e=Algerian%20Ligue%201") else {return}
//        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/eventsround.php?id=4328&r=38&s=2021-2022") else {return}
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
                result in
                switch result.result{
                case .failure(_):
                    print("Error")
                case .success(_):
                    guard let data = result.data else {return}
                    let json = try? JSONDecoder().decode([String:[Event]]?.self, from:data)
                    if let json = json {
                        self.upComingEvents = json["event"]!
                    }
                    print(self.upComingEvents.count)
                    DispatchQueue.main.async {
                        self.eventsCollection.reloadData()
                    }
                }
            }
        }
    
    
    func getResults(){
  
        print(selectedLeague.idLeague!)
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/eventsseason.php?id=\(String(describing: selectedLeague.idLeague!))&s=2021-2022") else {return}
        print(url)
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
                result in
                switch result.result{
                case .failure(_):
                    print("Error")
                case .success(_):
                    guard let data = result.data else {return}
                    let json = try? JSONDecoder().decode([String:[Result]]?.self, from:data)
                    if let json = json {
                        self.results = json["events"]!
                    }
                    print(self.results.count)
                    DispatchQueue.main.async {
                        self.resultsCollection.reloadData()
                    }
                }
            }
        }
    
    func getTeams(){
        
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(String(describing: leagueName!))") else {return}
        print(leagueName!)
//        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=Algerian%20Ligue%201") else {return}
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
                result in
                switch result.result{
                case .failure(_):
                    print("Error")
                case .success(_):
                    guard let data = result.data else {return}
                    let json = try? JSONDecoder().decode([String:[Team]]?.self, from:data)
                    if let json = json {
                        self.teams = json["teams"]!
                    }
                    print(self.teams.count)
                    DispatchQueue.main.async {
                        self.teamsCollection.reloadData()
                    }
                }
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == teamsCollection){
            selectedTeam = teams[indexPath.row]
            performSegue(withIdentifier: "showTeam", sender: self)
           
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showTeam"){
            let teamDetailsVC = segue.destination as! TeamDetailsViewController
            teamDetailsVC.selectedTeam = selectedTeam
            
        }
    }

    // MARK: UICollectionViewDelegateFlowLayout
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == eventsCollection){
            return CGSize(width: UIScreen.main.bounds.width*0.7, height: UIScreen.main.bounds.height)
        }else if(collectionView == resultsCollection){
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height*0.8)
        }else{
            return CGSize(width: UIScreen.main.bounds.width*0.3, height: UIScreen.main.bounds.height)
        }
    }
    
    //Save in Core Data
    func saveData(){
        let savedLeague = FavLeague(context: context)
        savedLeague.idLeague = selectedLeague.idLeague
        savedLeague.strLeague = selectedLeague.strLeague
        savedLeague.strBadge = selectedLeague.strBadge
        savedLeague.strPoster = selectedLeague.strPoster
        savedLeague.strYoutube = selectedLeague.strYoutube
        savedLeague.strDescriptionEN = selectedLeague.strDescriptionEN
        try?context.save()
    }

}
