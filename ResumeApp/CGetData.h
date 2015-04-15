//
//  CGetData.h
//  ResumeApp
//
//  Created by zhulin on 15-4-12.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface CGetData : NSObject
@property (nonatomic,strong)NSString            *strSqlitePath;
@property (nonatomic,strong)FMDatabase          *db;
//获取项目内容
+ (NSString*)GetProgramContent:(NSString*)strProName;
//获取项目信息
+ (NSMutableDictionary*)GetProgramSummary:(NSInteger)iDisId;
//获取主标题描述信息
+ (NSMutableDictionary*)GetTitleContent:(NSInteger)iTitleIndex;
@end
