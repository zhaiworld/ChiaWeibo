//
//  WBStatusResult.m
//  Sina
//
//  Created by Chia on 16/3/22.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBStatusResult.h"
#import "WBStatus.h"
@implementation WBStatusResult
// 告诉MJ框架，数组里的字典转换成哪个模型
+(NSDictionary *)objectClassInArray{
    return @{@"statuses":[WBStatus class]};
}
@end
