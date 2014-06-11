//
//  Map.swift
//  Async
//
//  Created by Andrew Barba on 6/10/14.
//  Copyright (c) 2014 Andrew Barba. All rights reserved.
//

import Foundation

class MapLimit<T, X>: CollectionFuture<T, (X, NSError?), X[]> {
    
    var limit: Int
    
    init(limit: Int, arr: T[], iterator: Iterator) {
        self.limit = limit
        super.init(arr: arr, iterator: iterator)
    }
    
    override func operate() {
        super.operate()
        
        var index = min(limit, arr.count)
        var _arr = arr[0..index]
        var _res: X[] = Array()
        
        if _arr.count == 0 {
            return finish([], error: nil)
        }
        
        var remaining = _arr.count
        for (i, a) in enumerate(_arr) {
            Async.dispatchBackground {[self]
                self.iterator(a) { o, err in
                    remaining -= 1
                    if err {
                        self.finish(nil, error: err)
                    } else {
                        _res += o
                        if remaining == 0 {
                            self.finish(_res, error: nil)
                        }
                    }
                }
            }
        }
    }
}

class Map<T, X>: MapLimit<T, X> {
    init(arr: T[], iterator: Iterator) {
        super.init(limit: arr.count, arr: arr, iterator: iterator)
    }
}

class MapSeries<T, X>: MapLimit<T, X> {
    init(arr: T[], iterator: Iterator) {
        super.init(limit: 1, arr: arr, iterator: iterator)
    }
}
