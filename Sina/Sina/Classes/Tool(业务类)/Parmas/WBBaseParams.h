//
//  WBBaseParams.h
//  Sina
//
//  Created by Chia on 16/3/25.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBaseParams : NSObject
/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property(nonatomic, strong) NSString *access_token;

+(instancetype)param;

@end
