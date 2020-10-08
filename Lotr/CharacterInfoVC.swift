//
//  CharacterInfoVC.swift
//  Lotr
//
//  Created by Natalija Krsnik on 18/06/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class CharacterInfoVC: UIViewController {
    var name = ""
    var characterInfo: Characters?
    var safeArea: UILayoutGuide = UILayoutGuide()
    var masterView = UIView()
    var infoView = UIView()
    lazy var contentView = CGSize(width: view.frame.width, height: view.frame.height + 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        //sets image and blur effect on background
        ReusableFunctions.shared.setTheme(view: self.view)
        
        safeArea = view.layoutMarginsGuide
        setScreen()
        fillData()
    }
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame:.zero)
        view.backgroundColor = .clear
        view.contentSize = contentView
        view.frame = self.view.bounds
        return view
    }()
    
    /** Contains character first and last name */
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Savoye Let", size: 50)
        return label
    }()
    
    /**Contains character first and last full name */
    let fullnameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /**Contains aliases, names by which the characters were known */
    let aliasLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /**
     Contains enum values which represent the kind to which the character belongs
     
     Can be: Elf, Man, Dwarf, Hobbit, Ent, Orc, Troll, Wizard, Balrog, Ringwraith, Other*/
    let kindLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /**
     Contains enum values which represent the side to which the character belongs
     
     Can be: Villain, Ally, Both, Unknown
     */
    let sideLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /**
     Contains enum values of weapons
     
     Can be: Sword, Knive, Axe, Bow, Arrow, Armour, Helmet
     */
    let weaponLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /** Contains names of some weapons ( like Andúril) */
    let weaponNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /** Contains some description of the character */
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /** Contains character image */
    let characterImage: UIImageView = {
        let img = UIImage(named: "lotr_eye")
        let imgView = UIImageView(image:img!)
        // imgView.contentMode = .scaleAspectFit
        imgView.layer.cornerRadius = 100
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        
        imgView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return imgView
    }()
    
    let characterImage2: UIImageView = {
        let img = UIImage(named: "lotr_eye")
        let imgView = UIImageView(image:img!)
        imgView.layer.cornerRadius = 25
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        return imgView
    }()
    
    let characterImage3: UIImageView = {
        let img = UIImage(named: "lotr_eye")
        let imgView = UIImageView(image:img!)
        imgView.layer.cornerRadius = 30
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 50, y: 50, width: 15, height: 15)
        return imgView
    }()
    
    let characterImage4: UIImageView = {
        let img = UIImage(named: "lotr_eye")
        let imgView = UIImageView(image:img!)
        imgView.layer.cornerRadius = 35
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return imgView
    }()
    
    let characterImage5: UIImageView = {
        let img = UIImage(named: "lotr_eye")
        let imgView = UIImageView(image:img!)
        imgView.layer.cornerRadius = 40
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 50, y: 50, width: 20, height: 20)
        return imgView
    }()
    
    let characterImage6: UIImageView = {
        let img = UIImage(named: "lotr_eye")
        let imgView = UIImageView(image:img!)
        imgView.layer.cornerRadius = 25
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return imgView
    }()
    
    let characterImage7: UIImageView = {
        let img = UIImage(named: "lotr_eye")
        let imgView = UIImageView(image:img!)
        imgView.layer.cornerRadius = 25
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 50, y: 50, width: 20, height: 20)
        return imgView
    }()
    
    let characterImage8: UIImageView = {
        let img = UIImage(named: "lotr_eye")
        let imgView = UIImageView(image:img!)
        imgView.layer.cornerRadius = 25
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return imgView
    }()
    
    let characterImage9: UIImageView = {
        let img = UIImage(named: "lotr_eye")
        let imgView = UIImageView(image:img!)
        imgView.layer.cornerRadius = 25
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 50, y: 50, width: 20, height: 20)
        return imgView
    }()
    /**
     Fills character data into labels.
     
     If some data not exists in json, label that should contain this data will be hidden
     
     Data provided from characters.json , trough CharactersVC's on cell press (trough pushViewController)
     */
    func fillData(){
        nameLabel.text = characterInfo!.name! + " " + (characterInfo?.lastname ?? "")
        fullnameLabel.text = characterInfo?.fullName
        
        var aliases:String = ""
        var weaponsName: String = ""
        var weapons: [Weapons] = []
        
        //image
        if characterInfo?.urlToimage != "" {
            //create url
            let url = URL(string:(characterInfo?.urlToimage)!)
            
            let d = URLSession.shared.dataTask(with: url!) { [weak self] (data, _, _) in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.characterImage.image = UIImage(data: data)
                        self?.characterImage2.image = UIImage(data: data)
                        self?.characterImage3.image = UIImage(data: data)
                        self?.characterImage4.image = UIImage(data: data)
                        self?.characterImage5.image = UIImage(data: data)
                    }
                }
            }   
            d.resume()
        }
        
        //alias
        if characterInfo?.alias != [""] {
            for (i,element) in characterInfo!.alias.enumerated() {
                if i == 0  { aliases = aliases + " " + element!}
                else {aliases = aliases + ", " + element!}
            }
            aliasLabel.text = "Alias: " + aliases
            aliasLabel.isHidden = false
        }else{
            aliasLabel.isHidden = true
        }
        
        //kind
        if characterInfo?.kind != nil {
            kindLabel.text = "Kind: " + (characterInfo?.kind).map { $0.rawValue }!
        }
        
        //side
        if characterInfo?.side != nil {
            sideLabel.text = "Side: " + (characterInfo?.side).map { $0.rawValue }!
        }
        
        //weapons
        if characterInfo?.weapons != [] {
            
            for i in characterInfo!.weapons {
                weapons.append((i!))
            }
        }
        if weapons.count > 0 {
            let weaponList = weapons.map{$0.rawValue}
            let weaponsJoined = weaponList.joined(separator: ", ")
            weaponLabel.text = "Weapons: " + weaponsJoined
        }
        
        //weapons name
        if characterInfo?.weaponName != [""] {
            for i in characterInfo!.weaponName {
                weaponsName += i!
            }
            weaponNameLabel.text = "[" +  weaponsName + "]"
            weaponNameLabel.isHidden = false
        }else{
            weaponNameLabel.isHidden = true
        }
        
        //description
        descriptionLabel.text = characterInfo?.description
    }
    
    /**Sets elements and their constraints
     */
    func setScreen(){
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 219/255, green: 186/255, blue: 76/255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "Baskerville", size: 20)!]
        self.navigationController?.title = characterInfo?.name
        
        scrollView.frame = CGRect(x: 0, y: 450, width: self.view.frame.width, height: self.view.frame.height/2 - 100)
        
        view.addSubview(infoView)
        view.addSubview(scrollView)
        view.bringSubviewToFront(infoView)
        
        infoView.addSubview(characterImage)
        infoView.addSubview(characterImage2)
        infoView.addSubview(characterImage3)
        infoView.addSubview(characterImage4)
        infoView.addSubview(characterImage5)
        
        infoView.addSubview(nameLabel)
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        infoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        infoView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        infoView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(>=20)-[v1]-(>=20)-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : nameLabel]))
        infoView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-260-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : nameLabel]))
        
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        characterImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        characterImage.centerXAnchor.constraint(lessThanOrEqualTo: self.view.centerXAnchor).isActive = true
        
        characterImage2.frame = CGRect(x: self.view.frame.width/6, y: 0, width: 50, height: 50)
        
        characterImage3.frame = CGRect(x: self.view.frame.width/10, y: self.view.frame.height/18, width: 60, height: 60)
        nameLabel.centerXAnchor.constraint(equalTo: self.infoView.centerXAnchor).isActive = true
        
        characterImage4.frame = CGRect(x: self.view.frame.width/10, y: self.view.frame.height/8, width: 70, height: 70)
        nameLabel.centerXAnchor.constraint(equalTo: self.infoView.centerXAnchor).isActive = true
        
        characterImage5.frame = CGRect(x: self.view.frame.width/5, y: self.view.frame.height/5.1, width: 75, height: 75)
               nameLabel.centerXAnchor.constraint(equalTo: self.infoView.centerXAnchor).isActive = true
        
        //scroll view
        scrollView.addSubview(masterView)
        
        masterView.backgroundColor = .clear
        masterView.frame.size = contentView
        masterView.addSubview(fullnameLabel)
        masterView.addSubview(aliasLabel)
        masterView.addSubview(kindLabel)
        masterView.addSubview(sideLabel)
        masterView.addSubview(weaponLabel)
        masterView.addSubview(weaponNameLabel)
        masterView.addSubview(descriptionLabel)
        
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v2]-10-[v3]-10-[v4]-10-[v5]-10-[v6]-10-[v7]-10-[v8]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v2": fullnameLabel, "v3": aliasLabel, "v4": kindLabel, "v5": sideLabel, "v6": weaponLabel,"v7": weaponNameLabel,"v8": descriptionLabel]))
        
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v3]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v3" : aliasLabel]))
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v4]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v4" : kindLabel]))
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v5" : sideLabel]))
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v6]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v6" : weaponLabel]))
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v7]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v7" : weaponNameLabel]))
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v8]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v8" : descriptionLabel]))
        
        
        fullnameLabel.centerXAnchor.constraint(equalTo: self.masterView.centerXAnchor).isActive = true
        
    }
}
