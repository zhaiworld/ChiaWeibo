//
//  WBCover.h
//  Sina
//
//  Created by Chia on 16/2/29.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBCover;
@protocol WBCoverDelegate <NSObject>

@optional
-(void)coverDidClickCover:(WBCover*)cover;

@end

@interface WBCover : UIView


//显示蒙版

+(instancetype)showCover;

//设置浅灰色蒙版
@property (nonatomic, assign) BOOL dimBackgroud;
@property (nonatomic, weak) id<WBCoverDelegate> delegate;

@end
