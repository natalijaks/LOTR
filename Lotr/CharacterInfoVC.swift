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
        let view = UIScrollView()//frame:.zero)
        view.backgroundColor = .clear
        //view.contentSize = contentView
        //view.frame = self.view.bounds
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
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /** Contains character image */
    let characterImage: UIImageView = {
        let img = UIImage(named: "circle")
        let imgView = UIImageView(image:img!)
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = .black
        imgView.layer.masksToBounds = true
        
        imgView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return imgView
    }()

    /**
     Fills character data into labels.
     
     If some data not exists in json, label that should contain this data will be hidden
     
     Data provided from characters.json , trough CharactersVC's on cell press (trough pushViewController)
     */
    func fillData(){
        nameLabel.text = characterInfo!.name! + " " + (characterInfo?.lastname ?? "")
        fullnameLabel.text = "FULL NAME: " +  (characterInfo?.fullName ?? characterInfo!.name!)
        
        var aliases:String = ""
        var weaponsName: String = ""
        var weapons: [Weapons] = []
        
        //image
        
        let savedImage = retrieveImg(forKey: (characterInfo!.name)!,
                                     inStorageType: .fileSystem)
        //image should by now already exist localy. If not, return eye image
        if savedImage != nil {
            DispatchQueue.main.async {
                self.characterImage.image = savedImage
            }
        }else{
            self.characterImage.image = UIImage(named: "circle")
            self.characterImage.tintColor = .black
        }
        
        //alias
        if characterInfo?.alias != [""] {
            for (i,element) in characterInfo!.alias.enumerated() {
                if i == 0  { aliases = aliases + " " + element!}
                else {aliases = aliases + ", " + element!}
            }
            aliasLabel.text = "ALSO CALLED : " + aliases
            aliasLabel.isHidden = false
        }else{
            aliasLabel.isHidden = true
        }
        
        //kind
        if characterInfo?.kind != nil {
            kindLabel.text = "KIND: " + (characterInfo?.kind).map { $0.rawValue }!
        }
        
        //side
        if characterInfo?.side != nil {
            sideLabel.text = "FIGHTS ON THE SIDE: " + (characterInfo?.side).map { $0.rawValue }!
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
            weaponLabel.text = "FIGHTS WITH: " + weaponsJoined
        }
        
        //weapons name
        if characterInfo?.weaponName != [""] {
            for i in characterInfo!.weaponName {
                weaponsName += i!
            }
            weaponNameLabel.text = "WEAPONS NAMES: [" +  weaponsName + "]"
            weaponNameLabel.isHidden = false
        }else{
            weaponNameLabel.isHidden = true
        }
        
        //description
        descriptionLabel.text = characterInfo?.description
    }
    
    func setNavItems(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Quotes", style: .plain, target: self, action: #selector(openQuotes))
    }
    
    @objc func openQuotes(){
        print("OPEN QUOTES FROM CHARACTER")
    }
    
    /**Sets elements and their constraints
     */
    func setScreen(){
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 219/255, green: 186/255, blue: 76/255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "Baskerville", size: 20)!]
        self.navigationController?.title = characterInfo?.name
        
        setNavItems()
       // scrollView.frame = CGRect(x: 0, y: view.frame.height/2, width: self.view.frame.width, height: self.view.frame.height/2 - 100)
        
        view.addSubview(infoView)
        view.addSubview(scrollView)
        view.bringSubviewToFront(infoView)
        
        infoView.addSubview(characterImage)
        infoView.addSubview(nameLabel)
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate([
            infoView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            infoView.leftAnchor.constraint(equalTo: view.leftAnchor),
            infoView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            characterImage.topAnchor.constraint(equalTo: infoView.topAnchor),
            //characterImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant:  10),
            //characterImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            characterImage.widthAnchor.constraint(equalToConstant: 200),
            characterImage.heightAnchor.constraint(equalToConstant: 200),
            characterImage.centerXAnchor.constraint(lessThanOrEqualTo: self.view.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scrollView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
           

        ])
        
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
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo:scrollView.bottomAnchor, constant: -20),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.readableContentGuide.leadingAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: scrollView.readableContentGuide.rightAnchor)
        ])
        
        
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[v2]-10-[v3]-10-[v4]-10-[v5]-10-[v6]-10-[v7]-10-[v8]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v2": fullnameLabel, "v3": aliasLabel, "v4": kindLabel, "v5": sideLabel, "v6": weaponLabel,"v7": weaponNameLabel,"v8": descriptionLabel]))
        
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v2]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v2" : fullnameLabel]))
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v3]-30-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v3" : aliasLabel]))
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v4]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v4" : kindLabel]))
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v5]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v5" : sideLabel]))
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v6]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v6" : weaponLabel]))
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v7]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v7" : weaponNameLabel]))
        masterView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[v8]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v8" : descriptionLabel]))
        
        
        //fullnameLabel.centerXAnchor.constraint(equalTo: self.masterView.centerXAnchor).isActive = true
        
    }
}
