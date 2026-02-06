# Swift Logging Environment

Create custom loggers scoped by subsystem and log level. Provides precise, fine-grained control over logging behavior across different environments.

[![Release: 2.0.0](https://img.shields.io/badge/Release-2.0.0-F05138)]( https://github.com/binarybirds/swift-log-env/releases/tag/2.0.0)

## Requirements

![Swift 6.1+](https://img.shields.io/badge/Swift-6%2E1%2B-F05138)
![Platforms: macOS, iOS, tvOS, watchOS, visionOS](https://img.shields.io/badge/Platforms-macOS_%7C_iOS_%7C_tvOS_%7C_watchOS_%7C_visionOS-F05138)

- Swift 6.1+
- Platforms:
  - Linux
  - macOS 15+
  - iOS 18+
  - tvOS 18+
  - watchOS 11+
  - visionOS 2+

## Installation

Use Swift Package Manager; add the dependency to your `Package.swift` file:

```swift
.package(url: "https://github.com/binarybirds/swift-log-env", from: "2.0.0"),
```

Then add `LoggingEnvironment` to your target dependencies:

```swift
.product(name: "LoggingEnvironment", package: "swift-log-env"),
```

Update the packages and you are ready.

## Usage

[![DocC API documentation](https://img.shields.io/badge/DocC-API_documentation-F05138)](https://binarybirds.github.io/swift-log-env)

API documentation is available at the following link.

## Basic example

```swift
import LoggingEnvironment

let libLogger = Logger.subsystem("my-lib", .notice)
let appLogger = Logger.subsystem("my-app", .notice)

// LOG_LEVEL=info MY_LIB_LOG_LEVEL=trace swift run MyApp
```

This imports `LoggingEnvironment` and creates two loggers scoped to `my-lib` and `my-app` with a default `.notice` level. At runtime, environment variables override these levels: `LOG_LEVEL` sets a global minimum, while `MY_LIB_LOG_LEVEL` applies a more specific level to the `my-lib` subsystem, enabling per-subsystem logging control without code changes.

## Development

- Build: `swift build`
- Test:
  - local: `swift test`
  - using Docker: `make docker-test`
- Format: `make format`
- Check: `make check`

## Contributing

[Pull requests](https://github.com/BinaryBirds/swift-log-env/pulls) are welcome. Please keep changes focused and include tests for new logic.
