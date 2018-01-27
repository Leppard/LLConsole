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
}

- (void)moveConsoleView:(UIPanGestureRecognizer *)sender {
    CGPoint translation = [sender translationInView:sender.view.superview];
    sender.view.center = CGPointMake(sender.view.center.x+translation.x, sender.view.center.y+translation.y);
    [sender setTranslation:CGPointZero inView:sender.view.superview];
    NSLog(@"%@", NSStringFromCGPoint(translation));
//    [UIView animateWithDuration:0.2 animations:^{
//        sender.view.center = CGPointMake(sender.view.center.x+translation.x, sender.view.center.y+translation.y);
//    }];
}

@end
