//
//  ViewController.swift
//  Quiz App
//
//  Created by Media Davarkhah on 7/5/1399 AP.
//

import UIKit

class QuizViewController: UIViewController{

// MARK: -IBOutlets
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerTextfield : UITextField!
    @IBOutlet weak var modeSelector : UISegmentedControl!
    // buttons
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var showAnswer:UIButton!
    @IBOutlet weak var nextElement:UIButton!
    
    
// MARK: -Variables
    var state : State = .question
   
    var mode: Mode = .flashCard {
        //each time the value of mode is updated, the code in the didSet block will run
        
        didSet {
            updateUI()
        }
    }
    var questionIndex : Int = 0{
        
        didSet{
            if questionIndex == 10 {
                nextButton.setTitle("Done", for: .normal)
                questionIndex = 0
                
            }
        }
    }
    var currentLogoIndex = 0
    
    // Quiz-specific state
    var answerIsCorrect = false
    var correctAnswerCount = 0
// MARK: ViewControllers functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the view controller as the textfield's delegate
        
        
        // Updating the user interface
        updateUI()

       
    }
    
// MARK: -IBActions
    @IBAction func showAnswerTapped(_ sender: Any) {
        state = .answer
        updateUI()
    }
    @IBAction func nextElementTapped(_ sender: Any) {
      
        state = .question
        currentLogoIndex = Logo.getRandomIndex()
        updateUI()
    }
    @IBAction func switchModes(_ sender: Any) {
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
        } else {
            mode = .quiz
        }
    }
    @IBAction func nextTapped(_ sender: Any){
        
        if (nextButton.currentTitle == "Done"){
            showScore()
            nextButton.setTitle("Try Again!", for: .normal)
        }else
        {
            nextButton.setTitle("Next", for: .normal)
            let textFieldContents = answerTextfield.text!
            
            // Determine whether the user answered correctly and update appropriate quiz state
            
            if textFieldContents.lowercased() == Logo.logoList[currentLogoIndex].lowercased() {
                
                questionIndex += 1
                answerIsCorrect = true
                correctAnswerCount += 1
                
            } else {
                
                questionIndex += 1
                answerIsCorrect = false
            }
            
            state = .answer
            
            currentLogoIndex = Logo.getRandomIndex()
            updateUI()}
        
    }
// MARK: -Logic
    func updateFlashCardUI() {
        
        nextButton.isHidden = true
        nextElement.isHidden = false
        showAnswer.isHidden = false
        logo.image = UIImage(named : Logo.logoList[currentLogoIndex])
        answerTextfield.isHidden = true
        answerTextfield.resignFirstResponder()
        
        switch state {
        case .answer:
            answerLabel.text = Logo.logoList[currentLogoIndex]
        case .question:
            answerLabel.text = "?"
            
        }
        
    }

    func updateQuizUI() {
        
        logo.image = UIImage(named : Logo.logoList[currentLogoIndex])
        answerTextfield.isHidden = false
        nextButton.isHidden = false
        nextElement.isHidden = true
        showAnswer.isHidden = true
        answerLabel.isHidden = true
        answerTextfield.text = ""
//         switch state {
//            case .question:
//                answerLabel.text = ""
//            case .answer:
//                if answerIsCorrect {
//
//                    answerTextfield.layer.borderWidth = 2
//                    answerTextfield.layer.borderColor = #colorLiteral(red: 0, green: 0.7484197021, blue: 0.2804747224, alpha: 1)
//                    answerTextfield.layer.cornerRadius = 5
//                    answerTextfield.isUserInteractionEnabled = false
//                    answerLabel.text = "Correct!"
//
//                } else {
//                    answerTextfield.layer.borderWidth = 2
//                    answerTextfield.layer.borderColor = #colorLiteral(red: 0.85745579, green: 0.1920336485, blue: 0.1270921528, alpha: 1)
//                    answerTextfield.layer.cornerRadius = 5
//                    answerTextfield.isUserInteractionEnabled = false
//
//                }
//            }
       
    }
    
    func updateUI() {
        switch mode {
        case .flashCard:
            updateFlashCardUI()
        case .quiz:
            updateQuizUI()
        }
    }
    
    func showScore(){
        
        answerLabel.isHidden = false
        answerLabel.text = "\(correctAnswerCount) out of 10"
        
        
        
    }
    
}

