//
//  WBAccount.m
//  Sina
//
//  Created by Chia on 16/3/14.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBAccount.h"
#import "MJExtension.h"

#define CZAccountTokenKey @"token"
#define CZExpires_inKey @"expire"
#define CZUidKey @"uid"
#define CZExpires_date @"expires_date"
#define CZAccount_name @"name"


@implementation WBAccount
MJCodingImplementation

+(instancetype)accountWithDict:(NSDictionary *)dict{
    WBAccount *account = [[self alloc] init];
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}

//在获取有效期时计算到期时间
-(void)setExpires_in:(NSString *)expires_in{
    _expires_in = expires_in;
    //有效期= 从当前时间+有效期时长
    _expires_date = [NSDate dateWithTimeIntervalSinceNow:[expires_in longLongValue]];
}
//归档的时候调用:告诉系统哪个属性需要归档，如何归档
//-(void)encodeWithCoder:(NSCoder *)aCoder{
//    [aCoder encodeObject:_access_token forKey:CZAccountTokenKey];
//    [aCoder encodeObject:_expires_in forKey:CZExpires_inKey];
//    [aCoder encodeObject:_uid forKey:CZUidKey];
//    [aCoder encodeObject:_expires_date forKey:CZExpires_date];
//    [aCoder encodeObject:_name forKey:CZAccount_name];
//
//}

//解档的时候调用：
//-(instancetype)initWithCoder:(NSCoder *)aDecoder{
//    if (self = [self init]) {
//        _access_token = [aDecoder decodeObjectForKey:CZAccountTokenKey];
//        _expires_in = [aDecoder decodeObjectForKey:CZExpires_inKey];
//        _uid = [aDecoder decodeObjectForKey:CZUidKey];
//        _expires_date = [aDecoder decodeObjectForKey:CZExpires_date];
//        _name = [aDecoder decodeObjectForKey:CZAccount_name];
//        
//    }
//    return self;
//}
@end







