//
//  GamesLevelsVC.swift
//  Lotr
//
//  Created by Natalija Krsnik on 29/06/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class GamesLevelsVC: UIViewController {
    
    var safeArea: UILayoutGuide = UILayoutGuide()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets image and blur effect on background
        ReusableFunctions.shared.setTheme(view: self.view)
        
        //set nav text color and font
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.txtColorYellow, NSAttributedString.Key.font: UIFont(name: "Baskerville", size: 20)!]
        safeArea = view.layoutMarginsGuide
        
        setScreen()
    }
    
    let basicView: UIView = {
        let view = UIView()
        view.tag = 1
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return view
    }()
    
    let basicLabel: UILabel = {
        let label = UILabel()
        label.text = "Basic level"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Baskerville", size: 22)
        ReusableFunctions.shared.labelShadow(label: label, shadow: UIColor.white)
        return label
    }()
    
    
    let intermediateView: UIView = {
        let view = UIView()
        view.tag = 2
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return view
    }()
    
    let intermediateLabel: UILabel = {
        let label = UILabel()
        label.text = "Intermediate level"
        label.textColor = .darkGray
        label.font = UIFont(name: "Baskerville", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        ReusableFunctions.shared.labelShadow(label: label, shadow: UIColor.white)
        return label
    }()
    
    let advancedView: UIView = {
        let view = UIView()
        view.tag = 3
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return view
    }()
    
    let advancedLabel: UILabel = {
        let label = UILabel()
        label.text = "Advanced level"
        label.textColor = .darkGray
        label.font = UIFont(name: "Baskerville", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        ReusableFunctions.shared.labelShadow(label: label, shadow: UIColor.white)
        return label
    }()
    let expertView: UIView = {
        let view = UIView()
        view.tag = 4
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return view
    }()
    
    let expertLabel: UILabel = {
        let label = UILabel()
        label.text = "Expert level"
        label.textColor = .darkGray
        label.font = UIFont(name: "Baskerville", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        let levelPassed = defaults.bool(forKey: "levelPassed")
        let lastLevel = defaults.string(forKey: "lastLevel")
        
        if levelPassed == true {
            if lastLevel == "Basic" {
                intermediateView.layer.borderColor = UIColor.black.cgColor
                intermediateView.isUserInteractionEnabled = true
                intermediateLabel.textColor = .black
            }
            if lastLevel == "Intermediate" {
                intermediateView.layer.borderColor = UIColor.black.cgColor
                intermediateView.isUserInteractionEnabled = true
                intermediateLabel.textColor = .black
                
                advancedView.layer.borderColor = UIColor.black.cgColor
                advancedView.isUserInteractionEnabled = true
                advancedLabel.textColor = .black
            }
            if lastLevel == "Advanced" {
                intermediateView.layer.borderColor = UIColor.black.cgColor
                intermediateView.isUserInteractionEnabled = true
                intermediateLabel.textColor = .black
                
                advancedView.layer.borderColor = UIColor.black.cgColor
                advancedView.isUserInteractionEnabled = true
                advancedLabel.textColor = .black
                
                expertView.layer.borderColor = UIColor.black.cgColor
                expertView.isUserInteractionEnabled = true
                expertLabel.textColor = .black
            }
        }
    }
    
    func setScreen(){
        //set basicView
        basicView.frame = CGRect(x: 20, y: 100, width: self.view.frame.size.width - 30, height: 70)
        basicView.layer.cornerRadius = 10
        basicView.layer.borderColor = UIColor.black.cgColor
        basicView.layer.borderWidth = 0.5
        basicView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openBasicQuiz(_:))))
        basicView.addSubview(basicLabel)
        
        basicView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : basicLabel]))
        basicView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v1]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : basicLabel]))
        
        //set intermediateView
        intermediateView.frame = CGRect(x: 20, y: 200, width: self.view.frame.size.width - 30, height: 70)
        intermediateView.layer.cornerRadius = 10
        intermediateView.layer.borderColor = UIColor.darkGray.cgColor
        intermediateView.layer.borderWidth = 0.5
        intermediateView.isUserInteractionEnabled = false
        intermediateView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openIntermediateQuiz(_:))))
        intermediateView.addSubview(intermediateLabel)
        
        intermediateView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : intermediateLabel]))
        intermediateView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v1]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : intermediateLabel]))
        
        //set advancedView
        advancedView.frame = CGRect(x: 20, y: 300, width: self.view.frame.size.width - 30, height: 70)
        advancedView.layer.cornerRadius = 10
        advancedView.layer.borderColor = UIColor.darkGray.cgColor
        advancedView.layer.borderWidth = 0.5
        advancedView.isUserInteractionEnabled = false
        advancedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openAdvancedQuiz(_:))))
        advancedView.addSubview(advancedLabel)
        
        advancedView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : advancedLabel]))
        advancedView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v1]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : advancedLabel]))
        
        //set expertView
        expertView.frame = CGRect(x: 20, y: 400, width: self.view.frame.size.width - 30, height: 70)
        expertView.layer.cornerRadius = 10
        expertView.layer.borderColor = UIColor.darkGray.cgColor
        expertView.layer.borderWidth = 0.5
        expertView.isUserInteractionEnabled = false
        expertView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openExpertQuiz(_:))))
        expertView.addSubview(expertLabel)
        
        expertView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : expertLabel]))
        expertView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v1]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : expertLabel]))
        
        self.view.addSubview(basicView)
        self.view.addSubview(intermediateView)
        self.view.addSubview(advancedView)
        self.view.addSubview(expertView)
    }
    
    @objc func openBasicQuiz(_ sender: UITapGestureRecognizer? = nil){
        let vc = QuizVC()
        vc.levelPicked = Level.Basic
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func openIntermediateQuiz(_ sender: UITapGestureRecognizer? = nil){
        let vc = QuizVC()
        vc.levelPicked = Level.Intermediate
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func openAdvancedQuiz(_ sender: UITapGestureRecognizer? = nil){
        let vc = QuizVC()
        vc.levelPicked = Level.Advanced
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func openExpertQuiz(_ sender: UITapGestureRecognizer? = nil){
        let vc = QuizVC()
        vc.levelPicked = Level.Expert
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
//https://icons8.com/icons/set/sword - sword icon from icons8
