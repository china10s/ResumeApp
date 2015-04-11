//
//  CGetData.m
//  ResumeApp
//
//  Created by zhulin on 15-4-12.
//  Copyright (c) 2015年 china10s. All rights reserved.
//

#import "CGetData.h"

@implementation CGetData
+ (CGetData*)IniData{
    static CGetData* getData;
    @synchronized(self){
        if (!getData) {
            getData = [[CGetData alloc] init];
        }
    }
    return getData;
}

- (instancetype)init{
    self = [super init];
    _strSqlitePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"sqlite"];
    _db = [FMDatabase databaseWithPath:_strSqlitePath];
    return self;
}
//执行sql
- (FMResultSet*)ExecSql:(NSString*)strSql{
    if(!strSql || strSql.length <= 0){
        return nil;
    }
    //打开数据库
    if (![self.db open]) {
        return nil;
    }
    //取得资料
    FMResultSet *rs = [self.db executeQuery:strSql];
    return rs;
}

//获取项目信息
+ (NSMutableDictionary*)GetProgramSummary:(NSInteger)iDisId{
    NSString* strSql = [NSString stringWithFormat:@"SELECT FdProChName,FdSummary FROM Resume_tbProgram where FdProDistrict = %ld",iDisId+1];
    FMResultSet* rest = [[CGetData IniData] ExecSql:strSql];
    if (!rest) {
        return nil;
    }
    NSMutableDictionary * arry = [[NSMutableDictionary alloc] init];
    while ([rest next]) {
        NSString* strProName = [rest stringForColumn:@"FdProChName"];
        NSString* strProSummary = [rest stringForColumn:@"FdSummary"];
        [arry setValue:strProSummary forKey:strProName];
    }
    return arry;
}

//获取项目内容
+ (NSString*)GetProgramContent:(NSString*)strProName{
    NSString* strSql = [NSString stringWithFormat:@"SELECT * FROM Resume_tbProgram where FdProChName = '%@'",strProName];
    FMResultSet* rest = [[CGetData IniData] ExecSql:strSql];
    if (!rest) {
        return nil;
    }
    NSString* strProContent = nil;
    while ([rest next]) {
        strProContent = [rest stringForColumn:@"FdProContent"];
    }
    return strProContent;
}

//获取主标题描述信息
+ (NSMutableDictionary*)GetTitleContent:(NSInteger)iTitleIndex{
    NSString* strSql = [NSString stringWithFormat:@"SELECT * FROM Resume_tbTitleContent where FdTitleIndex = %ld",iTitleIndex];
    FMResultSet* rest = [[CGetData IniData] ExecSql:strSql];
    if (!rest) {
        return nil;
    }
    NSString* strTitleName = nil;
    NSString* strTitleContent = nil;
    NSMutableDictionary* arr = [[NSMutableDictionary alloc] init];
    while ([rest next]) {
        strTitleName = [rest stringForColumn:@"FdTitleName"];
        strTitleContent = [rest stringForColumn:@"FdTitleContent"];
        [arr setObject:strTitleContent forKey:strTitleName];
    }
    return arr;
}

- (void)dealloc{
    [self.db close];
}














@end
