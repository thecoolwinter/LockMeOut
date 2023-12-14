#  LockMeOut

## A sample application for locking an app using Face/Touch ID.

![Recording](img/1.gif)

## How the flow works:

1. User starts the locking mechanism by tapping `Tap To Start`.  This sets a boolean to true that we'll check in `SceneDelegate`.
2. The app is restarted or moves away from the foreground.
3. The app is initialized.
4. We check for the boolean set in `1.`, if it's false we return and continue as normal.
5. If it's true, we present the `LockViewController` in full screen on the window.
6. `LockViewController` tries to authenticate the user, when it succeeds it dismisses itself.

## How it could be improved

1. Add a keypad to `LockViewController` and have the user set a 4-6 digit passcode for the case where biometric auth doesnt work or isn't supported.
2. Be able to init `LockViewController` in a `setup` mode so it can handle creating the passcode as well.


