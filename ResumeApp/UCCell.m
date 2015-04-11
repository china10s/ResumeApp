//
//  UCCell.m
//  ResumeApp
//
//  Created by zhulin on 15-4-11.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import "UCCell.h"

@implementation UCCell

- (void)awakeFromNib {
    // Initialization code

}

- (instancetype)init{
    //self = [self init];
    _CtrlImage = [[UIImageView alloc] init];
    [_CtrlImage setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self addSubview:_CtrlImage];
    
    _CtrlLabel = [[UILabel alloc] init];
    [_CtrlLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self addSubview:_CtrlLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_CtrlLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self,_CtrlLabel)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_CtrlLabel(==15)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self,_CtrlLabel)]];
    _CtrlLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_CtrlImage(>=50)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self,_CtrlImage)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_CtrlImage(>=50)][_CtrlLabel]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_CtrlImage,_CtrlLabel)]];
    _CtrlImage.contentMode = UIViewContentModeCenter;
    return self;
}
- (NSString *) reuseIdentifier {
    
    return @"UCCell";
    
}

@end