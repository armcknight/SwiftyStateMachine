#  SwiftyStateMachineDemo

Provides some examples of usage in a simple app.

## AppDelegate

Demonstrates a simple state machine:

- uses `Void` type for the schema `Subject`
- transition logic provided inline with the init of the state machine as a trailing closure
- doesn't provide a `didTransitionCallback`

## ViewController

Demonstrates an advanced setup:

- Uses `UIButton` type for `Subject` and shows how to modify UI state as part of transitions
- Define a separate function for transition logic, whose reference is passed into `StateMachine.init`
- Provides a `didTransitionCallback`, also as a reference to a separate function instead of a closure

## Other details

There's a `protocol StateMachineControllable` that requires conformers to have a reference to a state machine whose schema provides the types required to output a generated diagram of itself. (In particular, it declares `associatedtypes` for the `State` and `Event` types that conform to `DOTLabelable`, which is a requirement of `GraphableStateMachineSchema`)



