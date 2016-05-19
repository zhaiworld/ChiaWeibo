//
//  WBCellItem.h
//  Sina
//
//  Created by Chia on 16/4/21.
//  Copyright © 2016年 WB. All rights reserved.
//描述每个CELL长什么样子

#import <Foundation/Foundation.h>
@class WBCheckItem;
@interface WBCellItem : NSObject
/**
 *  保存图片
 */
@property(nonatomic, weak) UIImage *image;
/**
 *  CELL标题
 */
@property(nonatomic, copy) NSString *title;
/**
 *  CELL副标题
 */
@property(nonatomic, copy) NSString *subTitle;
/**
 *  跳转控制器类
 */
@property(nonatomic, assign) Class destVcClass;
/**
 *  保存每一行需要做的事情
 */
@property(nonatomic,copy) void(^option)(WBCheckItem *checkItem);

+(instancetype)itemWithTitle:(NSString *)title;
+(instancetype)itemWithTitle:(NSString *)title image:(UIImage *)image;
+(instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle image:(UIImage *)image;

@end
