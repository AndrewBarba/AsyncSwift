//
//  Each.swift
//  Async
//
//  Created by Andrew Barba on 6/10/14.
//  Copyright (c) 2014 Andrew Barba. All rights reserved.
//

import Foundation

class Each: CollectionFuture {
    
    override func operate() {
        if (arr.count == 0) {
            return finish(nil, error: nil)
        }
        
        var remaining = arr.count
        for a: AnyObject in arr {
            Async.dispatchBackground {[self]
                self.iterator(a) { error in
                    if error {
                        self.finish(nil, error: error)
                    } else {
                        remaining -= 1
                        if remaining == 0 {
                            self.finish(nil, error: nil)
                        }
                    }
                }
            }
        }
    }
}

class EachSeries: CollectionFuture {
    
    override func operate() {
        if (arr.count == 0) {
            return finish(nil, error: nil)
        }
        
        let i: AsyncObject = arr[0]
        Async.dispatchBackground {[self]
            self.iterator(i) { error in
                if error {
                    self.finish(nil, error: error)
                } else {
                    self.arr[0..1] = []
                    self.operate()
                }
            }
        }
    }
}

