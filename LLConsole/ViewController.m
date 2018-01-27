//
//  ViewController.m
//  LLConsole
//
//  Created by Leppard on 24/01/2018.
//  Copyright © 2018 Leppard. All rights reserved.
//

#import "ViewController.h"
#import "LLConsole.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedHomePage)];
    [self.view addGestureRecognizer:tap];
    LLLog(@"asdasd, asd");
    
}

#pragma mark - event response

- (void)didTappedHomePage {
    self.view.backgroundColor = [UIColor redColor];
    [[LLConsole shareConsole] start];
}

@end
