//
//  ConfigureSheet.swift
//  Silhouette
//
//  Created by Burns, Robert A on 7/21/17.
//  Copyright © 2017 Burns5. All rights reserved.
//

import ScreenSaver

class ConfigureSheetController: NSObject {

    static var sharedInstance = ConfigureSheetController()
    var silhouetteController = SilhouetteController.sharedInstance

    @IBOutlet var window: NSWindow!
    @IBOutlet var silhouetteImage: NSImageView!
    @IBOutlet weak var silhouetteFile: NSButton!

    override init()
    {
        super.init()

        let myBundle = Bundle(for: ConfigureSheetController.self)
        myBundle.loadNibNamed("ConfigureSheet", owner: self, topLevelObjects: nil)
        previewSilhouette()
    }

    @IBAction func closeConfigureSheet(_ sender: NSButton)
    {
        window.sheetParent!.endSheet(window, returnCode: (sender.tag == 1) ? NSModalResponseOK : NSModalResponseCancel)
    }

    @IBAction func resetDefaults(_ sender: NSButton)
    {
        silhouetteController.retrieveDefaultSilhouette()
        previewSilhouette()
    }

    @IBAction func browseSilhouetteFile(_ sender: NSButton)
    {
        let custom_silhouette = selectSilhouetteFile()
        if (custom_silhouette != "") {
            silhouetteController.retrieveCustomSilhouette(custom_silhouette)
        }
        previewSilhouette()
    }

    fileprivate func previewSilhouette() {
        silhouetteImage.image = NSImage(byReferencingFile: silhouetteController.custom_silhouette)
        silhouetteImage.image!.isTemplate = true
        silhouetteImage.imageScaling = .scaleProportionallyUpOrDown
    }

    func selectSilhouetteFile() -> String {
        let browser: NSOpenPanel = NSOpenPanel()

        browser.allowsMultipleSelection = false
        browser.canChooseFiles = true
        browser.canChooseDirectories = false
        browser.showsHiddenFiles = true
        browser.allowedFileTypes = ["png"]

        let i = browser.runModal()

        let url = browser.url
        let path: String

        if (url != nil) {
            path = url!.path
        } else {
            path = ""
        }

        if (i == NSModalResponseOK) {
            return path
        } else {
            return ""
        }
    }

}
