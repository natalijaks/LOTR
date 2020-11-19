//
//  Songs2VC.swift
//  Lotr
//
//  Created by Natalija on 12/11/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class Songs2VC: UIViewController, UIPickerViewDelegate{
    let pickerA = UIPickerView()
    let pickerB = UIPickerView()
    let pickerC = UIPickerView()
    let pickerD = UIPickerView()
    let pickerE = UIPickerView()
    
    let pickerAtxt = ["(A)", "far", "behind", "far away", "beyond", "ahead"]
    let pickerBtxt = ["(B)", "trails", "ways", "paths", "routes", "roads"]
    let pickerCtxt = ["(C)", "shadow", "darkness", "shade", "twilight", "gloaming"]
    let pickerDtxt = ["(D)", "paths", "trails", "stars", "planets", "heavens"]
    let pickerEtxt = ["(E)", "Fog", "Smog", "Steam", "Drizzle", "Mist"]
    
    var pickedA: String = "(A)"
    var pickedB:String = "(B)"
    var pickedC:String = "(C)"
    var pickedD:String = "(D)"
    var pickedE:String = "(E)"
    
    var globalPoints: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setElementsOnScreen()
    }
    
    let songTxtView: UITextView = {
        let lbl = UITextView()
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.textColor = .black
        lbl.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        lbl.layer.cornerRadius = 10
        return lbl
        
    }()

    let ringImage: UIImageView = {
        let img = UIImage(named: "circle")
        let imgView = UIImageView(image:img!)
        imgView.contentMode = .scaleAspectFit
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    func setElementsOnScreen(){
       
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "middleYellow")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.view.addSubview(ringImage)
        ringImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ringImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5),
            ringImage.widthAnchor.constraint(equalToConstant: 20),
            ringImage.heightAnchor.constraint(equalToConstant: 50),
            ringImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            ringImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
        songSetupAndConst()
        pickerSetupAndConst()
    }
    
    func songSetupAndConst(){
        self.view.addSubview(songTxtView)
        
        songTxtView.translatesAutoresizingMaskIntoConstraints = false
        songTxtView.sizeToFit()
        songTxtView.isScrollEnabled = false
        
        NSLayoutConstraint.activate([
            //songTxtView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            songTxtView.topAnchor.constraint(equalTo: ringImage.bottomAnchor, constant: 10),
            songTxtView.widthAnchor.constraint(equalToConstant: self.view.bounds.width - 20),
            songTxtView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    func pickerSetupAndConst(){
        
        self.view.addSubview(pickerA)
        self.view.addSubview(pickerB)
        self.view.addSubview(pickerC)
        self.view.addSubview(pickerD)
        self.view.addSubview(pickerE)
        
        pickerA.delegate = self
        pickerB.delegate = self
        pickerC.delegate = self
        pickerD.delegate = self
        pickerE.delegate = self
        pickerA.translatesAutoresizingMaskIntoConstraints = false
        pickerB.translatesAutoresizingMaskIntoConstraints = false
        pickerC.translatesAutoresizingMaskIntoConstraints = false
        pickerD.translatesAutoresizingMaskIntoConstraints = false
        pickerE.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
           
            //picker A constraints
            pickerA.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pickerA.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pickerA.topAnchor.constraint(equalTo: songTxtView.bottomAnchor),
            pickerA.heightAnchor.constraint(equalToConstant: 70),
            
            //picker B constraints
            pickerB.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pickerB.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pickerB.topAnchor.constraint(equalTo: pickerA.bottomAnchor),
            pickerB.heightAnchor.constraint(equalToConstant: 70),
            
            //picker C constraints
            pickerC.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pickerC.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pickerC.topAnchor.constraint(equalTo: pickerB.bottomAnchor),
            pickerC.heightAnchor.constraint(equalToConstant: 70),
            
            //picker D constraints
            pickerD.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pickerD.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pickerD.topAnchor.constraint(equalTo: pickerC.bottomAnchor),
            pickerD.heightAnchor.constraint(equalToConstant: 70),
            
            //picker E constraints
            pickerE.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pickerE.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pickerE.topAnchor.constraint(equalTo: pickerD.bottomAnchor),
            pickerE.heightAnchor.constraint(equalToConstant: 70),

        ])
        
    }
    
}

extension Songs2VC: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 25
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        songTxtView.text = "Home is (A), the world ahead\nAnd there are many (B) to tread\nThrough (C), to the edge of night\nUntil the (D) are all alight\n(E) and shadow\nCloud and shade\nAll shall fade\nAll shall fade"
        
        if pickerView == pickerA {
            return pickerAtxt[row]
        }
        else if pickerView == pickerB{
            return pickerBtxt[row]
        }
        else if pickerView == pickerC{
            return pickerCtxt[row]
        }
        else if pickerView == pickerD{
            return pickerDtxt[row]
        }
        else if pickerView == pickerE{
            return pickerEtxt[row]
        }
        else {
            return ("Error")
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var points = 0
        
        if pickerView == pickerA {
            pickedA = pickerAtxt[row]
        }
        else  if pickerView == pickerB {
            pickedB = pickerBtxt[row]
        }
        else  if pickerView == pickerC {
            pickedC = pickerCtxt[row]
        }
        else  if pickerView == pickerD {
            pickedD = pickerDtxt[row]
        }
        else  if pickerView == pickerE {
            pickedE = pickerEtxt[row]
        }
        
        songTxtView.text = "Home is " + pickedA + ", the world ahead\nAnd there are many " + pickedB + " to tread\nThrough " + pickedC + ", to the edge of night\nUntil the " + pickedD + " are all alight\n" + pickedE + " and shadow\nCloud and shade\nAll shall fade\nAll shall fade"
        
        if pickerView == pickerA{
            if pickedA == "behind"{ points += 1 }
            else{ points = 0}
            globalPoints = points
        }
        
        else if pickerView == pickerB{
            if pickedB == "paths"{ points += 1 }
            else{ points = 0 }
            globalPoints += points
        }
        else if pickerView == pickerC{
            if pickedC == "shadow"{ points += 1 }
            else{  points = 0 }
            globalPoints += points
        }
        else if pickerView == pickerD{
            if pickedD == "stars"{ points += 1 }
            else {points = 0 }
            globalPoints += points
        }
        else if pickerView == pickerE{
            if pickedE == "Mist"{ points += 1 }
            else { points = 0}
            globalPoints += points
        }

        print("points:", globalPoints)
        switch  globalPoints {
        case 1:
            ringImage.tintColor = UIColor(red: 0/255, green: 0/255, blue: 128/255, alpha: 1)// navy blue
        case 2:
            ringImage.tintColor = UIColor(red: 139/255, green: 69/255, blue: 19/255, alpha: 1)//blue
        case 3:
            ringImage.tintColor = UIColor(red: 0/255, green: 0/255, blue: 255/255, alpha: 1)//sadle brown
        case 4:
            ringImage.tintColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)//gray
        case 5:
            ringImage.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)//white
        default:
            ringImage.tintColor = .clear
        }
        
    }
    
}

// ring image from: https://www.subpng.com/png-8m2tpx/download.html
