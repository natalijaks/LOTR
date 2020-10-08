//
//  QuizVC.swift
//  Lotr
//
//  Created by Natalija Krsnik on 26/06/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class QuizVC: UIViewController {
    var safeArea: UILayoutGuide = UILayoutGuide()
    var questions = [Questions]()
    var excludedNums:[Int] = []
    var correctAnswer: String = ""
    var descAnswer: String = ""
    var level: String = ""
    var points: Int = 0
    var difficultyLevelNumQuestions: Int = 0
    var levelPicked: Level = Level.Basic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LEVEL PICKED:", levelPicked)
        self.tabBarController?.tabBar.isHidden = true
        
        //sets image and blur effect on background
        ReusableFunctions.shared.setTheme(view: self.view)
        
        //set nav text color and font
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.txtColorYellow, NSAttributedString.Key.font: UIFont(name: "Baskerville", size: 20)!]
        safeArea = view.layoutMarginsGuide
        
        //left "back" button
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(popNavigation))
        
        setScreen()
        getDatafromJSON()
        setQuestions()
        setButtonActions()
    }
    
    
    let questionView: UIView = {
        let tv = UIView()
        tv.backgroundColor = UIColor.transparentWhite
        tv.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return tv
    }()
    
    let answerView: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        v.layer.borderColor = UIColor.clear.cgColor
        return v
    }()
    
    let pointsView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.transparentWhite
        v.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return v
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Question"
        label.font = UIFont(name: "Baskerville", size: 25)
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        ReusableFunctions.shared.labelShadow(label: label, shadow: UIColor.white)
        return label
    }()
    
    let answer1Btn: UIButton = {
        let b = UIButton()
        b.tag = 1
        b.frame = CGRect(x: 0, y: 0, width: 100, height: 70)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitleColor(UIColor.yellow, for: .focused)
        b.setTitleColor(UIColor.lightGray, for: .normal)
        b.setTitle("Answer1", for: .normal)
        b.contentHorizontalAlignment = .center
        b.backgroundColor = UIColor.btnDarkBrown
        b.layer.cornerRadius = 10
        return b
    }()
    
    let answer2Btn: UIButton = {
        let b = UIButton()
        b.tag = 2
        b.frame = CGRect(x: 0, y: 0, width: 100, height: 70)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitleColor(UIColor.yellow, for: .focused)
        b.setTitleColor(UIColor.lightGray, for: .normal)
        b.setTitle("Answer2", for: .normal)
        b.contentHorizontalAlignment = .center
        b.backgroundColor = UIColor.btnDarkBrown
        b.layer.cornerRadius = 10
        return b
    }()
    
    let answer3Btn: UIButton = {
        let b = UIButton()
        b.tag = 3
        b.frame = CGRect(x: 0, y: 0, width: 100, height: 70)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitleColor(UIColor.yellow, for: .focused)
        b.setTitleColor(UIColor.lightGray, for: .normal)
        b.setTitle("Answer3", for: .normal)
        b.contentHorizontalAlignment = .center
        b.backgroundColor = UIColor.btnDarkBrown
        b.layer.cornerRadius = 10
        return b
    }()
    
    let pointsLabel: UILabel = {
        let label = UILabel()
        label.text = "Points: 0"
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Baskerville", size: 20)
        return label
    }()
    
    let levelLabel: UILabel = {
        let label = UILabel()
        label.text = "LEVEL: "
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Baskerville", size: 20)
        return label
    }()
    
    /**
     Go back to previous view
     */
    @objc func popNavigation(){
        self.navigationController?.popViewController(animated: true)
    }
    
    /**
     Sets elements on screen, defines constraints and subviews
     */
    func setScreen(){
        //set points view
        pointsView.frame = CGRect(x: 20, y: 150, width: self.view.frame.size.width - 30, height: 70)
        pointsView.layer.cornerRadius = 10
        pointsView.layer.borderColor = UIColor.black.cgColor
        pointsView.layer.borderWidth = 0.5
        pointsView.addSubview(levelLabel)
        pointsView.addSubview(pointsLabel)
        
        levelLabel.text = "Level: " + levelPicked.rawValue
        
        pointsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-[v1]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : levelLabel, "v1" : pointsLabel]))
        pointsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : levelLabel]))
        pointsView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : pointsLabel]))
        
        //set question view
        questionView.frame = CGRect(x: 20, y: 250, width: self.view.frame.size.width - 30, height: 200)
        questionView.layer.cornerRadius = 10
        questionView.layer.borderColor = UIColor.black.cgColor
        questionView.layer.borderWidth = 0.5
        questionView.addSubview(questionLabel)
        
        questionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : questionLabel]))
        questionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : questionLabel]))
        
        //set answers view
        answerView.frame = CGRect(x: 20, y: 500, width: self.view.frame.size.width - 30, height: 300)
        answerView.layer.cornerRadius = 10
        answerView.addSubview(answer1Btn)
        answerView.addSubview(answer2Btn)
        answerView.addSubview(answer3Btn)
        
        answerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(50)]-20-[v1(50)]-20-[v2(50)]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : answer1Btn, "v1" : answer2Btn, "v2": answer3Btn]))
        answerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : answer1Btn]))
        answerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v1]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : answer2Btn]))
        answerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v2]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v2" : answer3Btn]))
        
        self.view.addSubview(pointsView)
        self.view.addSubview(questionView)
        self.view.addSubview(answerView)
        
    }
    
    /**
     Get data from json (questionsB, questionsI, questionsA, questionsE).json
     Json contains: id, question, answers(list), correctAnswer, difficultyLevel and description
     */
    func getDatafromJSON(){
        var jsonName: String = ""
        
        //choose json depending on users choice of level( basic, intermediate, advanced or expert)
        if levelPicked == Level.Basic {jsonName = "questionsBasic"}
        if levelPicked == Level.Intermediate  {jsonName = "questionsIntermediate"}
        if levelPicked == Level.Advanced {jsonName = "questionsAdvanced"}
        if levelPicked == Level.Expert {jsonName = "questionsExpert"}
        
        if let localJSONdata = ReusableFunctions.shared.readLocalJSONFile(name: jsonName){
            print("RES:1")
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let result = try decoder.decode(RootQuestions.self, from: localJSONdata)
                result.questions.forEach { element in
                    questions.append(element)
                    print("RES:1:", element.difficultyLevel)
                    difficultyLevelNumQuestions += 1
                }
                
                print("RES:", questions[0].question)
            } catch {
                print(error)
            }
        }
    }
    
    /**
     Function that sets questions ( set text into view, and set answer text into buttons).
     
     Used random function for generating question order. If question is asked, it will be appended into excludedNums array.
     This array contains questions that were already asked, so they do not appear again in question que.
     */
    func setQuestions(){
        
        //set buttons to visible
        answer1Btn.isHidden = false
        answer2Btn.isHidden = false
        answer3Btn.isHidden = false
        
        //get random question and load it into label
        let maxNumQuestions = difficultyLevelNumQuestions
        print("max:", maxNumQuestions, " exc:",excludedNums.count)
        
        if excludedNums.count != maxNumQuestions  {
            let nums = (0...maxNumQuestions - 1).random(without: excludedNums)
            excludedNums.append(nums)
            questionLabel.text = questions[nums].question
            correctAnswer = questions[nums].correctAnswer!
            descAnswer = questions[nums].description!
            level = questions[nums].difficultyLevel.rawValue
            
            //get answers (can be 1,2 or 3 answers), and load them into buttons text
            let numOfAnswers = questions[nums].answers.count
            let answers = questions[nums].answers
            
            if numOfAnswers == 2 {
                answer1Btn.setTitle(answers[0], for: .normal)
                answer2Btn.setTitle(answers[1], for: .normal)
                answer3Btn.isHidden = true
            }
            if numOfAnswers == 3 {
                answer1Btn.setTitle(answers[0], for: .normal)
                answer2Btn.setTitle(answers[1], for: .normal)
                answer3Btn.setTitle(answers[2], for: .normal)
            }
        }else{
            
            let alert = UIAlertController(title: "Level completed", message: "You completed level" + levelPicked.rawValue + ". Do you want to continue playing the quiz?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {  action in
                //TODO:
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {  action in   self.navigationController?.popViewController(animated: true) }))
            
            self.present(alert, animated: true)
        }
        
        //color buttons back to original color
        answer1Btn.backgroundColor = UIColor.btnDarkBrown
        answer2Btn.backgroundColor = UIColor.btnDarkBrown
        answer3Btn.backgroundColor = UIColor.btnDarkBrown
    }
    
    /**
     Sets action to buttons, so when the button is tapped, functions will be called
     */
    func setButtonActions(){
        answer1Btn.addTarget(self, action: #selector(pickedAnswer(_:)), for: .touchUpInside)
        answer2Btn.addTarget(self, action: #selector(pickedAnswer(_:)), for: .touchUpInside)
        answer3Btn.addTarget(self, action: #selector(pickedAnswer(_:)), for: .touchUpInside)
    }
    
    /**
     Checks if choosen answer ( button text ) is equal to answer from json.
     
     ## Depending on the answer, background color of button will change
     
     - If correct answer: green background, add 10 points to points and set a new question.
     - If false: red background, ask the user to play again, reset number of points
     */
    @objc func pickedAnswer(_ sender: UIButton){
        print("A1:", sender.currentTitle!, " C:", correctAnswer)
        if sender.currentTitle == correctAnswer {
            if sender.tag == 1 { answer1Btn.backgroundColor = UIColor.transparentGreen }
            if sender.tag == 2 { answer2Btn.backgroundColor = UIColor.transparentGreen }
            if sender.tag == 3 { answer3Btn.backgroundColor = UIColor.transparentGreen }
            points += 10
            pointsLabel.text = "Points: " + String(points)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.setQuestions()
            })
        }
        else {
            if sender.tag == 1 { answer1Btn.backgroundColor = UIColor.transparentRed}
            if sender.tag == 2 { answer2Btn.backgroundColor = UIColor.transparentRed}
            if sender.tag == 3 { answer3Btn.backgroundColor = UIColor.transparentRed}
            
            print("GAME OVER")
            let alert = UIAlertController(title: "End of the journey", message: "The correct answer would be:\n" + descAnswer + "\nYou have failed the quest. Do you want to start a new quest?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                action in
                //TODO:
                self.setQuestions()
                self.points = 0
                self.pointsLabel.text = "Points: " + String(self.points)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
                action in
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true)
        }
    }
}

//extension for excluding multiple values
extension ClosedRange where Element: Hashable {
    func random(without excluded:[Element]) -> Element {
        let valid = Set(self).subtracting(Set(excluded))
        let random = Int(arc4random_uniform(UInt32(valid.count)))
        return Array(valid)[random]
    }
}

//to do: alert doraditi u reusable functions, ovdje se ponavlja 2 puta
