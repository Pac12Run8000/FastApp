//
//  TimerViewController.swift
//  FastApp
//
//  Created by Michelle Grover on 2/25/16.
//  Copyright © 2016 Michelle Grover. All rights reserved.
//
import AVFoundation
import UIKit
import CoreData

class TimerViewController: UIViewController {
    
    var timer:NSTimer = NSTimer()
    var minutes:Int = 0
    var seconds:Int = 0
    var fractions:Int = 0
    var hours:Int = 0
    var restInterval:Int = 0
    
    var startStopWatch:Bool = true
    var stopWatchString:String = ""
    
    var audioPlayer: AVAudioPlayer!
    
    
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnStartStop: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    
    var vMeal:IMeal? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (vMeal != nil) {
            //restInterval = self.getRestInterval(vMeal!)
            self.lblTimer.text = "00:00:00.00"
        } else {
            self.lblTimer.text = "00:00:00.00"
        }
        self.lblTimer.layer.borderWidth = 3
        self.lblTimer.layer.cornerRadius = 10
        self.btnStartStop.layer.cornerRadius = btnStartStop.frame.size.width / 2
        self.btnStartStop.layer.borderWidth = 3
        self.btnReset.layer.cornerRadius = btnReset.frame.size.width / 2
        self.btnReset.layer.borderWidth = 3
       
    }
    
    func getRestInterval(mVal:IMeal) -> Int {
        var returnVal:Int = 0
        switch(mVal.mealInterval!) {
        case "16:00:00":
            returnVal = 16
            break
        case "24:00:00":
            returnVal = 24
            break
        case "48:00:00":
            returnVal = 48
            break
        default:
            returnVal = 16
            break
        }
        return returnVal
    }

    @IBAction func btnStartStopPressed(sender: AnyObject) {
        if (startStopWatch == true) {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
            startStopWatch = false
            self.btnStartStop.setTitle("Stop", forState: UIControlState.Normal)
        } else {
            timer.invalidate()
            startStopWatch = true
            self.btnStartStop.setTitle("Start", forState: UIControlState.Normal)
        }
    }
    
    func updateTimer() {
        var defaultValForNil:Int = 16
        //if (vMeal != nil) {
            fractions += 1
            if (fractions == 100) {
                seconds += 1
                fractions = 0
            }
            if (seconds == 60) {
                minutes += 1
                seconds = 0
            }
            if (minutes == 60) {
                hours += 1
                minutes = 0
            }
            if (vMeal != nil) {
                defaultValForNil = getRestInterval(vMeal!)
            } else {
                defaultValForNil = 16
            }
            
            if (hours == defaultValForNil) {
                timer.invalidate()
                self.playVes()
                let myAlert = UIAlertController(title: "Fasting Alert", message: "\(getRestInterval(vMeal!)) hours have passed. Times Up!", preferredStyle: UIAlertControllerStyle.Alert)
                let myAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: { (ACTION) -> Void in
                   // alert functionality
                    if (self.startStopWatch == false) {
                        self.btnStartStop.setTitle("Start", forState: UIControlState.Normal)
                        self.startStopWatch = true
                        self.fractions = 0
                        self.seconds = 0
                        self.minutes = 0
                        self.hours = 0
                        self.lblTimer.text = "00:00:00.00"
                        
                        self.audioPlayer.stop()
                    }
                   
                })
                myAlert.addAction(myAction)
                self.presentViewController(myAlert, animated: true, completion: nil)
            }
        
            let fractionString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
            let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
            let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
            let hoursString = hours > 9 ? "\(hours)" : "0\(hours)"
        
            self.lblTimer.text = "\(hoursString):\(minutesString):\(secondsString).\(fractionString)"
        //}
    }
    
    //Audio issues
    func playVes() {
        do {
            self.audioPlayer =  try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("72244__benboncan__alarm", ofType: "wav")!))
            self.audioPlayer.play()
            
        } catch {
            print("Error")
        }
    }
    
    @IBAction func btnResetPressed(sender: AnyObject) {
        fractions = 0
        seconds = 0
        minutes = 0
        hours = 0
        self.lblTimer.text = "00:00:00.00"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
