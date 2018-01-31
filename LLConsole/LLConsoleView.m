//
//  LLConsoleView.m
//  LLConsole
//
//  Created by Leppard on 24/01/2018.
//  Copyright © 2018 Leppard. All rights reserved.
//

#import "LLConsoleView.h"

@interface LLConsoleView ()

@property (nonatomic, strong) UITextView *logView;

@end

@implementation LLConsoleView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        _logView = [[UITextView alloc] initWithFrame:CGRectZero];
        _logView.backgroundColor = [UIColor blackColor];
        _logView.textColor = [UIColor whiteColor];
        _logView.font = [UIFont systemFontOfSize:12];
        _logView.userInteractionEnabled = NO;
        [self addSubview:_logView];
    }
    return self;
}

- (void)layoutSubviews {
    _logView.frame = CGRectMake(self.bounds.origin.x+10, self.bounds.origin.y+10, self.bounds.size.width-20, self.bounds.size.height-20);
}

#pragma mark - public methods

- (void)logToViewWithString:(NSString *)string {
    NSString *oldStr = _logView.text;
    if (![oldStr isEqualToString:@""]) {
        oldStr = [oldStr stringByAppendingString:@"\n"];
    }
    _logView.text = [oldStr stringByAppendingString:string];
}

@end
