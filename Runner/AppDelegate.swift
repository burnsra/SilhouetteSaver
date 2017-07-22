//
//  AppDelegate.swift
//  Runner
//
//  Created by Burns, Robert A on 7/21/17.
//  Copyright © 2017 Burns5. All rights reserved.
//

import Cocoa
import ScreenSaver

@NSApplicationMain
class AppDelegate: NSObject {

    @IBOutlet weak var window: NSWindow!

    var view: ScreenSaverView!

    func setupAndStartAnimation()
    {
        let saverName = UserDefaults.standard.string(forKey: "saver") ?? "Silhouette"

        guard let saverBundle = loadSaverBundle(saverName) else {
            NSLog("Can't find or load bundle for saver named \(saverName).")
            return
        }
        let saverClass = saverBundle.principalClass! as! ScreenSaverView.Type

        view = saverClass.init(frame: window.contentView!.frame, isPreview: false)
        view.autoresizingMask = [NSAutoresizingMaskOptions.viewWidthSizable, NSAutoresizingMaskOptions.viewHeightSizable]

        window.backingType = saverClass.backingStoreType()
        window.title = view.className
        window.contentView!.autoresizesSubviews = true
        window.contentView!.addSubview(view)

        view.startAnimation()
    }

    private func loadSaverBundle(_ name: String) -> Bundle?
    {
        let myBundle = Bundle(for: AppDelegate.self)
        let saverBundleURL = myBundle.bundleURL.deletingLastPathComponent().appendingPathComponent("\(name).saver", isDirectory: true)
        let saverBundle = Bundle(url: saverBundleURL)
        saverBundle?.load()
        return saverBundle
    }

    func restartAnimation()
    {
        stopAnimation()
        view.startAnimation()
    }

    func stopAnimation()
    {
        if view.isAnimating {
            view.stopAnimation()
        }
    }

}


extension AppDelegate: NSApplicationDelegate
{
    func applicationDidFinishLaunching(_ notification: Notification)
    {
        setupAndStartAnimation()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        stopAnimation()
    }
}


extension AppDelegate: NSWindowDelegate
{
    override func awakeFromNib() {
        super.awakeFromNib()
        let screenSize = NSScreen.main()!.frame
        let percent = CGFloat(0.50)
        let offset: CGFloat = CGFloat((1.0 - percent) / 2.0)

        window.setFrame(NSMakeRect(
            screenSize.size.width * offset,
            screenSize.size.height * offset,
            screenSize.size.width * percent,
            screenSize.size.height * percent),
                        display: true)
    }

    func windowWillClose(_ notification: Notification)
    {
        NSApplication.shared().terminate(window)
    }

    func windowDidResize(_ notification: Notification)
    {
    }

    func windowDidEndSheet(_ notification: Notification)
    {
        restartAnimation()
    }
}
