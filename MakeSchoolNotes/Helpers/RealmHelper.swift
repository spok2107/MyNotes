//
//  RealmHelper.swift
//  MakeSchoolNotes
//
//  Created by YK on 6/27/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class RealmHelper {

    static func addNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(note)
        }
    }
    
    static func deleteNote(note: Note) {
        let realm = try! Realm()
        try! realm.write() {
            realm.delete(note)
        }
    }
    
    static func updateNote(noteToBeUpdate: Note, newNote: Note) {
        let realm = try! Realm()
        try! realm.write() {
            noteToBeUpdate.title = newNote.title
            noteToBeUpdate.content = newNote.content
            noteToBeUpdate.modificationTime = newNote.modificationTime
            noteToBeUpdate.preview = newNote.preview
            
        }
        
    }
    static func retriveNotes() -> Results<Note> {
        let realm = try! Realm()
        return realm.objects(Note).sorted("modificationTime", ascending: false)
    }
}
