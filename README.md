Async.swift
======

https://github.com/caolan/async

### Each

```
Async
    .each([ "Andrew", "Zach" ]) { name, done in 
        println(name)
        done(nil)
    }
    .success { results in
        // handle success
    }
    .error { error in
        // handle error
    }
```