//
//  WBUserParam.h
//  Sina
//
//  Created by Chia on 16/3/25.
//  Copyright © 2016年 WB. All rights reserved.
//获取某个用户的各种消息未读数,用到的请求参数


#import <Foundation/Foundation.h>
#import "WBBaseParams.h"

@interface WBUserParam :WBBaseParams
/**
 *  需要获取消息未读数的用户UID，必须是当前登录用户
 */
@property(nonatomic , strong) NSString *uid;

@end
