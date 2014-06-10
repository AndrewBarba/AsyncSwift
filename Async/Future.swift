//
//  Future.swift
//  Async
//
//  Created by Andrew Barba on 6/9/14.
//  Copyright (c) 2014 Andrew Barba. All rights reserved.
//

import Foundation

typealias SuccessCallback      = (AsyncObject?) -> ()
typealias ErrorCallback        = (AsyncError) -> ()
typealias IteratorCallback     = (AsyncObject, (AsyncError?) -> ()) -> ()

enum FutureState: Int {
    case Waiting, Operating, Completed
}

protocol Future {
    
    // instance vars
    var successCallbacks: SuccessCallback[] { get }
    var errorCallbacks: ErrorCallback[] { get }
    var state: FutureState { get }
    var error: AsyncError? { get }
    var results: AsyncObject? { get }
    
    // operate
    func operate() -> ()
    
    // on success
    func success(onSuccess: SuccessCallback) -> Future
    
    // on error
    func error(onError: ErrorCallback) -> Future
    
    // finish
    func finish(results: AsyncObject?, error: AsyncError?)
}

class CollectionFuture: Future {
    
    // protocol vars
    var successCallbacks: SuccessCallback[] = []
    var errorCallbacks: ErrorCallback[] = []
    var state: FutureState = .Waiting
    var error: AsyncError? = nil
    var results: AsyncObject? = nil
    
    var arr: AsyncObject[]
    let iterator: IteratorCallback
    
    init(arr: AsyncObject[], iterator: IteratorCallback) {
        self.arr = arr
        self.iterator = iterator
    }
    
    func operate() {
        state = .Operating
    }
    
    func success(onSuccess: SuccessCallback) -> Future {
        if state == .Completed {
            if !error {
                onSuccess(results)
            }
        } else {
            successCallbacks += onSuccess
        }
        return self
    }
    
    func error(onError: ErrorCallback) -> Future {
        if state == .Completed {
            if let err = error {
                onError(err)
            }
        } else {
            errorCallbacks += onError
        }
        return self
    }
    
    func finish(results: AsyncObject?, error: AsyncError?) {
        if let err = error {
            for callback in errorCallbacks {
                callback(err)
            }
        } else {
            for callback in successCallbacks {
                callback(results)
            }
        }
        
        // reset
        state = .Completed
        successCallbacks = []
        errorCallbacks = []
    }
}
