//
//  StatusMenuController.swift
//  iTemperature
//
//  Created by Souvik Banerjee on 1/4/16.
//  Copyright © 2016 Souvik Banerjee. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    
    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength);
    let sensors: [TemperatureSensor]
    override init() {
        do
        {
            try SMCKit.open()
            self.sensors = try SMCKit.allKnownTemperatureSensors().sort
                { $0.name < $1.name }
            
            
        } catch {
            sensors = []
            return
        }
    }
    
    override func awakeFromNib() {
        statusItem.menu = statusMenu
        var max_temperature = 0.0
        for sensor in sensors.reverse()
        {
            guard let temperature = try? SMCKit.temperature(sensor.code) else { continue }
            if (temperature > max_temperature)
            {
                max_temperature = temperature
            }
            let menuItem = NSMenuItem(title: "\(sensor.name): \(temperature)°C", action: Selector("callback:"), keyEquivalent: "")
            statusMenu.insertItem(menuItem, atIndex: 0)
        }
        statusItem.title = "\(max_temperature)°C"
    }
    
    func callback(sender: AnyObject) {
        
    }
    
    func update() {
        var counter = 0
        var max_temperature = 0.0
        for sensor in sensors
        {
            guard let temperature = try? SMCKit.temperature(sensor.code) else { continue }
            if (temperature > max_temperature)
            {
                max_temperature = temperature
            }
            statusMenu.itemAtIndex(counter)!.title = "\(sensor.name): \(temperature)°C"
            counter++
        }
        statusItem.title = "\(max_temperature)°C"
    }

}
