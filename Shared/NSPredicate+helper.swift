//
//  NSPredicate+helper.swift
//  AdvancedNotes
//
//  Created by Paul Franco on 3/9/21.
//

import Foundation
import CoreData

extension NSPredicate {
    static var all = NSPredicate(format: "TRUEPREDICATE")
    static var none = NSPredicate(format: "FALSEPREDICATE")
}
