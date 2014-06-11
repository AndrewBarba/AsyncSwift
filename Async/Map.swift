//
//  Map.swift
//  Async
//
//  Created by Andrew Barba on 6/10/14.
//  Copyright (c) 2014 Andrew Barba. All rights reserved.
//

import Foundation

class MapLimit<T>: CollectionFuture<T, (T, NSError?), (T[])> {
    
    var limit: Int
    
    init(limit: Int, arr: T[], iterator: Iterator) {
        self.limit = limit
        super.init(arr: arr, iterator: iterator)
    }
    
    override func operate() {
        super.operate()
        
        if arr.count == 0 {
            return finish([], error: nil)
        }
        
        let _arr = arr
        var remaining = arr.count
        
        for (i, a) in enumerate(arr) {
            Async.dispatchBackground {[self]
                self.iterator(a) { o, err in
                    if err {
                        self.finish(nil, error: err)
                    } else {
                        _arr[i] = o
                        if remaining == 0 {
                            self.finish(_arr, error: nil)
                        }
                    }
                }
            }
        }
    }
}

class Map<T>: MapLimit<T> {
    init(arr: T[], iterator: Iterator) {
        super.init(limit: arr.count, arr: arr, iterator: iterator)
    }
}

class MapSeries<T>: MapLimit<T> {
    init(arr: T[], iterator: Iterator) {
        super.init(limit: 1, arr: arr, iterator: iterator)
    }
}
