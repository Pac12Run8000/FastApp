//
//  MainTableViewController.swift
//  FastApp
//
//  Created by Michelle Grover on 2/23/16.
//  Copyright © 2016 Michelle Grover. All rights reserved.
//

import UIKit
import CoreData

class MainTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let context:NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var frc:NSFetchedResultsController = NSFetchedResultsController()
    
    func getFRC() -> NSFetchedResultsController {
        frc = NSFetchedResultsController(fetchRequest: getIMealFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }
    
    func getIMealFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "IMeal")
        let sortDescriptor = NSSortDescriptor(key: "mealName", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frc = getFRC()
        frc.delegate = self
        do {
            try frc.performFetch() } catch {
                print(error)
                return
        }
        self.tableView.rowHeight = 100
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = frc.sections?.count
        return numberOfSections!
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = frc.sections![section].numberOfObjects
        return numberOfRowsInSection
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let sMeal = frc.objectAtIndexPath(indexPath) as! IMeal
        cell.textLabel?.text = sMeal.mealName
        var sfastType = ""
        switch(sMeal.mealInterval!) {
            case "16:00:00":
                sfastType = "16hr Interval"
            break
            case "24:00:00":
                sfastType = "24hr Interval"
            break
            case "48:00:00":
            sfastType = "48hr Interval"
            break
            default:
            break
        }
        
        cell.detailTextLabel?.text = sfastType
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObject:NSManagedObject = frc.objectAtIndexPath(indexPath) as! NSManagedObject
        context.deleteObject(managedObject)
        do {
            try context.save() } catch {
                print(error)
                return
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "editMeal") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let itemController:ViewController = segue.destinationViewController as! ViewController
            let nMeal:IMeal = frc.objectAtIndexPath(indexPath!) as! IMeal
            itemController.myMeal = nMeal
            
            
        }
    }
    

}
