//
//  VTopLabel.h
//  ResumeApp
//
//  Created by zhulin on 15-4-10.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProBack

- (void)BackClick:(id)sender;

@end

@interface VTopLabel : UIView

@property (nonatomic,strong)id<ProBack> DelBack;
@property (nonatomic,strong)UILabel                 *CtrlLabelView;
@property (nonatomic,strong)UIButton                *CtrlButton;
- (void)SetLabel:(NSString*)strLabelName isBackButtonShow:(BOOL)isBackShow;
@end
