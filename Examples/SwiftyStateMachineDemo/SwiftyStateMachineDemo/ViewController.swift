//
//  ViewController.swift
//  SwiftyStateMachineDemo
//
//  Created by Andrew McKnight on 4/29/19.
//  Copyright © 2019 Andrew McKnight. All rights reserved.
//

import SwiftyStateMachine
import UIKit

class ViewController: UIViewController {
    lazy var schema: Schema = {
        // This shows how to pass a function reference as the `transitionLogic` parameter's value, instead of the trailing closure version in `AppDelegate`.
        return Schema(initialState: .idle, transitionLogic: shouldTransition)
    }()
    
    private lazy var machine: StateMachine<Schema> = {
        let machine = StateMachine<Schema>(schema: schema, subject: button)

        // This demonstrates usage of this optional callback in `StateMachine`, whereas `AppDelegate`'s more simple example doesn't use it.
        machine.didTransitionCallback = didTransition

        return machine
    }()

    @IBOutlet var button: UIButton!
    @IBOutlet weak var label: UILabel!
}

extension ViewController {
    @IBAction func clicked(_ sender: Any) {
        machine.handleEvent(.click)
    }
}

extension ViewController {
    enum State: CaseIterable {
        case idle
        case clickedOnce
        case clickedTwice
    }

    enum Event: CaseIterable {
        case click
    }

    /// The logic to determine, given a current state and an event, which state (if any) towards which the state machine should transition, and an optional block of logic to execute with a reference to the `Subject` object of the state machine.
    func shouldTransition(state: State, event: Event) -> Schema.TransitionTuple? {
        switch state {
        case .idle:
            switch event {
            case .click:
                return (State.clickedOnce, { subject in
                    // optional closure to execute as part of the transition
                    subject.setTitle("Click again!", for: .normal)
                })
            }

        case .clickedOnce:
            switch event {
            case .click:
                // we should've also updated the `Subject`'s (button's) state here, but want to demonstrate how to return a new state with no associated closure, since it's optional. See `didTransition(from:event:to:)`.
                return (State.clickedTwice, nil)
            }

        case .clickedTwice:
            switch event {
            case .click:
                return nil // signifies illegal transition
            }

        }
    }

    /// A function to call after a given legal transition has occurred, provided to the optional `didTransitionCallback`.
    func didTransition(from: State, event: Event, to: State) {
        switch to {
        case .idle: fatalError("Currently no way to transition back to idle state")
        case .clickedOnce: label.text = "You can click one more time..."
        case .clickedTwice:
            label.text = "Done!"

            // Because the button is the subject, we could (and should) have done this in the transition logic closure for the schema, but left that one with a nil transition closure to demonstrate all three combinations of possible return values. In practice, the art will come down to deciding where side-effects should be contained, between `transitionLogic` and `didTransitionCallback`.
            button.isEnabled = false
        }
    }

    typealias Schema = GraphableStateMachineSchema<State, Event, UIButton>
}

extension ViewController.Event: DOTLabelable {}
extension ViewController.State: DOTLabelable {}
