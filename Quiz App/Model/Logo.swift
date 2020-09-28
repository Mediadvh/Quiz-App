//
//  Model.swift
//  Quiz App
//
//  Created by Media Davarkhah on 7/5/1399 AP.
//

import UIKit

class Logo{
    
    
    
    static let logoList = ["PYTHON",
                           "SWIFT",
                          // "C",
//                           "JAVA",
                           "KOTLIN",
                           //"C++",
                           //"JAVASCRIPT",
                           "RUST",
                           "GOLANG" ]
    
        static func getRandomIndex() -> (Int) {
         
        // Returns a random index of the collection
            return Int.random(in: 0...4)
            
        }
    
    
    
}
