//
//  SwiftyStateMachineDemoDiagramGenerator.swift
//  SwiftyStateMachineDemoDiagramGenerator
//
//  Created by Andrew McKnight on 5/10/19.
//  Copyright © 2019 Andrew McKnight. All rights reserved.
//

@testable import SwiftyStateMachineDemo
import XCTest

class SwiftyStateMachineDemoDiagramGenerator: XCTestCase {
    func testGenerateDiagrams() {
        let diagrams = [
            NSStringFromClass(AppDelegate.self): AppDelegate().schema.DOTDigraph,
            NSStringFromClass(ViewController.self): ViewController(nibName: nil, bundle: nil).schema.DOTDigraph,
            ]

        let directory = URL(fileURLWithPath: ProcessInfo.processInfo.environment["__XCODE_BUILT_PRODUCTS_DIR_PATHS"]!.removingPercentEncoding!)
        diagrams.forEach {
            let url = directory.appendingPathComponent("\($0.key.split(separator: ".").last!).dot")
            print("writing to \(url)")
            try! $0.value.data(using: .utf8)?.write(to: url)
        }
    }
}
