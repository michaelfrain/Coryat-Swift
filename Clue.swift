//
//  Coryat-Swift.swift
//  Coryat-Swift
//
//  Created by Michael Frain on 2/3/15.
//  Copyright (c) 2015 Michael Frain. All rights reserved.
//

import Foundation
import CoreData

class Clue: NSManagedObject {

    @NSManaged var value: NSNumber
    @NSManaged var selectionOrder: NSNumber
    @NSManaged var result: NSNumber
    @NSManaged var game: Game
}
