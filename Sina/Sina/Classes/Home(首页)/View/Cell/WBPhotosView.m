
//
//  WBPhotosView.m
//  Sina
//
//  Created by Chia on 16/4/12.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBPhotosView.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "WBPhotoView.h"

@implementation WBPhotosView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //添加九宫格位置控件
        [self addChildViews];
    }
    return self;
}
//添加九宫格位置控件
-(void)addChildViews
{
    for (int i = 0; i< 9; i++) {
        WBPhotoView *imageV = [[WBPhotoView alloc] init];

        imageV.tag = i;
        //添加手势
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [imageV addGestureRecognizer:tapGesture];
        [self addSubview:imageV];
    }
}
-(void)tap:(UITapGestureRecognizer*)tapGesture
{
    //获取当前图片tag
    UIImageView *tapView = tapGesture.view;
    //弹出图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    //WBPhoto---》MJPhoto
    NSMutableArray * arrM = [[NSMutableArray alloc] init];
    int i = 0;
    for (WBPhoto * photo in _pic_urls) {
        MJPhoto *p = [[MJPhoto alloc] init];
        NSString *thumStr = photo.thumbnail_pic.absoluteString;
        thumStr = [thumStr stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        p.url = [NSURL URLWithString:thumStr];
        p.srcImageView = tapView;
        p.index = i;
        [arrM addObject:p];
        i++;
        
    }
    browser.photos =arrM;
    browser.currentPhotoIndex = tapView.tag;
    [browser show];
}
-(void)setPic_urls:(NSArray *)pic_urls{
    _pic_urls = pic_urls;
    
    int count = self.subviews.count;
    for (int i = 0 ; i < count; i++) {
//        UIImageView *imageV = self.subviews[i];
        WBPhotoView *imageV = self.subviews[i];
        if (i < _pic_urls.count) {
            imageV.hidden = NO;
            //获取WBPhoto模型
            WBPhoto *photo = _pic_urls[i];
            imageV.photo = photo;
            
        }else{
            imageV.hidden = YES;
        }
        
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = 70;
    CGFloat h = 70;
    CGFloat margin = 10;
    int col = 0;
    int rol = 0;
    int cols = _pic_urls.count==4?2:3;
    // 计算显示出来的imageView
    for (int i = 0; i < _pic_urls.count; i++) {
        col = i % cols;
        rol = i / cols;
        UIImageView *imageV = self.subviews[i];
        x = col * (w + margin);
        y = rol * (h + margin);
        imageV.frame = CGRectMake(x, y, w, h);
    }
}

@end
