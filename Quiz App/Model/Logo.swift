//
//  Model.swift
//  Quiz App
//
//  Created by Media Davarkhah on 7/5/1399 AP.
//

import UIKit

class Logo{
    
    static var lastUsedRandom: Int = 0

    static let logoList = ["PYTHON",
                           "SWIFT",
                          "DART",
                           "JAVA",
                           "KOTLIN",
                           "RUBY",
                           "JAVASCRIPT",
                           "RUST",
                           "GOLANG" ]
    
        static func getRandomIndex() -> (Int) {
            
        // Returns a random index of the collection
            var randNum = Int.random(in: 0...logoList.count-1)
            lastUsedRandom = randNum
            while lastUsedRandom == randNum{
                randNum = Int.random(in: 0...logoList.count-1)
            }
            return randNum
            
        }
    
    
    
}
