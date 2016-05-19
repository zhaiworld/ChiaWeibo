//
//  WBStatusParam.h
//  Sina
//
//  Created by Chia on 16/3/22.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBStatusParam : NSObject
/**
 *  采用OAuth授权方式为必填参数，OAuth授权后获得
 */
@property(nonatomic , copy) NSString * access_token;
/**
 *  若指定此参数，则返回ID比since_id大的微博
 */
@property(nonatomic , copy) NSString * since_id;
/**
 *  若指定此参数，则返回ID小于或等于max_id的微博
 */
@property(nonatomic , copy) NSString * max_id;


@end
