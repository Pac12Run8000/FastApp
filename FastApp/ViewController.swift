//
//  ViewController.swift
//  FastApp
//
//  Created by Michelle Grover on 2/22/16.
//  Copyright © 2016 Michelle Grover. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var myMeal:IMeal? = nil
    
    let fastTypesArray:[String] = ["16 hr fast", "24 hr fast", "48 hr fast"]
    var fastTypeRow:Int = Int()
    var strFastType:String = String()

    @IBOutlet weak var txtTitleOutlet: UITextField!
    @IBOutlet weak var txtDescriptionOutlet: UITextView!
    @IBOutlet weak var pickerFastType: UIPickerView!
    @IBOutlet weak var lblTimeDisplay: UILabel!
    @IBOutlet weak var lblSaved: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblSaved.alpha = 0
        if (myMeal != nil) {
            
           
            self.txtTitleOutlet.text = myMeal?.mealName
            self.txtDescriptionOutlet.text = myMeal?.mealDesc
            self.lblTimeDisplay.text = myMeal?.mealInterval
            strFastType = self.lblTimeDisplay.text!
            
        }
        self.txtTitleOutlet.layer.borderColor = UIColor.blackColor().CGColor
        self.txtDescriptionOutlet.layer.borderColor = UIColor.blackColor().CGColor
        self.txtDescriptionOutlet.layer.borderWidth = 1
        
        self.pickerFastType.delegate = self
        self.pickerFastType.dataSource = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (myMeal != nil) {
            if (segue.identifier == "setTimer") {
                let tVC:TimerViewController = segue.destinationViewController as! TimerViewController
                tVC.vMeal = myMeal!
            }
        }
    }
 
    
    
    @IBAction func btnStartSave(sender: AnyObject) {
        if (myMeal != nil) {
            self.editMealItem()
        } else {
            self.newMealItem()
        }
            self.lblSaved.alpha = 1
        UIView.animateWithDuration(2) { () -> Void in
            self.lblSaved.alpha = 0
        }
    }
    func newMealItem() {
        let context = self.context
        let ent = NSEntityDescription.entityForName("IMeal", inManagedObjectContext: context)
        let nMeal = IMeal(entity: ent!, insertIntoManagedObjectContext: context)
        nMeal.mealName = self.txtTitleOutlet.text
        nMeal.mealDesc = self.txtDescriptionOutlet.text
        nMeal.mealInterval = self.lblTimeDisplay.text
        do {
            try context.save()
        } catch {
            print(error)
            return
        }
    }
    
    func editMealItem() {
        myMeal?.mealName = txtTitleOutlet.text
        myMeal?.mealDesc = txtDescriptionOutlet.text
        myMeal?.mealInterval = lblTimeDisplay.text
        do {
            try context.save() } catch {
                print(error)
                return
        }
    }
    @IBAction func btnReset(sender: AnyObject) {
        
    }
    @IBAction func backButton(sender: AnyObject) {
        dismissVC()
    }
   
    
    func dismissVC() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.fastTypesArray.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
   
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.fastTypesArray[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let timeFrame:String = self.fastTypesArray[row]
        switch (timeFrame) {
            case "16 hr fast":
            self.lblTimeDisplay.text = "16:00:00"
            break
            case "24 hr fast":
            self.lblTimeDisplay.text = "24:00:00"
            break
            case "48 hr fast":
            self.lblTimeDisplay.text = "48:00:00"
            break
        default:
            break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

