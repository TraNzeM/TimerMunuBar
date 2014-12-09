//
//  AppDelegate.swift
//  TestMenuBar
//
//  Created by Ivan Zyablov on 04.12.14.
//  Copyright (c) 2014 TraNzeM. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    var minutes: Double?
    var timer = NSTimer()

    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var sliderTimerOutlet: NSSlider!
    @IBOutlet weak var timerLabelCount: NSTextField!
    @IBOutlet weak var timerLabel: NSTextField!

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        let icon = NSImage(named: "Smoke")
        icon?.setTemplate(true)
        statusItem.image = icon
        statusItem.menu = statusMenu
        statusItem.highlightMode = true
        
        timerLabel.hidden = true
        sliderTimerOutlet.doubleValue = 1
        
        sliderTimer(NSSlider())
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func sliderTimer(sender: AnyObject) {
        let valueSlider = sliderTimerOutlet.doubleValue
        timerLabelCount.stringValue = "\(valueSlider)мин"
        minutes = timerLabelCount.doubleValue * 60
        println("minutes = \(minutes)")
        println("valueSlider = \(valueSlider)")
    }
    @IBAction func quit(sender: AnyObject) {
        NSApplication.sharedApplication().terminate(nil)
    }
    @IBAction func startTimer(sender: AnyObject) {
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "Couting", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
        let icon = NSImage(named: "NoSmoke")
        icon?.setTemplate(true)
        statusItem.image = icon
    }
    
    func Couting() {
        if minutes > 0 {
            timerLabel.hidden = false
            timerLabel.doubleValue = minutes!
            minutes = minutes! - 1
            println("timerLabel = \(timerLabel.doubleValue)")
            println("minutes = \(minutes)")
        } else {
            timerLabel.stringValue = "end"
            let icon = NSImage(named: "Smoke")
            icon?.setTemplate(true)
            statusItem.image = icon
        }
    }

}

