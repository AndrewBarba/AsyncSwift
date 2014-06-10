Async.sgwift
======

https://github.com/caolan/async

### Each

```
Async
    .each([ "Andrew", "Steve", "Gianna" ]) { name, done in 
        println(name)
        done(nil)
    }
    .success { 
        // handle success
    }
    .error {
        // handle error
    }
```