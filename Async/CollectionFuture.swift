//
//  CollectionFuture.swift
//  Async
//
//  Created by Andrew Barba on 6/10/14.
//  Copyright (c) 2014 Andrew Barba. All rights reserved.
//

import Foundation

class CollectionFuture<T, IteratorType, SuccessType>: Future<SuccessType, NSError> {
    
    typealias Iterator = (T, IteratorType -> ()) -> ()
    
    var arr: T[]
    var iterator: Iterator
    
    init(arr: T[], iterator: Iterator) {
        self.arr = arr
        self.iterator = iterator
        super.init()
    }
}
