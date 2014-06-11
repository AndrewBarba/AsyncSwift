//
//  Each.swift
//  Async
//
//  Created by Andrew Barba on 6/10/14.
//  Copyright (c) 2014 Andrew Barba. All rights reserved.
//

import Foundation

class EachLimit<T>: CollectionFuture<T, (NSError?), ()> {
    
    var limit: Int
    
    init(limit: Int, arr: T[], iterator: Iterator) {
        self.limit = limit
        super.init(arr: arr, iterator: iterator)
    }
    
    override func operate() {
        
        let index = min(limit, arr.count)
        var _arr = arr[0..index]
        
        if _arr.count == 0 {
            return self.finish((), error: nil)
        }
        
        var remaining = _arr.count
        
        for a in _arr {
            Async.dispatchBackground {[self]
                self.iterator(a) { err in
                    remaining -= 1
                    
                    if err {
                        self.finish(nil, error: err)
                    } else if remaining == 0 {
                        self.arr[0..index] = []
                        self.operate()
                    }
                }
            }
        }
    }
}

class Each<T>: EachLimit<T> {
    init(arr: T[], iterator: Iterator) {
        super.init(limit: arr.count, arr: arr, iterator: iterator)
    }
}

class EachSeries<T>: EachLimit<T> {
    init(arr: T[], iterator: Iterator) {
        super.init(limit: 1, arr: arr, iterator: iterator)
    }
}
