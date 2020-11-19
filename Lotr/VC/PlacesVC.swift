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
        //ReusableFunctions.shared.setTheme(view: self.view)
    
        setScreen()
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        return view
    }()
    
   
    let mapImage: UIImageView = {
        let img = UIImage(named: "middle")
        let imgView = UIImageView(image:img!)
        imgView.contentMode =  .scaleAspectFit
        return imgView
    }()
    
    var fangornView: UIImageView = {
       // let i = UIImage(named: "middle1")
        let img = UIImageView()//image:i)
        img.frame = CGRect(x: 1680, y: 1640, width: 30, height: 30)
        img.contentMode =  .scaleAspectFit
        img.layer.cornerRadius = img.frame.size.width / 2
        img.layer.borderColor = UIColor.yellow.cgColor
        img.layer.borderWidth = 5.0
        img.layer.masksToBounds = false
        img.clipsToBounds = true
        return img
    }()
    
    var rohanView: UIImageView = {
       // let i = UIImage(named: "middle1")
       // let img = UIImageView()//image:i)
        
         let i = UIImage(named: "circle")
         let img = UIImageView(image:i)
        img.frame = CGRect(x: 1815, y: 1690, width: 40, height: 40)
        img.tintColor = .yellow
        /*img.contentMode =  .scaleAspectFit
        img.layer.cornerRadius = img.frame.size.width / 2
        img.layer.borderColor = UIColor.green.cgColor
        img.layer.borderWidth = 5.0
        img.layer.masksToBounds = false
        img.clipsToBounds = true*/
        return img
    }()
    
    func setScreen(){
        
        self.view.backgroundColor = .mapBackground
        
        //nav text color and font
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.txtColorYellow, NSAttributedString.Key.font: UIFont(name: "Baskerville", size: 20)!]
        
        view.addSubview(scrollView)
        scrollView.addSubview(mapImage)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor ),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mapImage.topAnchor.constraint(equalTo: scrollView.topAnchor ),
            mapImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mapImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mapImage.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
        ])
        
        //set scrollView
        scrollView.maximumZoomScale = 6
        scrollView.minimumZoomScale = 0.3
        scrollView.delegate = self
        
        //to do: provjera za koordinate -trenutno, neće trebati dok završim pozicije
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(getCoord))
            tapGestureRecognizer.numberOfTapsRequired=2
        mapImage.isUserInteractionEnabled = true
        mapImage.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func fangornInfo(){
        let alert = UIAlertController(title: "Fangorn forrest", message: "Merry, Pippin ran into the forrest...", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }

    //postavljeno da skalira na početku veličinu slike, ne sviđa mi se ipak kak radi jer ne scrolla do kraja slike
    override func viewWillAppear(_ animated: Bool) {
        //scrollView.setZoomScale(-4, animated: true)
        scrollView.zoomScale = -1
        fangornView.isHidden = true
        rohanView.isHidden = true
    }
}


extension PlacesVC: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapImage
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        print("ZOOM SCALE:", scale)
        
        //fangorn tap
        let fangornTap = UITapGestureRecognizer(target: self, action: #selector(fangornInfo))
        fangornTap.numberOfTapsRequired = 2
        fangornView.isUserInteractionEnabled = true
        fangornView.addGestureRecognizer(fangornTap)
        
        //rohan tap
        let rohanTap = UITapGestureRecognizer(target: self, action: #selector(fangornInfo))
        rohanTap.numberOfTapsRequired = 2
        rohanView.isUserInteractionEnabled = true
        rohanView.addGestureRecognizer(rohanTap)
        
        mapImage.addSubview(fangornView)
        mapImage.bringSubviewToFront(fangornView)
        
        mapImage.addSubview(rohanView)
        mapImage.bringSubviewToFront(rohanView)
        
        if scale > 0.5 {
            fangornView.isHidden = false
            rohanView.isHidden = false
        }else{
            fangornView.isHidden = true
            rohanView.isHidden = true
        }
    }
    
    //get coordinates of screen click position, ovo više neće trebati dok riješim pozicije
    @objc func getCoord(sender: UITapGestureRecognizer){
        let touchPoint = sender.location(in: self.mapImage)
        print("TOUCH:", touchPoint.x, "," , touchPoint.y)
    }
}
