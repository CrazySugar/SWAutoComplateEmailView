//
//  SWViewController.m
//  SWAutoComplateEmailView
//
//  Created by sugar on 04/14/2016.
//  Copyright (c) 2016 sugar. All rights reserved.
//

#import "SWViewController.h"
#import <SWAutoComplateEmailView/SWAutoComplateEmailView.h>

@interface SWViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIView *inferView;

@end

@implementation SWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.inferView.alpha = 0;
    SWAutoComplateEmailView *emailInferView = [[SWAutoComplateEmailView alloc] initWithFrame:self.inferView.frame textField:self.emailTextField];
    
    // Animation when showing or hiding. Defaults to 0.4
    emailInferView.animationDuration = 0.4;
    
    // Infer text height. Defaults to 30
    emailInferView.inferTextHeight = 30;
    
    // View's alpha while been shown. Defaults to 0.9
    emailInferView.viewAlpha = 0.9;
    
    // Right and left margin of the text. Defaults to 5
    emailInferView.inferTextInset = 5;
    
    // Color of the text that already typed
    emailInferView.typedTextColor = [UIColor darkGrayColor];
    
    // Color of the text that inferred
    emailInferView.inferredTextColor= [UIColor lightGrayColor];
    
    // The email suffixes to be inferred.
    emailInferView.emailSuffixes = @[
                                     @"163.com",
                                     @"126.com",
                                     @"yeah.net",
                                     @"188.com",
                                     @"vip.163.com",
                                     @"vip.126.com",
                                     @"corp.netease.com"
                                    ];
    // Defaults to the following.
    emailInferView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
    [self.view addSubview:emailInferView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
