# SwiftLogEnv

Create custom loggers using a subsystem identifier and a log level.

## Install

Add the repository as a dependency:

```swift
.package(url: "https://github.com/binarybirds/swift-log-env", from: "1.0.0"),
```

Add `SwiftLogEnv` to the target dependencies:

```swift
.product(name: "SwiftLogEnv", package: "swift-log-env"),
```

Update the packages and you are ready.

## Usage example

Basic example

```swift
import SwiftLogEnv

let libLogger = Logger.subsystem("my-lib", .notice)
let appLogger = Logger.subsystem("my-app", .notice)

// LOG_LEVEL=info MY_LIB_LOG_LEVEL=trace swift run MyApp
```
