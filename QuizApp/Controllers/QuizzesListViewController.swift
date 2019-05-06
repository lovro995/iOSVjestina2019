//
//  QuizzesListViewController.swift
//  QuizApp
//
//  Created by Lovro Pejic on 05/05/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import UIKit
import Foundation

class QuizzesListViewController: UIViewController {
    
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    let cellReuseIdentifier = "cell"
    var quizzesList : [Quiz] = []
    
    @IBOutlet weak var fetchingQuizzesLabel: UILabel!
    
    @IBOutlet weak var quizzesTableView: UITableView!
    @IBAction func logOutAction(_ sender: Any) {
        deleteUserData()
        let vc = LoginViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.quizzesTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        quizzesTableView.delegate = self
        quizzesTableView.dataSource = self
        
        grabQuizzes()
    }
    
    func deleteUserData(){
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: "user_id")
        userDefaults.set(nil, forKey: "token")
    }
    
    
    func grabQuizzes(){
        self.loadingBar.isHidden = false
        self.fetchingQuizzesLabel.isHidden = false
        self.quizzesTableView.isHidden = true
        
        let quizzesService = QuizzesService()
        
        quizzesService.fetchQuizzes() { (quizzes) in
            
                if let quizzes = quizzes {
                    print("quizzes successfully fetched.")
                    quizzes.quizzes.forEach({ (quiz) in
                        self.quizzesList.append(quiz)
                    })
                    
                    DispatchQueue.main.async {
                        self.quizzesTableView.reloadData()
                    }
                    
                }else {
                    //
                }
            
        }
        
    }
}

extension QuizzesListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzesList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("QuizViewCell", owner: self, options: nil)?.first as! QuizViewCell
        
        cell.quizTitleView.text =  quizzesList[indexPath.row].title
        cell.quizDescriptionView.text = quizzesList[indexPath.row].description
       
        let categoryImageService = CategoryImageService()
        categoryImageService.fetchCategoryImage(categoryImageString : quizzesList[indexPath.row].imageString!) { (image) in
            DispatchQueue.main.async {
                cell.quizImageView.image = image
                
                if(indexPath.row == (self.quizzesList.count - 1 )){
                    self.quizzesTableView.isHidden = false
                    self.fetchingQuizzesLabel.isHidden = true
                    self.loadingBar.isHidden = true
                }
            }
        }
        return cell
    }
    
}
