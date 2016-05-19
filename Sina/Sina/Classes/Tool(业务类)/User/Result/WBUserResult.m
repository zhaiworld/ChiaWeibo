//
//  WBUserResult.m
//  Sina
//
//  Created by Chia on 16/3/25.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBUserResult.h"

@implementation WBUserResult

-(int)messageCount{
    return _cmt + _mention_cmt +_mention_status + _dm;
}

-(int)totoalCount{
    return self.messageCount + _status +_follower;
}

@end
