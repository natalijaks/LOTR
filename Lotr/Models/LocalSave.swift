//
//  LocalSave.swift
//  Lotr
//
//  Created by Natalija on 26/10/2020.
//  Copyright © 2020 Natalija. All rights reserved.
//

import Foundation
import UIKit


enum StorageType {
    case userDefaults
    case fileSystem
}


func store(image: UIImage, forKey key: String, withStorageType storageType: StorageType){
    if let pngRepresentation = image.pngData() { //.pngData() returns a data object that contains the specified image in PNG format
        switch storageType {
        case .fileSystem:
            if let filePath = filePath(forKey: key) {
                do  {
                    try pngRepresentation.write(to: filePath,
                                                options: .atomic)
                } catch let err {
                    print("Saving file resulted in error: ", err)
                }
            }
        case .userDefaults:
            //save to user defaults
            defaults.set(pngRepresentation, forKey: key)
        }
    }
}


func retrieveImg(forKey key: String, inStorageType storageType: StorageType) -> UIImage?{
    switch storageType {
    case .fileSystem:
        if let filePath = filePath(forKey: key),
           let fileData = FileManager.default.contents(atPath: filePath.path),
           let image = UIImage(data: fileData) {
            return image
        }
    case .userDefaults:
        if let imageData = defaults.object(forKey: key) as? Data,
           let image = UIImage(data: imageData) {
            
            return image
        }
    }
    return nil
}

// get the url for the home directory on the device, append key.png to the url and return that value
private func filePath(forKey key: String) -> URL? {
    //.documentDirectory is a significant location (directory location) from FileManager
    guard let documentURL = FileManager.default.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
    
    return documentURL.appendingPathComponent(key + ".png")
}
