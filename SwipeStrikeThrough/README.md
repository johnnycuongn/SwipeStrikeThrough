#  SwipeStrikeThrough

# About

A simple framework with strikethrough applications:

- Add strike through to your string,
- StrikeThroughLabel helps swiping to strike easier

# How To Use

### Add strikethrough to a string

```swift
var myLabel = "aaaaaa"

// Add strikethrough
var strikedLabel = myLabel.strikeThrough(.add)

// Remove strikethrough from attributedString
var unStrikedLabel = strikedLabel?.string.strikeThrough(.remove)
```

### Add a label that can swiped to strike by user

```swift
// In ViewController
@IBOutlet weak var myLabel: StrikeThroughLabel!
```

That's all you have to do, by replace `UILabel` with `StrikethroughLabel`

→ Now when you swipe, the strikethough will follow

# Notice ⚠️

### Multiple Gestures

If you applied to mutiple gesture, make sure to conform to `UIGestureRecognizerDelegate`, with below function:

```swift
override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
```

Make sure to refer to: [https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/coordinating_multiple_gesture_recognizers](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/coordinating_multiple_gesture_recognizers)

### Drawbacks

StrikeThroughLabel use only PanGestureRecognizer, with panning right enable but not left enable.

### Solutions

You can add another Pan Gesture, or change directly into framework code

Inside function handlePan(gesture:) :

`xTranslation` > 0: User start swiping from left to right (This is already for swipe to strike through)

`xTranslation` < 0 : User start swiping from right to left (Not yet handle)
