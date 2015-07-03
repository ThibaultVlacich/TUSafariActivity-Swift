# TUSafariActivity

`TUSafariActivity` is a `UIActivity` subclass that provides an "Open In Safari" action to a `UIActivityViewController`.

![TUSafariActivity screenshot](http://cl.ly/image/2i0n0H3f2g1X/TUSafariActivity.png "TUSafariActivity screenshot")

## Installation

### Manual

To install TUSafariActivity, just add the content of the `Source` folder into your Xcode Project

## Usage

```swift
let URL = NSURL(string: "http://google.com")!
let activity = TUSafariActivity()
let activityViewController = UIActivityViewController(activityItems: [URL], applicationActivities: [activity])
```

Note that you can include the activity in any `UIActivityViewController` and it will only be shown to the user if there is a URL in the activity items.