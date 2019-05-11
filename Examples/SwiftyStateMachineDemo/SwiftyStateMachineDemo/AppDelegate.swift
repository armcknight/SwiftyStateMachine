//
//  AppDelegate.swift
//  SwiftyStateMachineDemo
//
//  Created by Andrew McKnight on 4/29/19.
//  Copyright © 2019 Andrew McKnight. All rights reserved.
//

import SwiftyStateMachine
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // This shows how to define the `transitionLogic` as a trailing closure, instead of as references to other functions as in `ViewController`.
    let schema = Schema(initialState: .notRunning) { (state, event) -> Schema.TransitionTuple? in
        switch state {
        case .notRunning:
            switch event {
            case .launch: return (.running, { _ in
                print("launched")
            })
            }
        case .running: return nil
        }
    }
    
    private let machine: StateMachine<Schema>

    override init() {
        machine = StateMachine<Schema>(schema: schema, subject: ()) // this is how you init a machine with a Void Subject
        super.init()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        machine.handleEvent(.launch)
        return true
    }
}

extension AppDelegate {
    enum State: CaseIterable {
        case notRunning
        case running
    }

    enum Event: CaseIterable {
        case launch
    }

    typealias Schema = GraphableStateMachineSchema<State, Event, Void>
}

extension AppDelegate.Event: DOTLabelable {}
extension AppDelegate.State: DOTLabelable {}
