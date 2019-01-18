//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var score : Int = 0

    
    
    
    
    @IBOutlet weak var ProgressConstraint: NSLayoutConstraint!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
       
        
        checkAnswer()
        questionNumber = questionNumber + 1
        nextQuestion()
    
    }
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1)/\(allQuestions.list.count)"
        ProgressConstraint.constant = (view.frame.size.width / 13) * CGFloat (questionNumber + 1)
        updateViewConstraints()
        
    }
    

    func nextQuestion() {
        
        if allQuestions.list.indices.contains(questionNumber) {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }
        
        else {
            print("End of quiz")
            questionNumber = 0
            
            let alert = UIAlertController(title: "Awesome", message: "Youve finished all the questions, do you want to start all over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
                
            })
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
            
            
            }
    
    }
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            print("you are correct!")
            score = score + 1
            scoreLabel.text = "Score: \(score)"
        }
        else {
            print("wrong!")
        }
        
        
    }
    
    
    func startOver() {
        questionNumber = 0
        scoreLabel.text = "Score: 0"
        nextQuestion()
       
    }
    
    
    

    
}
