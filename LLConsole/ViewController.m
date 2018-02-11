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
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTappedHomePage)];
//    [self.view addGestureRecognizer:tap];
    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    switchButton.center = self.view.center;
    [switchButton addTarget:self action:@selector(switchButtonTapped:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switchButton];
}

//- (void)viewDidAppear:(BOOL)animated {
//    [[LLConsole shareConsole] start];
//}

#pragma mark - event response

- (void)switchButtonTapped:(id)sender {
    if (![sender isMemberOfClass:[UISwitch class]]) {
        return;
    }
    UISwitch *switchButton = (UISwitch *) sender;
    if (switchButton.isOn) {
        [[LLConsole shareConsole] start];
    } else {
        [[LLConsole shareConsole] stop];
    }
}

@end
