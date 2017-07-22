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
        self.initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func startAnimation() {
        super.startAnimation()
        self.SilhouetteWebView.mainFrame.load(URLRequest(url: URL(string: "https://github.com/burnsra/SilhouetteSaver")!))
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
        return false
    }

    override func configureSheet() -> NSWindow? {
        return nil
    }

}
