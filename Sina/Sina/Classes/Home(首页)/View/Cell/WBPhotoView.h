//
//  WBPhotoView.h
//  Sina
//
//  Created by Chia on 16/4/14.
//  Copyright © 2016年 WB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBPhoto;
@interface WBPhotoView : UIImageView
/**
 *  获取图片的URL，以便判断是否为GIF图片
 */
@property(nonatomic, strong) WBPhoto * photo;

@end
