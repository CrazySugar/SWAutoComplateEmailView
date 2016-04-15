//
//  SWAutoComplateEmailView.h
//  SWAutoComplateEmailView
//
//  Created by 王炫殊 on 16/4/12.
//
//

#import <UIKit/UIKit.h>

@interface SWAutoComplateEmailView : UIScrollView <UITextFieldDelegate>

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

- (instancetype)initWithFrame:(CGRect)frame textField:(UITextField *)textField;

@end
