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
    @IBOutlet weak var nextLogo:UIButton!
    
// MARK: -Enums
    
    // the mode of app
    enum Mode {
        case flashCard
        case quiz
    }

    // the state of label
    enum State{
        case answer
        case question
    }
    
// MARK: -Variables
    var state : State = .question
    var mode: Mode = .flashCard {
        //each time the value of mode is updated, the code in the didSet block will run
        didSet {
            updateUI()
        }
    }
    var questionIndex : Int = 0 {
        // observer
        didSet{
            if questionIndex == 10 {
                nextButton.setTitle("Done", for: .normal)
                questionIndex = 0
            }
        }
    }
    
    // keeps track of the logo
    var currentLogoIndex = 0
    
    // Quiz-specific state
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    
    
    
    
// MARK: -ViewControllers functions
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Updating the user interface
        updateUI()
    
    }
    
// MARK: -IBActions:
    @IBAction func showAnswerTapped(_ sender: Any) {
        
        if( answerLabel.text == Logo.logoList[currentLogoIndex] )
        {
            // show an alert
            let alert = UIAlertController(title: "answer's already there❗️", message: "" , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
        state = .answer
        updateUI()
    }
    @IBAction func nextLogoTapped(_ sender: Any) {
      
        state = .question
        currentLogoIndex = Logo.getRandomIndex()
        updateUI()
    }
    @IBAction func switchModes(_ sender: Any) {
        // sets mode of UI
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
            currentLogoIndex = Logo.getRandomIndex()
            updateUI()
        } else {
            mode = .quiz
            currentLogoIndex = Logo.getRandomIndex()
            updateUI()
        }
    }
    
    // next question
    @IBAction func nextTapped(_ sender: Any){
        
        if (nextButton.currentTitle == "Done"){
            showScore()
            answerTextfield.isHidden = true
            correctAnswerCount = 0
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
            updateUI()
            
        }
        
    }
// MARK: -Logic
    func updateFlashCardUI() {
        
        nextButton.isHidden = true
        nextLogo.isHidden = false
        showAnswer.isHidden = false
        answerTextfield.isHidden = true
        
        logo.image = UIImage(named : Logo.logoList[currentLogoIndex])
        
//        answerTextfield.resignFirstResponder()
        
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
        nextLogo.isHidden = true
        showAnswer.isHidden = true
        answerLabel.isHidden = true
        answerTextfield.text = ""
        
       
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
        
        // present confetti
        

        // show an alert
        let alert = UIAlertController(title: "\(correctAnswerCount) out of 10", message: "What do you want to do?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Agian", style: .default, handler: {_ in
           
            self.updateUI()
        }))
        alert.addAction(UIAlertAction(title: "show Flash Cards", style: .default, handler: { _ in
            self.mode = .flashCard
            self.modeSelector.selectedSegmentIndex = 0
            self.updateUI()
        }))
        present(alert,animated: true)
        
        
        nextButton.setTitle("next", for: .normal)
        
    }
    
}

