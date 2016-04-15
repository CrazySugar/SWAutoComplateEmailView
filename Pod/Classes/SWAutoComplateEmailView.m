//
//  SWAutoComplateEmailView.m
//  SWAutoComplateEmailView
//
//  Created by 王炫殊 on 16/4/12.
//
//



// 坑：textField已有了delegate，肯定不能直接改
// textField失焦的时候，要hide提示框

#import "SWAutoComplateEmailView.h"
#import "TTTAttributedLabel.h"

@interface SWAutoComplateEmailView ()

// 点了自动补全的文字，需要修改原textField。所以要持有。
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, strong) id originalDelegate;

@end

@implementation SWAutoComplateEmailView

- (void)setEmailSuffix:(NSArray *)suffixes {
    
}

- (instancetype)initWithFrame:(CGRect)frame textField:(UITextField *)textField {
    self = [super initWithFrame:frame];
    if (self) {
        self.originalDelegate = textField.delegate;
        textField.delegate = self;
        self.emailSuffixes = @[
                               @"163.com",
                               @"126.com",
                               @"yeah.net",
                               @"188.com",
                               @"vip.163.com",
                               @"vip.126.com",
                               @"corp.netease.com"
                               ];
        self.alpha = 0.0;
        self.animationDuration = 0.4;
        self.inferTextHeight = 30.0;
        self.viewAlpha = 0.9;
        self.inferTextInset = 5;
        self.textField = textField;
        self.typedTextColor = [UIColor darkGrayColor];
        self.inferredTextColor = [UIColor lightGrayColor];
        self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.9];
    }
    return self;
}

#pragma mark - textField delegates
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL result = YES;
    
    if ([self.originalDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        result = [self.originalDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    if (result) {
        NSString *newString = [self.textField.text stringByReplacingCharactersInRange:range withString:string];
        if (![newString isEqualToString:@""]) {
            [self showInferView:newString];
        } else{
            [self hideInferView];
        }
    }
    
    return result;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    BOOL result = YES;
    
    if ([self.originalDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        result = [self.originalDelegate textFieldShouldBeginEditing:textField];
    }
    
    if (result) {
        if (![textField.text isEqualToString:@""]) {
            [self showInferView:textField.text];
        } else{
            [self hideInferView];
        }
    }
    
    return result;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.originalDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.originalDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.originalDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.originalDelegate textFieldShouldEndEditing:textField];
    } else {
        return YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.originalDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.originalDelegate textFieldDidEndEditing:textField];
    }
    [self hideInferView];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([self.originalDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.originalDelegate textFieldShouldClear:textField];
    } else {
        return YES;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.originalDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.originalDelegate textFieldShouldReturn:textField];
    } else {
        return YES;
    }
}


// 调用这个方法的时候，text还没改变，所以传入最新的textFieldText
-(void)showInferView:(NSString*)textFieldText{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSArray* mailPrefix_Surfix = [textFieldText componentsSeparatedByString:@"@"];
    NSString *prefixString, *surfixString;
    
    if (mailPrefix_Surfix.count == 1) {
        prefixString = textFieldText;
        surfixString = @".*";
    } else if(mailPrefix_Surfix.count == 2){
        prefixString = mailPrefix_Surfix[0];
        surfixString = [NSString stringWithFormat:@"%@%@", mailPrefix_Surfix[1], @".*"];
    }else{
        [self hideInferView];
        return;
    }
    NSPredicate *mailSurfixPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", surfixString];
    NSArray *textToBeInferred = [self.emailSuffixes filteredArrayUsingPredicate:mailSurfixPred];
    if (textToBeInferred.count > 0) {
        
        // constraits限制死了，无法改高度
        // 删去constrain
        if(textToBeInferred.count < 3){
            NSLog(@"count xnyu 3");
            CGRect frame = self.frame;
            frame.size.height = textToBeInferred.count * self.inferTextHeight * 3;
            self.frame = frame;
        } else {
            CGRect frame = self.frame;
            frame.size.height = textToBeInferred.count * self.inferTextHeight;
            self.frame = frame;
        }
        if (self.alpha == 0.0) {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.alpha = self.viewAlpha;
            }];
        }
        self.contentSize = CGSizeMake(self.bounds.size.width, textToBeInferred.count * self.inferTextHeight);
        
        for (int index = 0; index < textToBeInferred.count; index++) {
            TTTAttributedLabel *oneTextLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(self.inferTextInset, index*self.inferTextHeight, self.bounds.size.width-self.inferTextInset, self.inferTextHeight)];
            oneTextLabel.font = [UIFont systemFontOfSize:14];
            oneTextLabel.numberOfLines = 1;
            
            NSString *labelText = [NSString stringWithFormat:@"%@@%@",prefixString, textToBeInferred[index]];
            NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:labelText];
            [attrString addAttribute: (NSString*) kCTForegroundColorAttributeName
                               value: (id)self.inferredTextColor.CGColor
                               range: NSMakeRange(0, labelText.length)];
            
            [attrString addAttribute: (NSString*) kCTForegroundColorAttributeName
                               value: (id)self.typedTextColor.CGColor
                               range: [labelText rangeOfString:textFieldText]];
            
            
            [oneTextLabel setText:attrString];
            //            oneTextLabel.text = [NSString stringWithFormat:@"%@@%@",prefixString, textToBeInferred[index]];
            [oneTextLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressOnInferText:)]];
            oneTextLabel.userInteractionEnabled = YES;
            [self addSubview:oneTextLabel];
            
            // separate line
            if (index < textToBeInferred.count - 1) {
                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.inferTextInset, (index+1)*self.inferTextHeight - 1, self.bounds.size.width-self.inferTextInset*2, 1)];
                lineView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:.2];
                [self addSubview:lineView];
            }
        }
    }else{
        [self hideInferView];
    }
}

- (void)pressOnInferText:(UITapGestureRecognizer*)gestureRecognizer{
    NSString* inferText = ((UILabel*)gestureRecognizer.view).text;
    self.textField.text = inferText;
    [self hideInferView];
}

- (void)hideInferView{
    [UIView animateWithDuration:self.animationDuration animations:^{
        self.alpha = 0.0;
    }];
}

@end
