//
//  MainScreenICInterfaceController.swift
//  BibleBooks
//
//  Created by Nicholas Largen on 12/14/15.
//  Copyright © 2015 cuw. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class MainScreenICInterfaceController: WKInterfaceController {
    
    @IBOutlet var VerseTable: WKInterfaceTable!
    
   
       
    @IBAction func ResetButtonPressed()
    {
        WatchSinglton.correcttracker.removeAll()
    }
    
    override func awakeWithContext(context: AnyObject?)
    {
        generateTable()
               super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    func generateTable()
    {
        self.VerseTable.setNumberOfRows(WatchSinglton.bibleBooksArray.count, withRowType: "cell")
        
        for(var i = 0; i < WatchSinglton.bibleBooksArray.count; i++)
        {
            let currRow = self.VerseTable.rowControllerAtIndex(i) as! verserow
           currRow.verselabel.setText(WatchSinglton.bibleBooksArray[random() % 29])
        }
        
    }
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int)
    {
        WatchSinglton.correcttracker.append(rowIndex)
        print(WatchSinglton.correcttracker)
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
