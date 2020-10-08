//
//  UILabel.swift
//  Lotr
//
//  Created by Natalija Krsnik on 22/08/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func shadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
        //self.layer.shadowColor = UIColor.purple.cgColor
    }
}
