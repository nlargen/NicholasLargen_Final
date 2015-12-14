//
//  AttemptsVC.swift
//  BibleBooks
//
//  Created by Nicholas Largen on 12/14/15.
//  Copyright © 2015 cuw. All rights reserved.
//

import UIKit
import Parse
import WatchConnectivity

class AttemptsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, WCSessionDelegate{
    
    var session : WCSession!
    @IBOutlet weak var AttemptsTable: UITableView!

    
    @IBAction func LogoutButtonPressed(sender: AnyObject)
    {
        PhoneCore.currentUser = nil
        PhoneCore.currattempts.removeAll()
        
        let abvc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
        self.presentViewController(abvc, animated: true, completion: nil)
    }
    
    @IBAction func SaveAttempts(sender: AnyObject)
    {
        let userdata = PFObject(className:"AppData")
        userdata["AttemptsMade"] = PhoneCore.currattempts 
        
        
        userdata["owner_id"] = PhoneCore.currentUser
        
        userdata.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("saved")
                
                let uhvc = self.storyboard?.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
                self.presentViewController(uhvc, animated: true, completion: nil)
                
            }
            else
            {
                print("save error")
                // There was a problem, check error.description
            }
        }

    }
    override func viewDidLoad() {
        if WCSession.isSupported()
        {
            self.session = WCSession.defaultSession()
            session.delegate = self
            session.activateSession()
        }
        

        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject])
    {
        
        print(message)
        let theMessage = message["currAttempts"]!
        let parts = theMessage.componentsSeparatedByString(" -> ")
        print(theMessage)
        print("here")
        PhoneCore.currattempts.append(parts[0])
        print(PhoneCore.currattempts)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //TableViewControllers

func numberOfSectionsInTableView(tableView: UITableView) -> Int {
// #warning Incomplete implementation, return the number of sections
return 1
}

func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
// #warning Incomplete implementation, return the number of rows
return PhoneCore.currattempts.count

}


func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
{
let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! attemptscell
//update this code to fill the labels with the proper values
return cell
}

func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
{

}

//***********

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
