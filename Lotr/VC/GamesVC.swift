//
//  GamesVC.swift
//  Lotr
//
//  Created by Natalija Krsnik on 25/06/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class GamesVC: UIViewController {
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    let quizView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        return view
    }()
    
    let quizLabel: UILabel = {
        let label = UILabel()
        label.text = "Take the quiz"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Baskerville", size: 22)
        ReusableFunctions.shared.labelShadow(label: label, shadow: UIColor.white)
        return label
    }()
    
    let followStoryView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        return view
    }()
    
    let followStoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Follow the story"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Baskerville", size: 22)
        ReusableFunctions.shared.labelShadow(label: label, shadow: UIColor.white)
        return label
    }()
    
    
    let songView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return view
    }()
    
    let songLabel: UILabel = {
        let label = UILabel()
        label.text = "Songs"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Baskerville", size: 22)
        ReusableFunctions.shared.labelShadow(label: label, shadow: UIColor.white)
        return label
    }()
    
    let songLabelM: UILabel = {
        let label = UILabel()
        label.text = "Know all the songs and verses from the trilogy?"
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Baskerville", size: 18)
        ReusableFunctions.shared.labelShadow(label: label, shadow: UIColor.white)
        return label
    }()
    
    func setScreen(){
        
        //set quiz view
        quizView.frame = CGRect(x: 20, y: 100, width: self.view.frame.size.width - 30, height: 70)
        quizView.layer.cornerRadius = 10
        quizView.layer.borderColor = UIColor.black.cgColor
        quizView.layer.borderWidth = 0.5
        quizView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openQuizLevels(_:))))
        quizView.addSubview(quizLabel)
        
        quizView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : quizLabel]))
        
        quizView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : quizLabel]))
        
        //set follow story view
        followStoryView.frame = CGRect(x: 20, y: 200, width: self.view.frame.size.width - 30, height: 70)
        followStoryView.layer.cornerRadius = 10
        followStoryView.layer.borderColor = UIColor.black.cgColor
        followStoryView.layer.borderWidth = 0.5
        //followStoryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openQuizLevels(_:))))
        followStoryView.addSubview(followStoryLabel)
        
        followStoryView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : followStoryLabel]))
        
        followStoryView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : followStoryLabel]))
        
        //set song view
        songView.frame = CGRect(x: 20, y: 300, width: self.view.frame.size.width - 30, height: 100)
        songView.layer.cornerRadius = 10
        songView.layer.borderColor = UIColor.black.cgColor
        songView.layer.borderWidth = 0.5
        songView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.openSongGame(_:))))
        songView.addSubview(songLabel)
        songView.addSubview(songLabelM)
        
        songView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-[v1]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : songLabel, "v1" : songLabelM]))
        
        songView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : songLabel]))
        
        songView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v1]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : songLabelM]))
        
        self.view.addSubview(quizView)
        self.view.addSubview(followStoryView)
        self.view.addSubview(songView)
    }
    
    @objc func openQuizLevels(_ sender: UITapGestureRecognizer? = nil){
        
        let vc = GamesLevelsVC()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @objc func openSongGame(_ sender: UITapGestureRecognizer? = nil){
        let vc = SongsPVC()
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
}
