//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import RealmSwift

class DisplayNoteViewController: UIViewController {
    
    var note: Note?
    
    @IBOutlet weak var noteContentTextView: UITextView!
    @IBOutlet weak var noteTitleTextField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if note == nil {
            // no note --> display empty UI
            noteTitleTextField.text = ""
            noteTitleTextField.placeholder = "Enter note title here"
            noteContentTextView.text = ""
        }
        else {
            // we have note --> show the contents of the note so that the user can modify it
            noteTitleTextField.text = note?.title
            noteContentTextView.text = note?.content
        }
        
//        if let actualNote = note {
//            noteTitleTextField.text = actualNote.title
//            noteContentTextView.text = actualNote.content
//        }
//        else {
//            noteTitleTextField.text = ""
//            noteContentTextView.text = ""
//        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // hint: these are unwind segues going back to the list of notes
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let listNotesTableViewController = segue.destinationViewController as! ListNotesTableViewController
        
        if segue.identifier == "Save" {
            
            if note == nil {
                // new note
                let note = Note()
                note.title = noteTitleTextField.text!
                note.content = noteContentTextView.text!
                note.modificationTime = NSDate()
                
                /****
                 // 1. create variable to check for length of string
                 // 2. if string is longer than 15 characters
                 //     then set variable to 15
                 //     otherwise set it to length of string
                 ***/
                
                var previewText = noteContentTextView.text!
                var numberOfCharactersToCutOff = previewText.characters.count
                
                if previewText.characters.count > 25 {
                    numberOfCharactersToCutOff = 25
                }
                else {
                    numberOfCharactersToCutOff = previewText.characters.count
                }
    
                let index = previewText.startIndex.advancedBy(numberOfCharactersToCutOff)
                previewText = previewText.substringToIndex(index)
                
                
                note.preview = previewText
                
                //   var previewText2 = previewText.substringToIndex(index)
                //   note.preview = previewText2
                
                RealmHelper.addNote(note)
            }
                
            else {
                var previewText = noteContentTextView.text!
                var numberOfCharactersToCutOff = previewText.characters.count
               
                
                // modify note
                let newNote = Note() // create a new note object in the RAM
                newNote.title = noteTitleTextField.text!
                newNote.content = noteContentTextView.text!
                
                
                if previewText.characters.count > 25 {
                    numberOfCharactersToCutOff = 25
                }
                else {
                    numberOfCharactersToCutOff = previewText.characters.count
                }
                
                let index = previewText.startIndex.advancedBy(numberOfCharactersToCutOff)
                previewText = previewText.substringToIndex(index)
                
                newNote.preview = previewText

                
                RealmHelper.updateNote(note!, newNote: newNote)
            }
            
            listNotesTableViewController.notes = RealmHelper.retriveNotes()
            
        }
        else {
            // we dont have to do anything because the user cancelled and we ignore the modiifcations
            
        }
    }
    
    
}
    