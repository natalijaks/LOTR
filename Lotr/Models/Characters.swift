//
//  Characters.swift
//  Lotr
//
//  Created by Natalija Krsnik on 04/06/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import UIKit

struct Root: Decodable {
    let character:[Characters]
}

class Characters: Codable {
    var id: String
    var name: String?
    var alias: [String?]
    var lastname: String?
    var fullName: String?
    var kind: Kind
    var side: Side
    var urlToimage: String?
    var weapons: [Weapons?]
    var weaponName: [String?]
    var description: String?
    
    init?(id: String, name: String, alias: [String?], lastname: String?,fullName: String?, kind:Kind, side: Side, urlToimage: String?, weapons: [Weapons?], weaponName: [String?], description: String){
         
        if name.isEmpty { return nil }
        
        self.id = id
        self.name = name
        self.alias = alias
        self.lastname = lastname
        self.fullName = fullName
        self.kind = kind
        self.side = side
        self.urlToimage = urlToimage
        self.weapons = weapons
        self.weaponName = weaponName
        self.description = description
    }
}

enum Kind: String, Codable {
    case Elf = "Elf"
    case Man = "Man"
    case Dwarf = "Dwarf"
    case Hobbit = "Hobbit"
    case Ent = "Ent"
    case Orc = "Orc"
    case Troll = "Troll"
    case Wizard = "Wizard"
    case Balrog = "Balrog"
    case Ringwraith = "Ringwraith"
    case Maia = "Maia"
    case Other = "Other kind"
}

enum Side: String, Codable {
    case Villain = "Villain"
    case Ally = "Ally"
    case Both = "Both"
    case Unknown = "Unknown side"
}

enum Weapons: String, Codable {
    case Sword = "Sword"
    case Knive = "Knive"
    case Axe = "Axe"
    case Bow = "Bow"
    case Arrow = "Arrow"
    case Armour = "Armour"
    case Helmet = "Helmet"
    case Magic = "Magic"
    case Staff = "Staff"
    case Words = "Words"
    case Poison = "Poison"
}
