//
//  LLConsole.h
//  LLConsole
//
//  Created by Leppard on 24/01/2018.
//  Copyright © 2018 Leppard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LLConsole : UIViewController

+ (instancetype)shareConsole;

// C version log function, not finished
//void LLLog(NSString *format, ...) NS_FORMAT_FUNCTION(1,2)

- (void)log:(NSString *)format, ...;

- (void)start;

- (void)stop;

@end
