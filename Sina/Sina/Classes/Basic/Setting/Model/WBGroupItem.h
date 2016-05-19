//
//  WBGroupItem.h
//  Sina
//
//  Created by Chia on 16/4/20.
//  Copyright © 2016年 WB. All rights reserved.
//描述每个组长什么样子

#import <Foundation/Foundation.h>

@interface WBGroupItem : NSObject
/**
 *  一个分组当中的cell(WBCellItem)
 */
@property(nonatomic,strong) NSArray *items;
/**
 *  分组头标题
 */
@property(nonatomic,copy) NSString *headerTitle;
/**
 *  分组尾标题
 */
@property(nonatomic,copy) NSString *footerTitle;
@end
