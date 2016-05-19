//
//  WBPhotoView.m
//  Sina
//
//  Created by Chia on 16/4/14.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBPhotoView.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"

@interface WBPhotoView()
/**
 *  添加GIF图片位
 */
@property (nonatomic, weak) UIImageView *gifView;

@end
@implementation WBPhotoView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.contentMode = UIViewContentModeScaleToFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        //
        UIImageView *gifView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}
-(void)setPhoto:(WBPhoto *)photo{
    _photo = photo;
    //赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}
@end
