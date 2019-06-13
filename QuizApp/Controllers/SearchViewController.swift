//
//  SearchViewController.swift
//  QuizApp
//
//  Created by Lovro Pejic on 11/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
   
    
    @IBOutlet weak var searchedQuizzesTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    let cellReuseIdentifier = "cell"
    
    var quizzesList : [Quiz] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchedQuizzesTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        searchedQuizzesTableView.delegate = self
        searchedQuizzesTableView.dataSource = self
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        
        updateGUIHasNoQuizzes()
        
        self.searchTextField.endEditing(true)
        self.quizzesList.removeAll()
        
        let quizzes = DataController.shared.fetchQuizzesMatchFilter(filter: self.searchTextField.text!)
        
        if(!quizzes!.isEmpty){
        
            quizzes?.forEach({ (quiz) in
                self.quizzesList.append(quiz)
            })
            
            DispatchQueue.main.async {
                self.searchedQuizzesTableView.reloadData()
            }
        }
        
    }

}

extension SearchViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("QuizViewCell", owner: self, options: nil)?.first as! QuizViewCell
        
        let quiz = quizzesList[indexPath.row]
        
        cell.quizTitleView.text = quiz.title
        cell.quizDescriptionView.text = quiz.desc
        
        if(ConnectionManager.instance.isConnectedToInternet()){
            let categoryImageService = CategoryImageService()
            categoryImageService.fetchCategoryImage(categoryImageString : quiz.imageString!) { (image) in
                DispatchQueue.main.async {
                    cell.quizImageView.image = image
                    cell.quizImageView.contentMode = UIView.ContentMode.scaleToFill
                    
                    if(((indexPath.row + 1) == (self.quizzesList.count ))){
                        self.updateGUIHasQuizzes()
                    }
                }
            }
        }else {
            updateGUIHasQuizzes()
            cell.quizImageView.contentMode = UIView.ContentMode.scaleAspectFit
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
    
    func updateGUIHasQuizzes(){
        self.searchedQuizzesTableView.isHidden = false
    }
    
    
    func updateGUIHasNoQuizzes(){
        self.searchedQuizzesTableView.isHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzesList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //(self.parent as! UINavigationController).pushViewController(QuizScreenViewController(), animated: true)
        
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
        
        let selectedQuiz: Quiz = quizzesList[indexPath.row]
        
        let nextVC = QuizScreenViewController();
        nextVC.selectedQuiz = selectedQuiz
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}
