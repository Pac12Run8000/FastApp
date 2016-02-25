//
//  TimerViewController.swift
//  FastApp
//
//  Created by Michelle Grover on 2/25/16.
//  Copyright © 2016 Michelle Grover. All rights reserved.
//

import UIKit
import CoreData

class TimerViewController: UIViewController {
    
    @IBOutlet weak var lblTimer: UILabel!
    
    var vMeal:IMeal? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (vMeal != nil) {
        self.lblTimer.text = vMeal!.mealInterval
        }
       
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
