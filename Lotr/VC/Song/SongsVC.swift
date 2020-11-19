//
//  SongsVC.swift
//  Lotr
//
//  Created by Natalija on 12/11/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit
import AVFoundation

class SongsVC: UIViewController {

    var song: AVAudioPlayer?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellow
        
        setElementsOnScreen()
        
    }
    
    let songButton: UIButton = {
       let btn = UIButton()
        btn.setTitle("Song name", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.black.cgColor
        btn.backgroundColor = .transparentWhite//.txtColorYellow
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(playSongBtn(_:)), for: .touchUpInside)
        return btn
    }()
    
    // Play song on button press
    @objc func playSongBtn(_ sender: UIButton){
        do {
            let sound = Bundle.main.path(forResource: "SauronsTheme", ofType: "m4a")

            song = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            song?.play()
        }catch{
            print("Error loading song file:", error)
        }
        
    }
    
    func setElementsOnScreen(){
       
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "middleYellow")
        backgroundImage.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        self.view.addSubview(songButton)
        
        songButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            songButton.widthAnchor.constraint(equalToConstant: 200),
            songButton.heightAnchor.constraint(equalToConstant: 100),
            songButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        song?.stop()
    }
    
}
