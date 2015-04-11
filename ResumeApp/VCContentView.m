//
//  VCContentView.m
//  ResumeApp
//
//  Created by zhulin on 15-4-9.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import "VCContentView.h"

@interface VCContentView ()

@end

@implementation VCContentView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view from its nib.
    //初始化顶部区域
    [self IniTopLabel];
    //初始化项目名称
    [self IniLabelName];
    //菊花
    _activityIndicationView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _activityIndicationView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    [_activityIndicationView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_activityIndicationView];
}
- (void)viewWillAppear:(BOOL)animated{
    [_activityIndicationView startAnimating];
}

- (void)viewDidAppear:(BOOL)animated{
    [_activityIndicationView stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//初始化顶部区域
- (void)IniTopLabel{
    _CtrlVTopLabel = [[VTopLabel alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_CtrlVTopLabel];
    [_CtrlVTopLabel SetLabel:@"项目介绍" isBackButtonShow:TRUE];
    _CtrlVTopLabel.DelBack = self;
}

//初始化项目名称
- (void)IniLabelName{
    //name
    _CtrlLProName = [[UILabel alloc] init];
    [self.view addSubview:_CtrlLProName];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_CtrlLProName]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view,_CtrlLProName)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[_CtrlLProName(==50)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view,_CtrlLProName)]];
    [_CtrlLProName setTranslatesAutoresizingMaskIntoConstraints:NO];
    _CtrlLProName.layer.cornerRadius = 10;
    _CtrlLProName.layer.masksToBounds = TRUE;
    _CtrlLProName.backgroundColor = [UIColor whiteColor];
    _CtrlLProName.font = [UIFont fontWithName:@"Verdana-Bold" size:25];

    
    //content
    _CtrlVProContent = [[UITextView alloc] init];
    [self.view addSubview:_CtrlVProContent];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_CtrlVProContent]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view,_CtrlVProContent)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-140-[_CtrlVProContent]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.view,_CtrlVProContent)]];
    [_CtrlVProContent setTranslatesAutoresizingMaskIntoConstraints:NO];
    _CtrlVProContent.layer.cornerRadius = 10;
    _CtrlVProContent.layer.masksToBounds = TRUE;
    _CtrlVProContent.backgroundColor = [UIColor whiteColor];
    _CtrlVProContent.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _CtrlVProContent.scrollEnabled = YES;
    _CtrlVProContent.editable = FALSE;
    _CtrlVProContent.font = [UIFont fontWithName:@"AppleGothic" size:20];
}


//设置内容
- (void)SetContent:(NSString*)strName strContent:(NSString*)strContent{
    if (strName && strName.length > 0) {
        _CtrlLProName.text = strName;
    }
    else{
        _CtrlLProName.text = @" ";
    }
    
    if (strContent && strContent.length > 0) {
        _CtrlVProContent.text = strContent;
    }
    else{
        _CtrlVProContent.text = @" ";
    }
}

//返回
- (void)BackClick:(id)sender{
    [_DelBack BackClick:self];
}











@end
