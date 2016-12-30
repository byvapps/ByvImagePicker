# ByvImagePicker

[![CI Status](http://img.shields.io/travis/Adrian_Apodaca/ByvImagePicker.svg?style=flat)](https://travis-ci.org/Adrian_Apodaca/ByvImagePicker)
[![Version](https://img.shields.io/cocoapods/v/ByvImagePicker.svg?style=flat)](http://cocoapods.org/pods/ByvImagePicker)
[![License](https://img.shields.io/cocoapods/l/ByvImagePicker.svg?style=flat)](http://cocoapods.org/pods/ByvImagePicker)
[![Platform](https://img.shields.io/cocoapods/p/ByvImagePicker.svg?style=flat)](http://cocoapods.org/pods/ByvImagePicker)


ByvImagePicker is a NSObject class that can present an action sheet to select the UIImagePickerController source type and let edit image with [TOCropViewController](https://github.com/TimOliver/TOCropViewController) in 3 different ways.

## Usage

To only display picker:
```swift
@IBAction func pickImage(_ sender: UIButton) {
    if picker == nil {
        picker = ByvImagePicker()
    }
    let from = ByvFrom(controller: self, from:sender.frame, inView:self.view, arrowDirections:.any)
    picker!.getImage(from: from, completion: { image in
        self.imageView.image = image
    })
}
```

To pick editable image:
```swift
@IBAction func pickAndEdit(_ sender: UIButton) {
    if picker == nil {
        picker = ByvImagePicker()
    }
    let from = ByvFrom(controller: self, from:sender.frame, inView:self.view, arrowDirections:.any)
    picker!.getImage(from: from, editable:true, completion: { image in
        self.imageView.image = image
    })
}
```

To pick an Image with forced aspect ratio:
```swift
@IBAction func pickAndCrop(_ sender: UIButton) {
    if picker == nil {
        picker = ByvImagePicker()
    }
    let from = ByvFrom(controller: self, from:sender.frame, inView:self.view, arrowDirections:.any)
    picker!.getFixedImage(from: from, customAspectRatio: imageView.bounds.size, completion: { image in
        self.imageView.image = image
    })
}
```

To pick a circular image:
```swift
@IBAction func pickProfile(_ sender: UIButton) {
    if picker == nil {
        picker = ByvImagePicker()
    }
    let from = ByvFrom(controller: self, from:sender.frame, inView:self.view, arrowDirections:.any)
    picker!.getCircularImage(from: from, completion: { image in
        self.profileImage.image = image
    })
}
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ByvImagePicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```swift
pod "ByvImagePicker"
```

## Author

Adrian Apodaca, adrian@byvapps.com

## License

ByvImagePicker is available under the MIT license. See the LICENSE file for more info.
