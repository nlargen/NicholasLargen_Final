//
//  PickerScreenIC.swift
//  BibleBooks
//
//  Created by Nicholas Largen on 12/14/15.
//  Copyright © 2015 cuw. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class PickerScreenIC: WKInterfaceController, WCSessionDelegate {

    var session : WCSession!
    @IBOutlet var Pickeroutlet: WKInterfacePicker!
    override func awakeWithContext(context: AnyObject?)
    {
        
        if WCSession.isSupported() {
            self.session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        
        

        var thePickerItems = [WKPickerItem]()
        for(var i = 0; i <= WatchSinglton.correcttracker.count; i++)
        {
            thePickerItems.append(WKPickerItem())
            thePickerItems[0].title = WatchSinglton.bibleBooksArray[i]
        }
        
        self.Pickeroutlet.setItems(thePickerItems)

        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    @IBAction func SaveButtonPressed()
    {
        session.sendMessage(["currAttempts" : "\(WatchSinglton.correcttracker)"], replyHandler: nil, errorHandler: nil)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
