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

@property (nonatomic, assign) CGRect iconFrame;

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
    if (_isStarted) {
        return;
    }
    [self setUpConsoleView];
    _isStarted = YES;
}

- (void)stop {
    [_consoleView removeFromSuperview];
    _isStarted = NO;
}

// C version log function, not finished
//void LLLog(NSString *format, ...) {
//    va_list ap;
//    va_start(ap, format);
//    NSLogv(format, ap);
//    va_end(ap);
//}

- (void)log:(NSString *)format, ... {
    va_list ap;
    va_start(ap, format);
    if (_isStarted) {
        NSString *str = [NSString stringWithFormat:format, ap];
        [_consoleView logToViewWithString:str];
    } else {
        NSLog(@"LLConsole haven't started, call START method first.");
        NSLogv(format, ap);
    }
    va_end(ap);
}

#pragma mark - private methods

- (void)setUpConsoleView {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _consoleView = [[LLConsoleView alloc] initWithFrame:CGRectMake(keyWindow.bounds.origin.x, keyWindow.bounds.origin.y+50, 50, 50)];
    [keyWindow addSubview:_consoleView];
    [self addGestureToConsoleView];
    
    _iconFrame = _consoleView.frame;
}

- (void)addGestureToConsoleView {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveConsoleView:)];
    [_consoleView addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedConsoleView:)];
    [_consoleView addGestureRecognizer:tap];
}

- (void)moveConsoleView:(UIPanGestureRecognizer *)sender {
    UIView *superView = sender.view.superview;
    CGPoint translation = [sender translationInView:superView];
    sender.view.center = CGPointMake(sender.view.center.x+translation.x, sender.view.center.y+translation.y);
    [sender setTranslation:CGPointZero inView:superView];
    if (sender.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.4 animations:^{
            sender.view.center = sender.view.center.x < superView.bounds.size.width/2 ? CGPointMake(sender.view.bounds.size.width/2, sender.view.center.y) :  CGPointMake(superView.bounds.size.width-sender.view.bounds.size.width/2, sender.view.center.y);
        } completion:^(BOOL finished) {
            _iconFrame = sender.view.frame;
        }];
    }
}

- (void)didTappedConsoleView:(UITapGestureRecognizer *)sender {
    UIView *superView = sender.view.superview;
    [UIView animateWithDuration:0.5 animations:^{
        sender.view.frame = sender.view.bounds.size.width > 50 ? _iconFrame : superView.bounds;
        [sender.view layoutIfNeeded];
    }];
}

@end
