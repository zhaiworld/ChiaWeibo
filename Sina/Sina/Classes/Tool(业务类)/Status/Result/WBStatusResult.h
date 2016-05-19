//
//  WBStatusResult.h
//  Sina
//
//  Created by Chia on 16/3/22.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface WBStatusResult : NSObject<MJKeyValue>

 /**
 *   用户的微博数组（WBStatus）
 */
@property (nonatomic, strong) NSArray *statuses;
/**
 *  用户最近的微博数
 */
@property (nonatomic , assign) int   *total_number;


@end
