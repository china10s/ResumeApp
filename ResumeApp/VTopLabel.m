//
//  VTopLabel.m
//  ResumeApp
//
//  Created by zhulin on 15-4-10.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import "VTopLabel.h"
#import "HPublic.h"

@implementation VTopLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor redColor];
    _CtrlLabelView = [[UILabel alloc] init];
    [self addSubview:_CtrlLabelView];
    _CtrlButton = [[UIButton alloc] init];
    [self addSubview:_CtrlButton];
    
    return self;
}

- (void)SetLabel:(NSString*)strLabelName isBackButtonShow:(BOOL)isBackShow{
    //自身布局
    NSString* strHEntireLayout = [NSString stringWithFormat:@"V:|[self(==%d)]",LABELHEIGHT];
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:strHEntireLayout options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.superview,self)]];
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.superview,self)]];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //Label布局
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_CtrlLabelView(==20)]-9-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self,_CtrlLabelView)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_CtrlLabelView]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self,_CtrlLabelView)]];
    [_CtrlLabelView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _CtrlLabelView.text = strLabelName;
    _CtrlLabelView.textAlignment = NSTextAlignmentCenter;
    _CtrlLabelView.textColor = [UIColor whiteColor];
    
    //返回button布局
    if (isBackShow) {
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_CtrlButton(==30)]-9-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self,_CtrlButton)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-9-[_CtrlButton(==30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self,_CtrlButton)]];
        [_CtrlButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_CtrlButton setBackgroundImage:[UIImage imageNamed:@"icon_btn_rtn"] forState:UIControlStateNormal];
        [_CtrlButton addTarget:self action:@selector(BackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

- (void)BackButtonClick:(id)sender{
    [_DelBack BackClick:self];
}




@end
