//
//  WBUploadParams.h
//  Sina
//
//  Created by Chia on 16/4/19.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBUploadParams : NSObject


@property (nonatomic, strong) NSData * data;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * fileName;
@property (nonatomic, copy) NSString * mimeType;

@end
