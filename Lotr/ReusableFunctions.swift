//
//  ReusableFunctions.swift
//  Lotr
//
//  Created by Natalija Krsnik on 18/06/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation
import UIKit

let defaults = UserDefaults.standard

class ReusableFunctions {
   static let shared = ReusableFunctions() //Using singleton pattern
    
    //JSON LOCAL
    func readLocalJSONFile(name: String) -> Data? {
        do {
            if let path = Bundle.main.path(forResource: name, ofType: "json"),
                let jsonData = try String(contentsOfFile: path).data(using: .utf8){
                return jsonData
            }
        }catch{
            print(error)
        }
        
        return nil
    }
    
    //not used?
    func parseLocalJSON(jsonData : Data){
        let decoder = JSONDecoder()
        
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let jsonData = jsonData
            let result = try decoder.decode(Root.self, from: jsonData)
            
            let decodedData = result.character
            print("NAME:", decodedData)
        } catch {
            print(error)
            return
        }
    }
    
    /**
     Sets background image and color of master view.
     
     ImageView is defined and contains image of the background for our master view.
        
     The image will be blured using blur of whole view
     ( the image is not visible, but colors are more vivid).
     
     - Parameters:
        - view: self.view
    
     */
    func blurView(view: UIView){
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "lotr_background")
        backgroundImage.contentMode = .scaleAspectFit

        view.insertSubview(backgroundImage, at: 0)
        view.backgroundColor = UIColor(red: 198/255, green: 159/255, blue: 59/255, alpha: 1)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
    }
    
    
    /**
     Sets background image and color of master view.
     
     ImageView is defined and contains image of the background for our master view.
        
     The image will be blured using Gaussian blur effect.
    
     - Parameters:
        - view: self.view
    
     */
    func GaussianBlur(view: UIView){
        
        for v in view.subviews {
            if v is UIVisualEffectView {
                v.removeFromSuperview()
            }
        }
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "lotr_background")
        backgroundImage.contentMode = .scaleAspectFit
        
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: backgroundImage.image!)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(7, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
        
        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        backgroundImage.image = processedImage
        
        
        view.insertSubview(backgroundImage, at: 0)
        view.backgroundColor = UIColor(red: 198/255, green: 159/255, blue: 59/255, alpha: 1)
   
    }
    
    /**
        Set Gaussian blur or normal blur to background, depending on users choice in settings
     */
    func setTheme(view: UIView){
        if defaults.bool(forKey: "isThemeGaussian"){
            ReusableFunctions.shared.GaussianBlur(view: view)
        }else{
            ReusableFunctions.shared.blurView(view: view)
        }
    }
    
    /**
        Sets shadow on label
        - Parameters:
                - label: UILabel to which we want to add shadow
                - shadow: color of the shadow
    */
    func labelShadow(label: UILabel, shadow: UIColor?) {
        label.layer.shadowOffset = CGSize(width: 1, height: 1)
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 2
        label.layer.shadowColor = shadow?.cgColor
    }
}
