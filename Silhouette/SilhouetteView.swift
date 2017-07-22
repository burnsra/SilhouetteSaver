//
//  SilhouetteView.swift
//  Silhouette
//
//  Created by Burns, Robert A on 7/21/17.
//  Copyright © 2017 Burns5. All rights reserved.
//

import Foundation
import ScreenSaver
import WebKit

class SilhouetteView: ScreenSaverView {

    let SilhouetteWebView: WebView = WebView(frame: NSZeroRect)

    var silhouetteController: SilhouetteController!

    fileprivate func initialize() {
        self.configureWebView()
        self.addSubview(self.SilhouetteWebView)
    }

    deinit {
        self.SilhouetteWebView.removeFromSuperview()
    }

    fileprivate func configureWebView() {
        self.SilhouetteWebView.frame = self.bounds
        self.SilhouetteWebView.setMaintainsBackForwardList(false)
    }

    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        self.silhouetteController = SilhouetteController.sharedInstance
        self.initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func startAnimation() {
        super.startAnimation()
        let url = String(format:"file://%@/html/index.html", Bundle(for: type(of: self)).resourcePath!).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)
        self.SilhouetteWebView.mainFrame.load(URLRequest(url: URL(string: url!)!))
        self.SilhouetteWebView.mainFrame.reloadFromOrigin()
    }

    override func stopAnimation() {
        super.stopAnimation()
    }

    override func draw(_ rect: NSRect) {
        super.draw(rect)
    }

    override func animateOneFrame() {
    }

    override func hasConfigureSheet() -> Bool {
        return true
    }

    override func configureSheet() -> NSWindow? {
        let controller = ConfigureSheetController.sharedInstance
        return controller.window
    }

}
