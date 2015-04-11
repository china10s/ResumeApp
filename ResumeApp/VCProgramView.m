//
//  VCProgramView.m
//  ResumeApp
//
//  Created by zhulin on 15-4-10.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import "VCProgramView.h"
#define ROWHEIGHT 60
@interface VCProgramView ()

@end

@implementation VCProgramView
- (instancetype)init{
    self = [super init];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds =YES;
    self.alpha = 0.8;
    
    _ArrTitle = [[NSMutableArray alloc] init];
    _ArrSummary = [[NSMutableArray alloc] init];
    return self;
}

- (void)SetLocation:(NSMutableDictionary*)dicLocationName{
    [_ArrTitle removeAllObjects];
    [_ArrSummary removeAllObjects];
    
    if (dicLocationName.count <= 0) {
        _iRowNum = 0;
        return;
    }
    _iRowNum = dicLocationName.count;
    for (NSString* strTitle in [dicLocationName allKeys]) {
        NSString* strSummary = [dicLocationName objectForKey:strTitle];
        [_ArrTitle addObject:strTitle];
        [_ArrSummary addObject:strSummary];
    }
    //[_ArrTitle addObject:@"深交所网络投票系统开发"];
    //[_ArrTitle addObject:@"人民币汇率指数计算与发布系统开发"];
    //[_ArrSummary addObject:@"用来描述农田基本信息的系统"];
    //[_ArrSummary addObject:@"用来进行土地规划整治的系统"];
    [self IniProgramView];
    [self reloadData];
}

- (void)IniProgramView{
    CGRect  rcy = [UIScreen mainScreen].bounds;
    rcy.origin.y = rcy.size.height / 2;
    rcy.size.height /=2;
    self.frame =rcy;
    
    CGRect rect = [UIScreen mainScreen].bounds;
    
    NSString * strHri = [NSString stringWithFormat:@"V:|-%f-[self(>=%d)]",rect.size.height/2+50,ROWHEIGHT*_iRowNum];
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:strHri options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.superview,self)]];
    [self.superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[self]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self.superview,self)]];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.dataSource = self;
    self.delegate = self;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _iRowNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * CellWithIdentifier = @"Cell";
    UITableViewCell * cell = [self dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellWithIdentifier];
    }
    NSUInteger rowIndex = [indexPath row];
    cell.textLabel.text = [_ArrTitle objectAtIndex:rowIndex];
    cell.detailTextLabel.text = [_ArrSummary objectAtIndex:rowIndex];
    return cell;
}


//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ROWHEIGHT;
}


//点击了某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_DelegProgram SelProgram:[_ArrTitle objectAtIndex:[indexPath row]]];
}








@end
