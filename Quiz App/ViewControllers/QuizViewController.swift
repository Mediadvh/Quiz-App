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
// MARK: -Variables
    var state : State = .question
    var mode: Mode = .flashCard {
        //each time the value of mode is updated, the code in the didSet block will run
        
        didSet {
            updateUI()
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
        answerTextfield.delegate = self
        
        // Updating the user interface
        updateUI()

       
    }
// MARK: -IBActions
    @IBAction func showAnswerTapped(_ sender: Any) {
        state = .answer
        updateUI()
    }
    @IBAction func nextElementTapped(_ sender: Any) {
        if mode == .quiz{
        // reset the textfield
        answerTextfield.isUserInteractionEnabled = true
        answerTextfield.text = ""
        answerTextfield.layer.borderWidth = 0
        }
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
// MARK: -Logic
    func updateFlashCardUI() {
        
        
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
        answerTextfield.isHidden = false
         switch state {
            case .question:
                answerLabel.text = ""
            case .answer:
                if answerIsCorrect {
                    
                    answerTextfield.layer.borderWidth = 2
                    answerTextfield.layer.borderColor = #colorLiteral(red: 0, green: 0.7484197021, blue: 0.2804747224, alpha: 1)
                    answerTextfield.layer.cornerRadius = 5
                    answerTextfield.isUserInteractionEnabled = false
                    answerLabel.text = "Correct!"
                    
                } else {
                    answerTextfield.layer.borderWidth = 2
                    answerTextfield.layer.borderColor = #colorLiteral(red: 0.85745579, green: 0.1920336485, blue: 0.1270921528, alpha: 1)
                    answerTextfield.layer.cornerRadius = 5
                    answerTextfield.isUserInteractionEnabled = false
                   
                }
            }
       
    }
    
    func updateUI() {
        switch mode {
        case .flashCard:
            updateFlashCardUI()
        case .quiz:
            updateQuizUI()
        }
    }
    
    
}
// MARK: -Extension


extension QuizViewController :UITextFieldDelegate{
    
    // Runs after the user hits the Return key on the keyboard
    func textFieldShouldReturn(_ textField:
       UITextField) -> Bool {
        // Get the text from the text field
        let textFieldContents = textField.text!
        
        // Determine whether the user answered correctly and update appropriate quiz state
        
        if textFieldContents.lowercased() == Logo.logoList[currentLogoIndex].lowercased() {
            
            answerIsCorrect = true
            correctAnswerCount += 1
            
        } else {
            
            answerIsCorrect = false
        }
       
        state = .answer
        
        updateUI()
        
        return true
    }
   
    
}
