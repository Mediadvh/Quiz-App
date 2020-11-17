//
//  Model.swift
//  Quiz App
//
//  Created by Media Davarkhah on 7/5/1399 AP.
//

import UIKit

class Logo{
    
     static var lastUsedRandom: String = ""

     static var logoList = ["PYTHON",
                           "SWIFT",
                          "DART",
                           "JAVA",
                           "KOTLIN",
                           "RUBY",
                           "JAVASCRIPT",
                           "RUST",
                           "GOLANG" ]
    

     static func getRandomElement()->String{
        
        var random = logoList.randomElement()
        while lastUsedRandom == random {
           random = logoList.randomElement()
        }
        return random!
        
    }
    
    
    
}
