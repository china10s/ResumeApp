//
//  ViewController.m
//  ResumeApp
//
//  Created by zhulin on 15-4-9.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _CtrlMenuView = [[VCMenuView alloc] initWithNibName:@"VCMenuView" bundle:[NSBundle mainBundle]];
    [self addChildViewController:_CtrlMenuView];
    [self.view addSubview:_CtrlMenuView.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
