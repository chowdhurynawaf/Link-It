//
//  AppDelegate.swift
//  LinkIt
//
//  Created by as on 5/27/20.
//  Copyright © 2020 as. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var item : NSStatusItem? = nil

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        item =  NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        
        item?.button?.image = NSImage(named: "chain")
       
        
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "LinkIt!", action: #selector(AppDelegate.linkIt), keyEquivalent: "L"))
        
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(AppDelegate.quit), keyEquivalent: "Q"))
        item?.menu = menu
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func linkIt(){
    
        if let items =  NSPasteboard.general.pasteboardItems{
            for item in items{
                for type in item.types{
                    if type.rawValue == "public.utf8-plain-text"{
                        if let url = item.string(forType: type){
                            
                            var actualUrl = ""
                            NSPasteboard.general.clearContents()
                            
                            if url.hasPrefix("https://") || url.hasPrefix("http://"){
                                actualUrl = url
                            }else{
                                actualUrl = "http://\(url)"
                            }
                            
                            NSPasteboard.general.setString("<a href=\"\(url)\">\(actualUrl)</a>", forType: NSPasteboard.PasteboardType(rawValue: "public.html"))
                        
                            
                            NSPasteboard.general.setString(url, forType: NSPasteboard.PasteboardType(rawValue: "public.utf8-plain-text"))
                        
                            
                        
                        }
                    }
                }
            }
        }
        
        
        
    }
    
    @objc func quit(){
        
        NSApplication.shared.terminate(self)
    }


}

