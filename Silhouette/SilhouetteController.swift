//
//  SilhouetteController.swift
//  Silhouette
//
//  Created by Burns, Robert A on 7/21/17.
//  Copyright © 2017 Burns5. All rights reserved.
//

import Foundation

class SilhouetteController: NSObject {
    static let sharedInstance = SilhouetteController()

    var custom_silhouette: String = ""
    var default_silhouette: String = ""

    let fileManager = FileManager.default

    func customSilhouetteExists() -> Bool {
        return fileManager.fileExists(atPath: custom_silhouette)
    }

    func initialize() {
        if (!customSilhouetteExists()) {
            retrieveDefaultSilhouette()
        }
    }

    func retrieveDefaultSilhouette() {
        removeCustomSilhouette()
        do {
            try fileManager.copyItem(atPath: default_silhouette, toPath: custom_silhouette)
        }
        catch let error as NSError {
            NSLog("An error has occurred \(error)")
        }
    }

    func retrieveCustomSilhouette(_ new_silhouette: String) {
        removeCustomSilhouette()
        do {
            try fileManager.copyItem(atPath: new_silhouette, toPath: custom_silhouette)
        }
        catch let error as NSError {
            NSLog("An error has occurred \(error)")
        }
    }

    func removeCustomSilhouette() {
        if (customSilhouetteExists()) {
            do {
                try fileManager.removeItem(atPath: custom_silhouette)
            }
            catch let error as NSError {
                NSLog("An error has occurred \(error)")
            }
        }
    }

    fileprivate override init() {
        custom_silhouette = String(format:"%@/html/assets/img/silhouette.png", Bundle(for: type(of: self)).resourcePath!)
        default_silhouette = String(format:"%@/html/assets/img/default.png", Bundle(for: type(of: self)).resourcePath!)
    }

}
