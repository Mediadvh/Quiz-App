//
//  ViewController.swift
//  Quiz App
//
//  Created by Media Davarkhah on 7/5/1399 AP.
//

import UIKit
class QuizViewController: UIViewController{
    
    // When you connect your storyboard to your code Xcode inserts two special markers: @IBAction and @IBOutlet. Xcode uses them to understand which of your properties and methods are relevant to Interface Builder.
    
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
        case questionMark
    }
    
    // MARK: -Conastants & Variables

    var state : State = .questionMark
    
    var mode: Mode = .flashCard {
        //each time the value of mode is updated, the code in the didSet block will run
        didSet {
            //updateUI()
        }
    }
   
    var questionIndex : Int = 1 {
        // observer
        didSet{
            if questionIndex == 3 {
                nextButton.setTitle("Done", for: .normal)
                
            }
        }
    }
    
    // keeps track of the logo
    var currentLogo : String = ""
    
    // Quiz-specific state
    var answerIsCorrect = false
    var correctAnswerCount = 0
    
    // MARK: -ViewControllers functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Updating the user interface
        currentLogo = Logo.getRandomElement()
        updateUI()
        
    }
    
    // MARK: -IBActions:
    //TODO: Implement newxtLogoTapped IBAction func
    @IBAction func nextLogoTapped(_ sender: Any) {
        
        state = .questionMark
        currentLogo = Logo.getRandomElement()
        updateUI()
    }
    // TODO: Implement switchModes IBAction func
    @IBAction func switchModes(_ sender: Any) {
        // sets mode of UI
        if modeSelector.selectedSegmentIndex == 0 {
            mode = .flashCard
            currentLogo = Logo.getRandomElement()
            updateUI()
        } else {
            mode = .quiz
            currentLogo = Logo.getRandomElement()
            updateUI()
        }
    }
    // flashcard view button
    @IBAction func showAnswerTapped(_ sender: Any) {
        
        if answerLabel.text == currentLogo
        {
            // show an alert
            let alert = UIAlertController(title: "answer's already there!", message: "" , preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
        state = .answer
        updateUI()
        
    }
    
    
    // next question
    @IBAction func nextTapped(_ sender: Any){
       
        let textFieldContents = answerTextfield.text!

        if (nextButton.currentTitle == "Done"){
           if textFieldContents == currentLogo.lowercased() {
                
                answerIsCorrect = true
                correctAnswerCount += 1
             
            } else {
                answerIsCorrect = false
             
            }
            //currentLogo = Logo.getRandomElement()
            showScore()
            
        }else
        {
            nextButton.setTitle("Next", for: .normal)
            
            let textFieldContents = answerTextfield.text!
            if textFieldContents == currentLogo.lowercased() || textFieldContents == currentLogo {
                
                questionIndex += 1
                answerIsCorrect = true
                correctAnswerCount += 1
                
            } else {
                
                questionIndex += 1
                answerIsCorrect = false
                
                
            }
            // Determine whether the user answered correctly and update appropriate quiz state
            
            currentLogo = Logo.getRandomElement()
            updateUI()
            
            
        }
        
    }
    
    // MARK: -Update UI Functions
    func updateFlashCardUI() {
        
        nextButton.isHidden = true
        nextLogo.isHidden = false
        showAnswer.isHidden = false
        answerTextfield.isHidden = true
        answerLabel.isHidden = false
        logo.image = UIImage(named : currentLogo)
        
        answerTextfield.resignFirstResponder()
        
        switch state {
        case .answer:
            answerLabel.text = currentLogo
        case .questionMark:
            answerLabel.text = "?"
            
        }
        
    }
    
    func updateQuizUI() {
        
        logo.image = UIImage(named : currentLogo)
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
   
    // MARK: -Logic
    // TODO: Implement ShowScore func
    func showScore(){
        
        // show an alert
        let alert = UIAlertController(title: "\(correctAnswerCount) out of \(questionIndex)", message: "What do you want to do?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Try Agian", style: .default, handler: {_ in
            self.currentLogo = Logo.getRandomElement()
            self.updateUI()
        }))
        alert.addAction(UIAlertAction(title: "show Flash Cards", style: .default, handler: { _ in
            self.currentLogo = Logo.getRandomElement()
            self.state = .questionMark
            self.mode = .flashCard
            self.modeSelector.selectedSegmentIndex = 0
            self.updateUI()
        }))
        
        present(alert,animated: true)
        
        
        nextButton.setTitle("next", for: .normal)
        correctAnswerCount = 0
        questionIndex = 1
        
    }
    
}

