//
//  QuestionView.swift
//  QuizApp
//
//  Created by Lovro Pejic on 07/04/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import UIKit

class QuestionView: UIView {
    
    @IBOutlet weak var answerCorrectLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var Answer0Btn: UIButton!
    @IBOutlet weak var Answer1Btn: UIButton!
    @IBOutlet weak var answer2Btn: UIButton!
    @IBOutlet weak var answer3Btn: UIButton!
    
    var correctAnswer: Int = -1
    var answerSelected: Bool = false
    
    weak var delegate : QuestionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    @IBAction func answer0BtnAction(_ sender: Any) {
        checkAnswerIsCorrect(btnId:0)
    }
    @IBAction func answer1BtnAction(_ sender: Any) {
         checkAnswerIsCorrect( btnId:1)
    }
    @IBAction func answer2BtnAction(_ sender: Any) {
         checkAnswerIsCorrect( btnId:2)
    }
    @IBAction func answer3BtnAction(_ sender: Any) {
         checkAnswerIsCorrect(btnId:3)
    }
    
    func disableAllAnswersBtns(){
        Answer0Btn.isEnabled = false
        Answer1Btn.isEnabled = false
        answer2Btn.isEnabled = false
        answer3Btn.isEnabled = false
    }
    
    func sayUserWon(btnId : Int){
        let correctAnswerBtn = getBtnForBtnId(btnId: btnId)
        
        correctAnswerBtn?.backgroundColor = UIColor.green
        
        updateAndShowResponseAnswerLabel(text:"CORRECT", color: UIColor.green)
    }
    
    func updateAndShowResponseAnswerLabel(text:String, color:UIColor){
        answerCorrectLabel.text = text
        answerCorrectLabel.textColor = color
        
        answerCorrectLabel.isHidden = false
    }
    
    
    func sayUserFailed(btnId : Int){
        let correctAnswerBtn = getBtnForBtnId(btnId: correctAnswer)
        let wrongAnswerBtn = getBtnForBtnId(btnId: btnId)
        
        correctAnswerBtn?.backgroundColor = UIColor.green
        wrongAnswerBtn?.backgroundColor = UIColor.red
        
        updateAndShowResponseAnswerLabel(text:"FAILED", color: UIColor.red)
    }
    
    func getBtnForBtnId(btnId: Int) -> UIButton!{
        
        switch btnId {
        case 0:
            return Answer0Btn
            
        case 1:
            return Answer1Btn
            
        case 2:
            return answer2Btn
            
        case 3:
            return answer3Btn
        default:
            return nil
        }
       
    }
    
    func checkAnswerIsCorrect(btnId:Int){
        
        disableAllAnswersBtns()
        
        if(btnId == correctAnswer){
            sayUserWon(btnId:btnId)
            
            //sleep(1)
            delegate?.questionAnswered(isAnswerCorrect: true)
        }else{
            sayUserFailed(btnId:btnId)
            
              //sleep(1)
            delegate?.questionAnswered(isAnswerCorrect: false)
        }
        
    }
}
