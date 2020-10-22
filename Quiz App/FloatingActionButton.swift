//
//  Button.swift
//  Quiz App
//
//  Created by Media Davarkhah on 7/8/1399 AP.
//

import UIKit

class FloatingActionButton: UIButton {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        layer.borderColor = UIColor(named : "button" )?.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 10
        layer.backgroundColor = UIColor(named : "button" )?.cgColor
        setTitleColor(.white, for: .normal)
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.25
        
        
    }
    

}
