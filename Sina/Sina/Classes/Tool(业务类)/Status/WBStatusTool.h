//
//  WBStatusTool.h
//  Sina
//
//  Created by Chia on 16/3/22.
//  Copyright © 2016年 WB. All rights reserved.
//  处理微博数据

#import <Foundation/Foundation.h>

@interface WBStatusTool : NSObject
/**
 *  返回最新微博数据
 *
 *  @param sinceId 接收到用来确定从哪条开始加载数据
 *  @param success 请求成功后回调
 *  @param failure 请求失败后回调
 */
+(void)newStatusWithSinceId:(NSString *)sinceId success:(void(^)(NSArray *newStatus))success failure:(void(^)(NSError *error))failure;
+(void)moreStatusWithMaxId:(NSString *)maxId success:(void(^)(NSArray *moreStatus))success failure:(void(^)(NSError *error))failure;

@end
