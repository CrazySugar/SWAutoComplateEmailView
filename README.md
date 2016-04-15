# SWAutoComplateEmailView

[![CI Status](http://img.shields.io/travis/sugar/SWAutoComplateEmailView.svg?style=flat)](https://travis-ci.org/sugar/SWAutoComplateEmailView)
[![Version](https://img.shields.io/cocoapods/v/SWAutoComplateEmailView.svg?style=flat)](http://cocoapods.org/pods/SWAutoComplateEmailView)
[![License](https://img.shields.io/cocoapods/l/SWAutoComplateEmailView.svg?style=flat)](http://cocoapods.org/pods/SWAutoComplateEmailView)
[![Platform](https://img.shields.io/cocoapods/p/SWAutoComplateEmailView.svg?style=flat)](http://cocoapods.org/pods/SWAutoComplateEmailView)

## Usage

An UIScrollView subclass to auto complete email address input.

You can initialize the inferred text field like:

```Objective-C
SWAutoComplateEmailView *emailInferView = [[SWAutoComplateEmailView alloc] initWithFrame:self.inferView.frame textField:self.emailTextField];
```

You can customize the following properties.

```Objective-C
// defaults to 0.4
@property (nonatomic) CGFloat animationDuration;

// defaults to 30
@property (nonatomic) CGFloat inferTextHeight;

// defaults to 0.9
@property (nonatomic) CGFloat viewAlpha;

// defaults to 5
@property (nonatomic) CGFloat inferTextInset;

@property (nonatomic, strong) UIColor *typedTextColor;

@property (nonatomic, strong) UIColor *inferredTextColor;

/**
 Format:
 self.emailSuffixes = @[
                        @"163.com",
                        @"126.com",
                        @"yeah.net",
                        @"188.com",
                        @"vip.163.com",
                        @"vip.126.com",
                        @"corp.netease.com"
                        ];
 */
@property (nonatomic, strong) NSArray *emailSuffixes;
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

If the 'Run' button is gray, edit current scheme and choose the executable.

## Installation

SWAutoComplateEmailView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SWAutoComplateEmailView"
```

## Author

sugar, w90826@gmail.com

## License

SWAutoComplateEmailView is available under the MIT license. See the LICENSE file for more info.
