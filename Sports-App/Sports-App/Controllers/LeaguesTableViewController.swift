//
//  LeaguesTableViewController.swift
//  Sports-App
//
//  Created by Ahmed Soultan on 23/02/2022.
//

import UIKit
import Alamofire

class LeaguesTableViewController: UITableViewController {
    
    
    var sport = Sports(idSport: "", strSport: "", strFormat: "", strSportThumb: "", strSportIconGreen: "", strSportDescription: "")
    var leagues : [Leagues] = []
    var selectedLeague=Leagues(idLeague: "", strLeague: "", strBadge: "", strPoster: "", strYoutube: "", strDescriptionEN: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = sport.strSport
        self.getSportLeaguesData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }

    
    override func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let leagueCell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as? LeagueTableViewCell
        leagueCell?.leagueImage.sd_setImage(with: URL(string: leagues[indexPath.row].strBadge!), placeholderImage: UIImage(named: "imageplaceholder"))
        leagueCell?.leagueLabel.text = leagues[indexPath.row].strLeague
        leagueCell?.layer.cornerRadius = 20
        leagueCell?.youtubeURL = leagues[indexPath.row].strYoutube
        return leagueCell!
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLeague = leagues[indexPath.row]
//        print(leagues[indexPath.row])
        let leagueDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        leagueDetailsViewController.selectedLeague = selectedLeague
        navigationController?.pushViewController(leagueDetailsViewController, animated: true)
//        performSegue(withIdentifier: "leagueDetailsVC", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "leagueDetailsVC"){
//            let leagueDetailsVC = segue.destination as! LeagueDetailsViewController
//            leagueDetailsVC.selectedLeague = selectedLeague
//        }
//    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getSportLeaguesData(){
//        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?s=\(String(describing: sport.strSport!))") else {return}
        guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php?c=England&s=\(String(describing: sport.strSport!))") else {return}
    
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
                result in
                switch result.result{
                case .failure(_):
                    print("Error")
                case .success(_):
                    guard let data = result.data else {return}
                    
                    let json = try? JSONDecoder().decode([String:[Leagues]]?.self, from:data)
                    if let json = json{
                        self.leagues = json["countrys"]!
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            
        }

}
