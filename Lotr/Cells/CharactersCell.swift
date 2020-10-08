//
//  CharactersCell.swift
//  Lotr
//
//  Created by Natalija Krsnik on 10/06/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

class CharactersCell: UITableViewCell {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont(name: "Baskerville", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let lastnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Baggins"
        label.textColor = .black
        label.font = UIFont(name: "Baskerville", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let characterImage: UIImageView = {
        let img = UIImage(named: "lotr_eye")
        let imgView = UIImageView(image:img!)
        imgView.layer.cornerRadius = 25
        imgView.layer.masksToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 10, y: 5, width: 50, height: 50)
        return imgView
    }()

    func setupViews(){
        
        self.backgroundColor = .clear
        addSubview(characterImage)
        addSubview(nameLabel)
        addSubview(lastnameLabel)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-70-[v0]-5-[v1]", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : nameLabel, "v1" : lastnameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0" : nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v1]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1" : lastnameLabel]))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
