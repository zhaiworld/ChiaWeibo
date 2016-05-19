//
//  WBAccount.h
//  Sina
//
//  Created by Chia on 16/3/14.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 {"access_token" = "2.00rgrSmFbkehbC7e6d1c76a9ZumKNB";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 5294424581;
 }
 */

//字典模型要归档必须要遵守nscoding协议
@interface WBAccount : NSObject<NSCoding>
@property(nonatomic, copy) NSString *access_token;
@property(nonatomic, copy) NSString *expires_in;
@property(nonatomic, copy) NSString *remind_in;
@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *name;
/**
 *  过期时间 = 当前保存时间+ 有效期
 */
@property(nonatomic, strong) NSDate *expires_date;

+(instancetype)accountWithDict:(NSDictionary*)dict;


@end
