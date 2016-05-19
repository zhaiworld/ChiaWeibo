//
//  WBUser.m
//  Sina
//
//  Created by Chia on 16/3/17.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser

-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    _vip = mbtype > 2;
}

@end
