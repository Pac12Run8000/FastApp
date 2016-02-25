//
//  TimerViewController.swift
//  FastApp
//
//  Created by Michelle Grover on 2/25/16.
//  Copyright © 2016 Michelle Grover. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var lblTimer: UILabel!
    
    var strInterval:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTimer.text = strInterval
        // Do any additional setup after loading the view.
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
