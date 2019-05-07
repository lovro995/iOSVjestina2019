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
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("QuizViewCell", owner: self, options: nil)?.first as! QuizViewCell
        
        var listOfQuizzes:[Quiz] = []
        
        if(indexPath.section == 0){
            listOfQuizzes.append(contentsOf: filterQuizzesList(category: Category.sports))
        } else{
            listOfQuizzes.append(contentsOf: filterQuizzesList(category: Category.science))
        }
        
        cell.quizTitleView.text =  listOfQuizzes[indexPath.row].title
        cell.quizDescriptionView.text = listOfQuizzes[indexPath.row].description
       
        let categoryImageService = CategoryImageService()
        categoryImageService.fetchCategoryImage(categoryImageString : listOfQuizzes[indexPath.row].imageString!) { (image) in
            DispatchQueue.main.async {
                cell.quizImageView.image = image
                
                if(indexPath.section == 1 && ((indexPath.row + 1) == (self.filterQuizzesList(category:Category.science).count ))){
                    self.quizzesTableView.isHidden = false
                    self.fetchingQuizzesLabel.isHidden = true
                    self.loadingBar.isHidden = true
                }
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filteredQuizzes: [Quiz]
        if(section == 0){
             filteredQuizzes = filterQuizzesList(category: Category.sports)
        }else{
             filteredQuizzes = filterQuizzesList(category: Category.science)
        }
        
         return filteredQuizzes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var nameUpperCased : String?
        if(section == 0){
            nameUpperCased = String.uppercased(Category.sports.rawValue)()
        }else{
            nameUpperCased = String.uppercased(Category.science.rawValue)()
        }
        
        return nameUpperCased
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if(section == 0){
            view.tintColor = Category.sports.color
        }else{
            view.tintColor = Category.science.color
        }
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    func filterQuizzesList(category : Category) -> [Quiz]{
        return quizzesList.filter({ (quiz) -> Bool in
            quiz.category == category
        })
    }
    
}
