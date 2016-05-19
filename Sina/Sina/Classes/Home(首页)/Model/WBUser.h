//
//  WBUser.h
//  Sina
//
//  Created by Chia on 16/3/17.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUser : NSObject

/**
 *  微博昵称
 */
@property(nonatomic, copy) NSString *name;
/**
 *  微博头像
 */
@property(nonatomic, strong) NSURL *profile_image_url;

//会员类型 >2为会员
@property(nonatomic, assign) int mbtype;
//会员等级
@property(nonatomic, assign) int mbrank;

@property(nonatomic, assign, getter=isVip) BOOL vip;
@end
