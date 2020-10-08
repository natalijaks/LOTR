//
//  SettingsVC.swift
//  Lotr
//
//  Created by Natalija Krsnik on 25/06/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    let themeView: UIView = {
        let tv = UIView()
        tv.backgroundColor = .clear
        tv.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return tv
    }()
    
    let themeLabel: UILabel = {
           let label = UILabel()
           label.text = "Gaussian blur"
           label.textColor = .black
           label.translatesAutoresizingMaskIntoConstraints = false
           
           return label
    }()
    
    
    
    let themeSwitch: UISwitch = {
        let ts = UISwitch()
        ts.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        ts.addTarget(self, action: #selector(onThemeSwitch), for: .valueChanged)
        return ts
    }()
    
    let icons8View: UIView = {
           let tv = UIView()
           tv.backgroundColor = .clear
           tv.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
           return tv
       }()
    let icons8Label: UILabel = {
           let label = UILabel()
           label.text = "Images from icons8 (https://icons8.com)"
           label.textColor = .black
           label.translatesAutoresizingMaskIntoConstraints = false
           label.font = UIFont(name: "Baskerville", size: 15)
           return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //sets image and blur effect on background
       ReusableFunctions.shared.setTheme(view: self.view)

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.txtColorYellow, NSAttributedString.Key.font: UIFont(name: "Baskerville", size: 20)!]
        
        setScreen()
        //ReusableFunctions.shared.setTheme(view: self.view)
    }

    func setScreen(){
        
        //set theme view
        themeView.frame = CGRect(x: 20, y: 100, width: self.view.frame.size.width - 30, height: 50)
        themeView.layer.cornerRadius = 10
        themeView.layer.borderColor = UIColor.black.cgColor
        themeView.layer.borderWidth = 0.5
        
        themeView.addSubview(themeLabel)
        themeView.addSubview(themeSwitch)
        
        
        themeView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : themeLabel]))
        themeView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v1]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : themeSwitch]))
        
        themeView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : themeLabel]))
        themeSwitch.frame = CGRect(x: self.view.frame.size.width/1.5, y: 10, width: 20, height: 20)
        
        //set icons8 view
        icons8View.frame = CGRect(x: 20, y: self.view.frame.size.height - 120, width: self.view.frame.size.width - 30, height: 50)
        icons8View.addSubview(icons8Label)
        
        self.view.addSubview(themeView)
        self.view.addSubview(icons8View)
        
    }
    
    @objc func onThemeSwitch(_ sender: UISwitch){
        print("IS G:", sender.isOn)
        
       /* defaults.set(sender.isOn, forKey: "isThemeGaussian")
        if defaults.bool(forKey: "isThemeGaussian"){
            ReusableFunctions.shared.GaussianBlur(view: self.view)
        }else{
            ReusableFunctions.shared.blurView(view: self.view)
        }*/
        
    }

}
