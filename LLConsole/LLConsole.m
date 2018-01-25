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
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (!self.consoleView) {
        LLConsoleView *consoleView = [[LLConsoleView alloc] initWithFrame:keyWindow.frame];
        [[[UIApplication sharedApplication] keyWindow] addSubview:consoleView];
        [UIView animateWithDuration:1 animations:^{
            consoleView.frame = CGRectMake(keyWindow.bounds.origin.x+50, keyWindow.bounds.origin.y, keyWindow.bounds.size.width-50, keyWindow.bounds.size.height);
        }];
    }
}

void LLLog(NSString *format, ...) {
    va_list ap;
    NSLog(format, ap);
    // 如果LLConsole启动，那么输出到consoleView；如果没有启动，使用NSlog输出
}


@end
