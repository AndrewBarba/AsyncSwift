//
//  Each.swift
//  Async
//
//  Created by Andrew Barba on 6/10/14.
//  Copyright (c) 2014 Andrew Barba. All rights reserved.
//

import Foundation

class Each<T>: CollectionFuture<T, (NSError?), ()> {
    
    init(arr: T[], iterator: Iterator) {
        super.init(arr: arr, iterator: iterator)
    }
    
    override func operate() {
        super.operate()
        
        if arr.count == 0 {
            return finish(nil, error: nil)
        }
        
        var remaining = arr.count
        
        for a in arr {
            Async.dispatchBackground {[self]
                self.iterator(a) { err in
                    if err {
                        self.finish(nil, error: err)
                    } else {
                        remaining -= 1
                        if remaining == 0 {
                            self.finish((), error: nil)
                        }
                    }
                }
            }
        }
    }
}

class EachSeries<T>: CollectionFuture<T, (NSError?), ()> {
    
    init(arr: T[], iterator: Iterator) {
        super.init(arr: arr, iterator: iterator)
    }
    
    override func operate() {
        super.operate()
        
        if arr.count == 0 {
            return self.finish((), error: nil)
        }
        
        var a = arr[0]
        Async.dispatchBackground {[self]
            self.iterator(a) { err in
                if err {
                    self.finish(nil, error: err)
                } else {
                    self.arr[0..1] = []
                    self.operate()
                }
            }
        }
    }
}
