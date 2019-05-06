//
//  InitialViewController.swift
//  QuizApp
//
//  Created by Lovro Pejic on 06/04/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var loadingBarIndicator: UIActivityIndicatorView!
    @IBOutlet weak var quizImageView: UIImageView!
    @IBOutlet weak var quizTitleView: UILabel!
    @IBOutlet weak var grabQuizzesBtn: UIButton!
    @IBOutlet weak var cantGrabQuizzesLabel: UILabel!
    @IBOutlet weak var funFactLabel: UILabel!
    
    @IBOutlet weak var CustomViewContainer: UIView!
    var showMessageTimer = Timer()
    var showMessageLen = 3
    var passedTime = 0
    var isTimmerRunning = false
    
    var filterWord = "NBA"
    
    @IBOutlet weak var logOutBtn: UIButton!
    
    @IBAction func logOutAction(_ sender: Any) {
        deleteUserData()
        let vc = LoginViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func grabQuizzesAction(_ sender: UIButton) {
        //showCantGrabQuizzesLabel();
        grabQuizzesBtn.isEnabled = false
        loadingBarIndicator.isHidden = false
        grabQuizzes()
    }
    
    func deleteUserData(){
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: "user_id")
        userDefaults.set(nil, forKey: "token")
    }
    
    func grabQuizzes(){
        let quizzesService = QuizzesService()
        
        quizzesService.fetchQuizzes() { (quizzes) in
            // ovdje moramo izvrsiti ovaj kod na main dretvi, vise o tome u iducim predavanjima
            DispatchQueue.main.async {
                if let quizzes = quizzes {
                    self.processGrabbedQuizzes(quizzes: quizzes)
                }else {
                    self.showCantGrabQuizzesLabel()
                }
                
                self.grabQuizzesBtn.isEnabled = true
                self.loadingBarIndicator.isHidden = true
            }
        }
        
    }
    
    func processGrabbedQuizzes(quizzes:Quizzes){
        //print("podatci spremni za prikaz...")
        grabQuizzesBtn.isHidden = true
        
        updateFunFactLabel(quizzes : quizzes)
        
        let quizId = Int.random(in: 0..<quizzes.quizzes.count)
        let selectedQuiz = quizzes.quizzes[quizId]
        
        let questionId = Int.random(in: 0..<selectedQuiz.questions.count)
        let selectedQuestion = selectedQuiz.questions[questionId]
        
        
        manageCategoryView(selectedQuiz:selectedQuiz, selectedQuestion: selectedQuestion)
        
        
        //print("broj kvizova je \(quizzes.quizzes.count)")
    }
    
    func manageCategoryView(selectedQuiz:Quiz, selectedQuestion : Question){
        let categoryImageService = CategoryImageService()
        
        // dohvacamo sliku, slicno kao i Country u prethodnoj metodi
        categoryImageService.fetchCategoryImage(categoryImageString : selectedQuiz.imageString!) { (image) in
            DispatchQueue.main.async {
                self.quizImageView.image = image
                self.quizTitleView.text = selectedQuiz.title
                self.quizImageView.isHidden = false
                self.quizTitleView.isHidden = false
                
                self.quizImageView.backgroundColor = selectedQuiz.category.color
                self.quizTitleView.backgroundColor = selectedQuiz.category.color
                
                self.funFactLabel.backgroundColor = selectedQuiz.category.color
                
                
                var color: UIColor
                if(selectedQuiz.category == Category.sport){
                    color = UIColor.white
                }else{
                    color = UIColor.black
                }
                
                self.funFactLabel.textColor = color
                self.quizTitleView.textColor = color
                
                self.funFactLabel.isHidden = false
                
                self.manageQuestionView(selectedQuiz:selectedQuiz, selectedQuestion:selectedQuestion)
            }
            
        }
    }
    
    func manageQuestionView(selectedQuiz:Quiz, selectedQuestion:Question){
        if let customView = Bundle.main.loadNibNamed("QuestionView", owner: nil, options: [:])?.first as? QuestionView {
            CustomViewContainer.addSubview(customView)
            customView.frame = CustomViewContainer.bounds
            //customView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            customView.questionTitleLabel.text = selectedQuestion.question
            
            customView.Answer0Btn.setTitle(selectedQuestion.answers[0], for: .normal)
            customView.Answer1Btn.setTitle(selectedQuestion.answers[1], for: .normal)
            customView.answer2Btn.setTitle(selectedQuestion.answers[2], for: .normal)
            customView.answer3Btn.setTitle(selectedQuestion.answers[3], for: .normal)
            
            customView.correctAnswer = selectedQuestion.correct_answer
            
            CustomViewContainer.isHidden = false
        }
    }
    
    func updateFunFactLabel(quizzes : Quizzes){
        
        let filterWordAppearsCount = calcFilterWordAppearsCount(quizzes:quizzes)
        funFactLabel.text = "FUN FACT -> '\(filterWord)' appears \(filterWordAppearsCount) times."
    }
    
    func calcFilterWordAppearsCount(quizzes:Quizzes) -> Int{
        
        return quizzes.quizzes.map({
            $0.questions.filter({
                $0.question.contains(filterWord)
            }).count
            
        }).reduce(0, +)
        
    }
    
    
    
    func showCantGrabQuizzesLabel(){
        cantGrabQuizzesLabel.isHidden = false
        
        if self.isTimmerRunning == false { //ako timer nije upaljen
            createNewTimer()
        } else { // ako je, potrebno ga je resetirati
            resetTimer()
        }
    }
    
    func hideCantGrabQuizzesLabel(){
        cantGrabQuizzesLabel.isHidden = true
    }
    
    func createNewTimer(){
        passedTime = 0
        isTimmerRunning = true
        showMessageTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(InitialViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        passedTime += 1
        
        if(passedTime == showMessageLen){
            showMessageTimer.invalidate()
            isTimmerRunning = false
            hideCantGrabQuizzesLabel()
        }
    }
    
    func resetTimer(){
        passedTime = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
    }

}
