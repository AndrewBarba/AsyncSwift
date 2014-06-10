//
//  Async.swift
//  Async
//
//  Created by Andrew Barba on 6/9/14.
//  Copyright (c) 2014 Andrew Barba. All rights reserved.
//

import Foundation

typealias AsyncObject = AnyObject
typealias AsyncError = NSError

class Async {
    
    // dispatch block on main thread
    class func dispatchMain(block: () -> ()) -> NSOperation {
        var queue = NSOperationQueue()
        var op = NSBlockOperation()
        op.addExecutionBlock(block)
        queue.addOperation(op)
        return op
    }
    
    // dispatch block on background thread
    class func dispatchBackground(block: () -> ()) -> NSOperation {
        var queue = NSOperationQueue.mainQueue()
        var op = NSBlockOperation()
        op.addExecutionBlock(block)
        queue.addOperation(op)
        return op
    }
    
    // https://github.com/caolan/async#each
    class func each(arr: AsyncObject[], iterator: IteratorCallback) -> Future {
        var future = Each(arr: arr, iterator: iterator)
        future.operate()
        return future
    }
    
    // https://github.com/caolan/async#eachSeries
    class func eachSeries(arr: AsyncObject[], iterator: IteratorCallback) -> Future {
        var future = EachSeries(arr: arr, iterator: iterator)
        future.operate()
        return future
    }
}
