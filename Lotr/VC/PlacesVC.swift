//
//  PlacesVC.swift
//  Lotr
//
//  Created by Natalija Krsnik on 03/06/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class PlacesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //set image and blur effect
        ReusableFunctions.shared.setTheme(view: self.view)
        
        //nav text color and font
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.txtColorYellow, NSAttributedString.Key.font: UIFont(name: "Baskerville", size: 20)!]
    
    }
}
