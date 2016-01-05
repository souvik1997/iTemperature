//
//  AppDelegate.swift
//  iTemperature
//
//  Created by Souvik Banerjee on 1/4/16.
//  Copyright © 2016 Souvik Banerjee. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBAction func quit(sender: NSMenuItem) {
        exit(0)
    }
    
    @IBOutlet weak var statusMenuController: StatusMenuController!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "update", userInfo: nil, repeats: true)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }
    
    func update() {
        statusMenuController.update()
    }

}

