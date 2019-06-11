//
//  LeaderboardViewController.swift
//  QuizApp
//
//  Created by Lovro Pejic on 11/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController {
    
    var quizId : Int?
    let cellReuseIdentifier = "cell"
    var leaderboardDataList : [LeaderboardData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.leaderboardTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
 
        leaderboardTableView.delegate = self
        leaderboardTableView.dataSource = self
        
        grabLeaderboard();
    }
    @IBOutlet weak var leaderboardTableView: UITableView!
    
    func grabLeaderboard() {
        
        let leaderboardService = LeaderboardService()
        
        leaderboardService.fetchLeaderboard(quizId : quizId!) { (leaderboardDataList) in
            
            if let leaderboardDataList = leaderboardDataList {
                print("leaderboardDataList successfully fetched.")
                leaderboardDataList.leaderboardDataList.forEach({ (leaderboardData) in
                    self.leaderboardDataList.append(leaderboardData)
                })
                
                DispatchQueue.main.async {
                    self.leaderboardTableView.reloadData()
                }
            } else {
                //error
            }
            
        }
    }

}

extension LeaderboardViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leaderboardDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellReuseIdentifier)
        cell.textLabel?.text = self.leaderboardDataList[indexPath.row].userName + " : " + self.leaderboardDataList[indexPath.row].score
        
        return cell
    }
    
}
