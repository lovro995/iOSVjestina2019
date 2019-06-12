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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let logoutBtn: UIBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: (#selector(QuizzesListViewController.logoutUser)))
        
        logoutBtn.tintColor = UIColor.red
        
        self.navigationItem.setRightBarButton(logoutBtn, animated: true) */
        
        self.quizzesTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        quizzesTableView.delegate = self
        quizzesTableView.dataSource = self
        
        grabQuizzes()
    }
    
    @objc func logoutUser(){
        deleteUserData()
        
        let vc = LoginViewController()
        //self.dismiss(animated: true, completion: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    func deleteUserData(){
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: "user_id")
        userDefaults.set(nil, forKey: "token")
        userDefaults.set(nil, forKey: "username")
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
        
        let quiz = listOfQuizzes[indexPath.row]
        
        cell.quizTitleView.text =  quiz.title
        cell.quizDescriptionView.text = quiz.description
       
        let categoryImageService = CategoryImageService()
        categoryImageService.fetchCategoryImage(categoryImageString : quiz.imageString!) { (image) in
            DispatchQueue.main.async {
                cell.quizImageView.image = image
                
                if(indexPath.section == 1 && ((indexPath.row + 1) == (self.filterQuizzesList(category:Category.science).count ))){
                    self.quizzesTableView.isHidden = false
                    self.fetchingQuizzesLabel.isHidden = true
                    self.loadingBar.isHidden = true
                }
            }
        }
        
        switch quiz.level {
        case 1:
            cell.levelView1.backgroundColor = UIColor.green
            cell.levelView2.isHidden = true
            cell.levelView3.isHidden = true
        case 2:
            cell.levelView1.backgroundColor = UIColor.orange
            cell.levelView2.backgroundColor = UIColor.orange
            cell.levelView3.isHidden = true
        case 3:
            cell.levelView1.backgroundColor = UIColor.red
            cell.levelView1.backgroundColor = UIColor.red
            cell.levelView1.backgroundColor = UIColor.red
        default: break
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //(self.parent as! UINavigationController).pushViewController(QuizScreenViewController(), animated: true)
        
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
        
        var selectedQuiz: Quiz
        
        if(indexPath.section == 0){
            selectedQuiz = filterQuizzesList(category: Category.sports)[indexPath.row]
        }else{
            selectedQuiz = filterQuizzesList(category: Category.science)[indexPath.row]
        }
        
        let nextVC = QuizScreenViewController();
        nextVC.selectedQuiz = selectedQuiz
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func filterQuizzesList(category : Category) -> [Quiz]{
        return quizzesList.filter({ (quiz) -> Bool in
            quiz.category == category
        })
    }
    
}
