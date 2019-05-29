//
//  QuizScreenViewController.swift
//  QuizApp
//
//  Created by Lovro Pejic on 07/05/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import UIKit

class QuizScreenViewController: UIViewController {
    
    var selectedQuiz : Quiz?
    var answersList : [Bool] = []
    var startTime : Date?

    @IBOutlet weak var selectedQuizImageView: UIImageView!
    @IBOutlet weak var questionsScrollView: UIScrollView!
    @IBOutlet weak var selectedQuizTitle: UILabel!
    @IBOutlet weak var bottomLineView: UIView!
    
    @IBOutlet weak var startQuizBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let categoryImageService = CategoryImageService()
        categoryImageService.fetchCategoryImage(categoryImageString : selectedQuiz!.imageString!) { (image) in
            DispatchQueue.main.async {
                self.selectedQuizImageView.image = image
                
                self.questionsScrollView.isScrollEnabled = false
                self.selectedQuizTitle.text = self.selectedQuiz?.title
                
                self.selectedQuizTitle.isHidden = false
                self.selectedQuizImageView.isHidden = false
                self.startQuizBtn.isHidden = false
                
                self.beginStartQuizBtnAnimation()
            }
        }
        
    }
    
    func beginStartQuizBtnAnimation() {
        self.startQuizBtn.alpha = 0.1
        UIButton.animate(withDuration: 0.6, delay: 0.0, options: [.curveLinear, .repeat, .autoreverse, .allowUserInteraction], animations: {self.startQuizBtn.alpha = 1.0}, completion: nil)
    }
    
    @IBAction func startQuizAction(_ sender: Any) {
        
        self.startQuizBtn.layer.removeAllAnimations()
        self.startQuizBtn.layoutIfNeeded()
        
        manageQuestionsViewsToScrollView()
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        bottomLineView.isHidden = false
        questionsScrollView.isHidden = false
        startQuizBtn.isEnabled = false
        startTime = Date()
    }
    
    func manageQuestionsViewsToScrollView(){
        
        var scrollWidth : CGFloat = 0
        
        selectedQuiz?.questions.forEach({ (question) in
           
            if let customView = Bundle.main.loadNibNamed("QuestionView", owner: nil, options: [:])?.first as? QuestionView {
                
                customView.delegate = self
                
                customView.frame.origin.x = scrollWidth
            
                questionsScrollView.addSubview(customView)
                
                scrollWidth += customView.frame.size.width
                
                customView.questionTitleLabel.text = question.question
            
                customView.Answer0Btn.setTitle(question.answers[0], for: .normal)
                customView.Answer1Btn.setTitle(question.answers[1], for: .normal)
                customView.answer2Btn.setTitle(question.answers[2], for: .normal)
                customView.answer3Btn.setTitle(question.answers[3], for: .normal)
            
                customView.correctAnswer = question.correct_answer
            }
        })
        
          questionsScrollView.contentSize = CGSize(width:scrollWidth,height: questionsScrollView.contentSize.height)
    }
}

extension QuizScreenViewController : QuestionViewDelegate{
    func questionAnswered(isAnswerCorrect : Bool) {
        //need to scroll to next question or handle if quiz is finished
        print("question answered.")
        
        answersList.append(isAnswerCorrect)
        
        let currentScrollViewPostion = questionsScrollView.contentOffset
        
        /*
        var nextX = questionsScrollView.contentSize.width
        nextX /= CGFloat(selectedQuiz!.questions.count)
        nextX = currentScrollViewPostion.x + nextX*/
        
        var nextX = questionsScrollView.contentSize.width // width of scroll view
        nextX /= CGFloat(selectedQuiz!.questions.count) // size of 1 question view
        
        nextX *= CGFloat(answersList.count)
        
        if(!isScrolledToLastQuestion(position: nextX)){
            //scroll to next question
            
            let nextScrollPosition = CGPoint(x: nextX, y: currentScrollViewPostion.y)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.questionsScrollView.setContentOffset(nextScrollPosition, animated: true)
            }
    
        } else{
            //finish quiz
            
            let passedTime = Date().timeIntervalSince(startTime!)
            
            let quizResultService = SaveQuizService()
            quizResultService.saveQuizResult(quizId : selectedQuiz!.id, correctAnswersNum: calcCorrectAnswersNum(), time: Double(passedTime)) { (serverResponse) in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func calcCorrectAnswersNum() -> Int {
        return answersList.filter({ (current) -> Bool in
            return current == true
        }).count
    }
    
    func isScrolledToLastQuestion(position : CGFloat) -> Bool{
        
        let width = questionsScrollView.contentSize.width
      
        if((width) == position){
            print("last scrolled")
            return true
        }
        
        return false
    }
    
}
