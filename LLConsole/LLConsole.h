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

void LLLog(NSString *format, ...);

- (void)start;

@end