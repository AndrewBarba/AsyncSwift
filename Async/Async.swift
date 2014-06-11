//
//  Async.swift
//  Async
//
//  Created by Andrew Barba on 6/9/14.
//  Copyright (c) 2014 Andrew Barba. All rights reserved.
//

import Foundation

class Async {
    
    // dispatch block on queue
    class func dispatchQueue(queue: NSOperationQueue, block: () -> ()) -> NSOperation {
        var op = NSBlockOperation()
        op.addExecutionBlock(block)
        queue.addOperation(op)
        return op
    }
    
    // dispatch block on main thread
    class func dispatchMain(block: () -> ()) -> NSOperation {
        return self.dispatchQueue(NSOperationQueue(), block)
    }
    
    // dispatch block on background thread
    class func dispatchBackground(block: () -> ()) -> NSOperation {
        return self.dispatchQueue(NSOperationQueue.mainQueue(), block)
    }
    
    // https://github.com/caolan/async#each
    class func each<T>(items: T[], iterator: (T, (NSError?) -> ()) -> ()) -> Each<T> {
        return Each(arr: items, iterator: iterator)
    }
    
    // https://github.com/caolan/async#eachSeries
    class func eachSeries<T>(items: T[], iterator: (T, (NSError?) -> ()) -> ()) -> EachSeries<T> {
        return EachSeries(arr: items, iterator: iterator)
    }
    
    // https://github.com/caolan/async#map
    class func map<T>(items: T[], iterator: (T, (T, NSError?) -> ()) -> ()) -> Map<T> {
        return Map(arr: items, iterator: iterator)
    }
    
    // https://github.com/caolan/async#mapSeries
    class func mapSeries<T>(items: T[], iterator: (T, (T, NSError?) -> ()) -> ()) -> MapSeries<T> {
        return MapSeries(arr: items, iterator: iterator)
    }
}
