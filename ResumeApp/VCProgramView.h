//
//  VCProgramView.h
//  ResumeApp
//
//  Created by zhulin on 15-4-10.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIProgramDelegate

- (void)SelProgram:(NSString*)strProName;

@end

@interface VCProgramView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray          *ArrTitle;
@property (nonatomic,strong)NSMutableArray          *ArrSummary;
@property (nonatomic,assign)NSInteger               iRowNum;
@property (nonatomic,strong)id<UIProgramDelegate>   DelegProgram;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)SetLocation:(NSDictionary*)dicLocationName;
@end
