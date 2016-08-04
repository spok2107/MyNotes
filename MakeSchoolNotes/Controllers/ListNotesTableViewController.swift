//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class ListNotesTableViewController: UITableViewController {
    
    // creating a property called notes that has been initialized to an empty array of Note objects.
    var notes: Results<Note>! {
        
        //tell the table view to reload all of its data whenever our notes property is changed
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ListNotesTableViewController - viewDidLoad")
        notes = RealmHelper.retriveNotes()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("ListNotesTableViewController - viewWillAppear")
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("ListNotesTableViewController - viewDidAppear")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("listNotesTableViewCell", forIndexPath: indexPath) as! ListNotesTableViewCell
        
        let row = indexPath.row
        let note = notes[row]
        cell.noteTitleLabel.text = note.title
        cell.noteModificationTimeLabel.text = note.modificationTime.convertToString()
        cell.notePreview.text = note.preview
        
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            
            if identifier == "displayNote" {
                
                let indexPath = tableView.indexPathForSelectedRow!
                print("Table view cell tapped --> section: \(indexPath.section), row: \(indexPath.row)")
                
                let note = notes[indexPath.row] // retrieve the note from our main storage array according to the index of the cell that was selected by the user
                
                // pass the retrieved note to the DisplayNoteViewController so that it knows what information to display
                let displayNoteViewController = segue.destinationViewController as! DisplayNoteViewController
                displayNoteViewController.note = note
                
            }
            else if identifier == "addNote" {
                print("+ button tapped")
            }
        }
    }
    
    
    @IBAction func unwindToListNotesViewController(segue: UIStoryboardSegue) {
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        
        if editingStyle == .Delete {
            RealmHelper.deleteNote(notes[indexPath.row])
            notes = RealmHelper.retriveNotes()
            
        }
    }
    

    
}

