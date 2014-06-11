//
//  Future.swift
//  Async
//
//  Created by Andrew Barba on 6/9/14.
//  Copyright (c) 2014 Andrew Barba. All rights reserved.
//

import Foundation

enum FutureState {
    case Pending, Operating, Complete
}

class Future<SuccessType, ErrorType> {
    
    var state = FutureState.Pending
    
    // results
    var _result: SuccessType?
    var _error: ErrorType?
    
    // callbacks
    var _onSuccess: (SuccessType -> ())[] = []
    var _onError: (ErrorType -> ())[] = []
    
    init() {
        // override
    }
    
    func success(onSuccess: SuccessType -> ()) -> Future<SuccessType, ErrorType> {
        if state == .Complete {
            if let res = _result {
                onSuccess(res)
            }
        } else {
            _onSuccess += onSuccess
        }
        return self
    }
    
    func error(onError: ErrorType -> ()) -> Future<SuccessType, ErrorType> {
        if state == .Complete {
            if let err = _error {
                onError(err)
            }
        } else {
            _onError += onError
        }
        return self
    }
    
    func finish(result: SuccessType?, error: ErrorType?) {
        _result = result
        _error = error
        _notify()
        state = .Complete
        _clean()
    }
    
    func operate() {
        state = .Operating
    }
    
    func _notify() {
        if let err = _error {
            for block in _onError {
                block(err)
            }
        } else if let res = _result {
            for block in _onSuccess {
                block(res)
            }
        }
    }
    
    func _clean() {
        _onSuccess = []
        _onError = []
        _result = nil
        _error = nil
    }
}
