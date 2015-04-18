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
    //下拉后的背景
    UIView * viewBack = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    viewBack.backgroundColor = [UIColor grayColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [viewBack addSubview:label];
    label.text = @"designed by china10s";
    label.textAlignment = NSTextAlignmentCenter;
    [viewBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(viewBack,label)]];
    [viewBack addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(viewBack,label)]];
    
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //可下拉
    UIScrollView * viewScroll = [[UIScrollViewExt alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGSize size = [UIScreen mainScreen].bounds.size;
    size.height += 1;
    
    viewScroll.contentSize = size;
    viewScroll.contentOffset = CGPointZero;
    viewScroll.scrollEnabled = TRUE;
    
    
    self.view = viewBack;
    [viewBack addSubview:viewScroll];
    
    _CtrlMenuView = [[VCMenuView alloc] initWithNibName:@"VCMenuView" bundle:[NSBundle mainBundle]];
    [self addChildViewController:_CtrlMenuView];
    [viewScroll addSubview:_CtrlMenuView.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
