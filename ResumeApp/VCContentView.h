//
//  VCContentView.h
//  ResumeApp
//
//  Created by zhulin on 15-4-9.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTopLabel.h"

@interface VCContentView : UIViewController<ProBack>
@property (nonatomic,strong) id<ProBack>                    DelBack;
@property (nonatomic,strong) VTopLabel                      *CtrlVTopLabel;
@property (nonatomic,strong) UILabel                        *CtrlLProName;
@property (nonatomic,strong) UITextView                     *CtrlVProContent;
@property (nonatomic,strong)UIActivityIndicatorView         *activityIndicationView;
- (void)SetContent:(NSString*)strName strContent:(NSString*)strContent;
@end
