//
//  WBUserTool.h
//  Sina
//
//  Created by Chia on 16/3/25.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBUserResult,WBUser;
@interface WBUserTool : NSObject
/**
 *  请求用户的未读 数
 *
 *  @param success 请求成功时调用，返回用户数给相应的控制器
 *  @param error   请求失败时调用
 */
+(void)unreadCountWithSuccess:(void(^)(WBUserResult * result))success failure:(void(^)(NSError *error))failure;

/**
 *  请求用户的信息
 *
 *  @param success 成功时调用，返回到HomeVC
 *  @param failure 失败时调用
 */
+(void)userInfoWithSuccess:(void(^)(WBUser *user))success failure:(void(^)(NSError *error))failure;
@end
