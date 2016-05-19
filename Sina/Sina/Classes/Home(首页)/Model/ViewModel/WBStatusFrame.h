//
//  WBStatusFrame.h
//  Sina
//
//  Created by Chia on 16/3/30.
//  Copyright © 2016年 WB. All rights reserved.

//  模型+模型对应控件的Frame

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class WBStatus;
@interface WBStatusFrame : NSObject
/**
 *  微博数据
 */
@property(nonatomic, strong) WBStatus *status;


//原创微博frame
@property(nonatomic,assign) CGRect originalViewFrame;
//******************原创子控件frame*****************//
//头像
@property(nonatomic, assign) CGRect originalIconFrame;
//昵称
@property(nonatomic, assign) CGRect originalNameFrame;
//Vip
@property(nonatomic, assign) CGRect originalVipFrame;
//时间
@property(nonatomic, assign) CGRect originalTimeFrame;
//来源
@property(nonatomic, assign) CGRect originalSourceFrame;
//正文
@property(nonatomic, assign) CGRect originalTextFrame;
//配图区
@property(nonatomic, assign) CGRect originalPhotosFrame;

//转发微博frame
@property(nonatomic,assign) CGRect retweetViewFrame;
//******************原创子控件frame*****************//
//昵称
@property(nonatomic, assign) CGRect retweetNameFrame;
//正文
@property(nonatomic, assign) CGRect retweetTextFrame;
//配图区
@property(nonatomic, assign) CGRect retweetPhotosFrame;

//工具条frame
@property(nonatomic, assign) CGRect toolBarViewFrame;

// cell的高度
@property (nonatomic, assign) CGFloat cellHeight;
@end
