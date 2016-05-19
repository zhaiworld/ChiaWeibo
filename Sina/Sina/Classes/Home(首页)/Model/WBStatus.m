//
//  WBStatus.m
//  Sina
//
//  Created by Chia on 16/3/17.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBStatus.h"
#import "MJExtension.h"
#import "WBPhoto.h"
#import "NSDate+MJ.h"

@implementation WBStatus

+ (NSDictionary *)objectClassInArray{
    return @{@"pic_urls":[WBPhoto class]};
}


-(NSString *)created_at{    
    
    CZLog(@"old:%@",_created_at);
    // Tue Mar 11 17:48:24 +0800 2015
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    //设置日期格式本地化
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_us"];
    //将新浪微博的时间字符串转换成日期格式
    NSDate *date_create = [fmt dateFromString:_created_at];
    
    //是不是今年的
    if([date_create isThisYear]){//今年
        
        if ([date_create isToday]){//今天
            NSDateComponents *cmp = [date_create deltaWithNow];
            if(cmp.hour >= 1){
                return [NSString stringWithFormat:@"%ld个小时之前",cmp.hour];
            }else if (cmp.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
            }else{
                return @"刚刚";
            }
            
        }else if ([date_create isYesterday]){//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:date_create];
        }else{//前几天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:date_create];
        }
    }else{//不是今年
        
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:date_create];
    }
    return _created_at;
}

-(void)setSource:(NSString *)source{
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自%@",source];
    _source = source;
    
}
-(void)setRetweeted_status:(WBStatus *)retweeted_status{
    _retweeted_status = retweeted_status;
    _retweetName = [NSString stringWithFormat:@"@%@",retweeted_status.user.name];
}
@end
