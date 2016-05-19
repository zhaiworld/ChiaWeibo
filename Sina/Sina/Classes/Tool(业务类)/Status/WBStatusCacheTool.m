//
//  WBStatusCacheTool.m
//  Sina
//
//  Created by Chia on 16/5/6.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBStatusCacheTool.h"
#import "FMDB.h"
#import "WBStatus.h"
#import "WBAccount.h"
#import "WBAccountTool.h"
#import "WBStatusParam.h"
#import "MJExtension.h"

@implementation WBStatusCacheTool

static FMDatabase *_db;
+(void)initialize
{
    //创建数据库
    NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"status.sqlite"];
    _db = [FMDatabase databaseWithPath:dbPath];
    //打开库，创建表
    if ([_db open]) {
        NSLog(@"open db success");
    }else{
        NSLog(@"open db failure");
    }
    //创建表
    BOOL flag = [_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement,idstr text,access_token text,dict blob);"];
    if (flag) {
        NSLog(@"create table success");
    }else{
        NSLog(@"create table failure");
    }
}

+(void)saveWithStatuses:(NSArray *)statuses{
    //遍历微博字典
    for (NSDictionary *statusDict in statuses) {
        NSString *idstr =statusDict[@"idstr"];
        NSString *accessToken = [WBAccountTool account].access_token;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDict];
        
       BOOL insertFlag= [ _db executeUpdate:@"insert into t_status (idstr, access_token, dict) values(?,?,?)",idstr,accessToken,data];
        if (insertFlag) {
            NSLog(@"insert table success");
        }else{
            NSLog(@"insert table failure");
        }
    }
    
}

+(NSArray *)statusesWithParam:(WBStatusParam *)param
{
    // 进入程序第一次获取的查询语句
    NSString *sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' order by idstr desc limit 20;",param.access_token];
    if (param.since_id) { // 获取最新微博的查询语句
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr > '%@' order by idstr desc limit 20;",param.access_token,param.since_id];
    }else if (param.max_id){  // 获取更多微博的查询语句
        sql = [NSString stringWithFormat:@"select * from t_status where access_token = '%@' and idstr <= '%@' order by idstr desc limit 20;",param.access_token,param.max_id];
    }
    
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *arrM = [NSMutableArray array];
    while ([set next]) {
        NSData *data = [set dataForColumn:@"dict"];
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        WBStatus *s = [WBStatus objectWithKeyValues:dict];
        [arrM addObject:s];
    }
    
    
    return arrM;
}
@end
