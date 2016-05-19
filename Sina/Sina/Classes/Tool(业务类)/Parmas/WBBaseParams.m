//
//  WBBaseParams.m
//  Sina
//
//  Created by Chia on 16/3/25.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBBaseParams.h"
#import "WBAccount.h"
#import "WBAccountTool.h"

@implementation WBBaseParams

+(instancetype)param{
    
    WBBaseParams *param = [[self alloc] init];
    param.access_token = [WBAccountTool account].access_token;
    return param;
}

@end
