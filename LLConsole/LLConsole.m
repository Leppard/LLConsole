//
//  LLConsole.m
//  LLConsole
//
//  Created by Leppard on 24/01/2018.
//  Copyright © 2018 Leppard. All rights reserved.
//

#import "LLConsole.h"
#import "LLConsoleView.h"

static LLConsole *console;

@interface LLConsole ()

@property (nonatomic, strong) LLConsoleView *consoleView;
@property (nonatomic, assign) BOOL isStarted;

@end

@implementation LLConsole

#pragma mark - life cycle

+ (instancetype)shareConsole {
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        console = [[LLConsole alloc] init];
    });
    return console;
}


#pragma mark - pulic methods

- (void)start {
    if (self.isStarted) {
        return;
    }
    [self setUpConsoleView];
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:1 animations:^{
        self.consoleView.frame = CGRectMake(keyWindow.bounds.origin.x, keyWindow.bounds.origin.y+50, 50, 50);
        }];
    
    self.isStarted = YES;
}

void LLLog(NSString *format, ...) {
    va_list ap;
    va_start(ap, format);
    NSLogv(format, ap);
    va_end(ap);
    // 如果LLConsole启动，那么输出到consoleView；如果没有启动，使用NSlog输出
}

#pragma mark - private methods

- (void)setUpConsoleView {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    self.consoleView = [[LLConsoleView alloc] initWithFrame:keyWindow.frame];
    [keyWindow addSubview:self.consoleView];
    [self addGestureToConsoleView];
}

- (void)addGestureToConsoleView {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveConsoleView:)];
    [self.consoleView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedConsoleView:)];
    [self.consoleView addGestureRecognizer:tap];
}

- (void)moveConsoleView:(UIPanGestureRecognizer *)sender {
    UIView *superView = sender.view.superview;
    CGPoint translation = [sender translationInView:superView];
    sender.view.center = CGPointMake(sender.view.center.x+translation.x, sender.view.center.y+translation.y);
    [sender setTranslation:CGPointZero inView:superView];
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.4 animations:^{
            sender.view.center = sender.view.center.x < superView.bounds.size.width/2 ? CGPointMake(sender.view.bounds.size.width/2, sender.view.center.y) :  CGPointMake(superView.bounds.size.width-sender.view.bounds.size.width/2, sender.view.center.y);
        }];
    }
}

- (void)didTappedConsoleView:(UITapGestureRecognizer *)sender {
    UIView *superView = sender.view.superview;
    [UIView animateWithDuration:0.5 animations:^{
        sender.view.frame = sender.view.bounds.size.width > 50 ? CGRectMake(superView.bounds.origin.x, superView.bounds.origin.y+50, 50, 50) : superView.bounds;
    }];
}

@end
