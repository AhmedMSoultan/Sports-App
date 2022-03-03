//
//  SportsCollectionViewController.swift
//  Sports-App
//
//  Created by Ahmed Soultan on 23/02/2022.
//

import UIKit
import Reachability
import Alamofire
import SDWebImage

private let reuseIdentifier = "sportCell"
let reachability = try! Reachability()
var sports:[Sports] = []

class SportsCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{
    
    let indicator = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sports"
        indicator.center = view.center
        indicator.color = .green
        self.view.addSubview(indicator)
        indicator.startAnimating()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Reachability
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        reachability.whenReachable = { reachabilty in
                    if reachabilty.connection == .wifi {
                        print("Reachable via wifi")
                        self.getSportsData()
                    } else {
                        print("Reachable via cellular")
                        self.getSportsData()
                    }
                }
                reachability.whenUnreachable = { _ in
                    print("Not reachable")
                    DispatchQueue.main.async {
                        self.indicator.startAnimating()
                    }
                }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sports.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sportCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        let sportImgView:UIImageView = sportCell.viewWithTag(1) as! UIImageView
        sportImgView.sd_setImage(with: URL(string: sports[indexPath.row].strSportIconGreen!), placeholderImage: UIImage(named: "imageplaceholder"))
        let sportLabel:UILabel = sportCell.viewWithTag(2) as! UILabel
        sportLabel.text = sports[indexPath.row].strSport
        return sportCell
    }
    
    func getSportsData(){
            guard let url = URL(string: "https://www.thesportsdb.com/api/v1/json/2/all_sports.php") else {return}
            AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response{
                result in
                switch result.result{
                case .failure(_):
                    self.indicator.startAnimating()
                    print("Error")
                case .success(_):
                    guard let data = result.data else {return}

                    let json = try! JSONDecoder().decode(Sport.self, from:data)
                    sports = json.sports!
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.indicator.stopAnimating()
                    }
                }
            }

        }


    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesVC = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesTableVC") as! LeaguesTableViewController
        leaguesVC.sport = sports[indexPath.row]
        print(leaguesVC.sport.strSport!)
        self.navigationController?.pushViewController(leaguesVC, animated: true)
    }
    
    

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width*0.3, height: 150)
//        return CGSize(width: 190, height: 130)
    }

}
