//
//  LoggerSubsystemTests.swift
//  swift-log-env
//
//  Created by Binary Birds on 2026. 02. 04.

import Foundation
import Logging
import Testing

@testable import SwiftLogEnv

private func withEnvironment(
    _ updates: [String: String?],
    _ body: () throws -> Void
) rethrows {
    var previous: [String: String?] = [:]
    for (key, value) in updates {
        previous[key] = ProcessInfo.processInfo.environment[key]
        if let value {
            setenv(key, value, 1)
        }
        else {
            unsetenv(key)
        }
    }

    defer {
        for (key, value) in previous {
            if let value {
                setenv(key, value, 1)
            }
            else {
                unsetenv(key)
            }
        }
    }

    try body()
}

@Suite(.serialized)
struct LoggerSubsystemTests {
    @Test
    func usesProvidedLevelWhenNoOverrides() throws {
        withEnvironment([
            "LOG_LEVEL": nil,
            "MY_LIB_LOG_LEVEL": nil,
        ]) {
            let logger = Logger.subsystem("my-lib", .notice)
            #expect(logger.label == "my-lib")
            #expect(logger.logLevel == .notice)
        }
    }

    @Test
    func globalOverrideBeatsProvidedLevel() throws {
        withEnvironment([
            "LOG_LEVEL": "debug",
            "MY_LIB_LOG_LEVEL": nil,
        ]) {
            let logger = Logger.subsystem("my-lib", .error)
            #expect(logger.logLevel == .debug)
        }
    }

    @Test
    func subsystemOverrideBeatsGlobalOverride() throws {
        withEnvironment([
            "LOG_LEVEL": "info",
            "MY_LIB_LOG_LEVEL": "trace",
        ]) {
            let logger = Logger.subsystem("my-lib", .error)
            #expect(logger.logLevel == .trace)
        }
    }

    @Test
    func invalidOverrideFallsBackToProvidedLevel() throws {
        withEnvironment([
            "LOG_LEVEL": "not-a-level",
            "MY_LIB_LOG_LEVEL": nil,
        ]) {
            let logger = Logger.subsystem("my-lib", .warning)
            #expect(logger.logLevel == .warning)
        }
    }

    @Test
    func subsystemOverrideUsesTransformedKey() throws {
        withEnvironment([
            "MY_LIB_LOG_LEVEL": "critical"
        ]) {
            let logger = Logger.subsystem("my-lib", .info)
            #expect(logger.logLevel == .critical)
        }
    }
}
