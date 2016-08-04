//
//  Note.swift
//  MakeSchoolNotes
//
//  Created by YK on 6/24/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import Foundation
import RealmSwift

class Note: Object {

    dynamic var title = ""
    dynamic var content = ""
    dynamic var modificationTime = NSDate()
    dynamic var preview = ""
    
    func doSomething() {
        var x = 4
        var t = 10
    }
}
