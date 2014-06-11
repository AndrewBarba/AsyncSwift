Async.swift
======

https://github.com/caolan/async

```
let names = [ "Andrew", "Zach", "Art" ]
```

### Each

```
Async
    .each(names) { name, done in 
        println(name)
        done(nil)
    }
    .success {
        // handle success
    }
    .error { error in
        // handle error
    }

Async
    .eachSeries(names) { $1(nil) }
    .success {}

Async
    .eachLimit(limit: 2, arr: names) { $1(nil) }
    .success {}
```

### Map

```
Async
    .map(names) { $1($0.uppercaseString, nil) } // short hand
    .success { results in
        // [ "ANDREW", "ZACH", "ART" ]
    }
    .error { error in
        // handle error
    }
```