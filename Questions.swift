//
//  Questions.swift
//  Lotr
//
//  Created by Natalija Krsnik on 26/06/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation
import UIKit

struct RootQuestions: Decodable {
    let questions:[Questions]
}

class Questions: Codable {
    var id: String
    var question: String
    var answers: [String]
    var correctAnswer: String?
    var difficultyLevel: Level
    var description: String?

    
    init?(id: String, question: String, answers: [String], correctAnswer: String?, difficultyLevel:Level, description: String?){
         
        if question.isEmpty { return nil }
        
        self.id = id
        self.question = question
        self.answers = answers
        self.correctAnswer = correctAnswer
        self.difficultyLevel = difficultyLevel
        self.description = description
       
    }
}

enum Level: String, Codable {
    case Basic = "Basic"
    case Intermediate = "Intermediate"
    case Advanced = "Advanced"
    case Expert = "Expert"
}
