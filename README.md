# AYPullBoard

[![CI Status](https://img.shields.io/travis/antonyereshchenko@gmail.com/AYPullBoard.svg?style=flat)](https://travis-ci.org/antonyereshchenko@gmail.com/AYPullBoard)
[![Version](https://img.shields.io/cocoapods/v/AYPullBoard.svg?style=flat)](https://cocoapods.org/pods/AYPullBoard)
[![License](https://img.shields.io/cocoapods/l/AYPullBoard.svg?style=flat)](https://cocoapods.org/pods/AYPullBoard)
[![Platform](https://img.shields.io/cocoapods/p/AYPullBoard.svg?style=flat)](https://cocoapods.org/pods/AYPullBoard)

<p align="center">
  <img width="64%" height="64%" src="https://github.com/bananaRanger/AYPullBoard/blob/master/Resources/logo.png?raw=true">
</p>

## About

AYPullBoardView - help you to display additional information for the user, or get some data from him in a separate interactive view.

## Installation

AYPullBoardView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
inhibit_all_warnings!

target 'YOUR_TARGET_NAME' do
  use_frameworks!
	pod 'AYPullBoardView'
end
```

### Demo

<p align="center">
  <img width="50%" height="50%" src="https://github.com/bananaRanger/AYPullBoard/blob/master/Resources/demo.gif?raw=true">
</p>

## Usage

<p align="center">
  <img width="80%" height="80%" src="https://github.com/bananaRanger/AYPullBoard/blob/master/Resources/expl.png?raw=true">
</p>

```swift
// 'pullContentView' - object of 'AYPullBoardView' type.
// 'itemView' - UIView that should be located on 'pullContentView'.

pullContentView.add(view: itemView)

pullContentView.setInitialYPercentBoard(position: 0.8) 
pullContentView.setFinalYPercentBoard(position: 0.2)  

/* OR

pullContentView.setInitialYValueBoard(position: 500) 
pullContentView.setFinalYValueBoard(position: 64)  

*/

pullContentView.movingAnimationDuration = 0.64
pullContentView.draggingAnimationDuration = 0.16

// toggling the state (without animation)
pullContentView.isExpanded = true 

// toggling the state (with animation)
pullContentView.setIsExpanded(true, animated: true)
```

## Author

[📧](mailto:anton.yereshchenko@gmail.com?subject=[GitHub]%20Source%20AYPullBoard) Anton Yereshchenko

## License

AYPullBoardView is available under the MIT license. See the LICENSE file for more info.

## Used in project

Icons & photos:

Icons8 - https://icons8.com
