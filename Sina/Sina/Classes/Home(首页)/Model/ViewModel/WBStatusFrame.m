//
//  WBStatusFrame.m
//  Sina
//
//  Created by Chia on 16/3/30.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBStatus.h"
#import "WBUser.h"




@implementation WBStatusFrame

-(void)setStatus:(WBStatus *)status{
    _status = status;
    
    //计算原创微博
    [self setUpOriginalViewFrame];
    CGFloat toolBarY = CGRectGetMaxY(_originalViewFrame);
    //计算转发微博
    if (status.retweeted_status) {
        [self setUpRetweetViewFrame];
        toolBarY = CGRectGetMaxY(_retweetViewFrame);
    }
    //计算工具条
    CGFloat toolBarX = 0;
    CGFloat toolBarW = WBScreenWidth;
    CGFloat toolBarH = 35;
    _toolBarViewFrame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    //计算Cell高度
    _cellHeight = CGRectGetMaxY(_toolBarViewFrame);
}

#pragma mark - 计算原创微博
-(void)setUpOriginalViewFrame{
    //计算头像
    CGFloat imageX = WBStatusCellMargin;
    CGFloat imageY = imageX;
    CGFloat imageWH = 35;
    _originalIconFrame = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    //计算昵称
    CGFloat nameX = CGRectGetMaxX(_originalIconFrame) + WBStatusCellMargin;
    CGFloat nameY = imageY;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = WBNameFont;
    CGSize nameSize = [_status.user.name sizeWithAttributes:dict];
    _originalNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    //VIP
    if (_status.user.vip) {
        
        CGFloat vipX = CGRectGetMaxX(_originalNameFrame) + WBStatusCellMargin;
        CGFloat vipY = imageY;
        CGFloat vipWH = 14;
        _originalVipFrame = CGRectMake(vipX, vipY, vipWH, vipWH);
    }

    
    //正文
    CGFloat textX = imageX;
    CGFloat textY = CGRectGetMaxY(_originalIconFrame) + WBStatusCellMargin;
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSFontAttributeName] = WBTextFont;
    CGFloat textW = WBScreenWidth - 2*WBStatusCellMargin;
    CGRect rect = [_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil];
    CGFloat textH = rect.size.height;
    _originalTextFrame = CGRectMake(textX, textY, textW, textH);
    
    CGFloat originH = CGRectGetMaxY(_originalTextFrame) + WBStatusCellMargin;
    //配图区
    
    NSUInteger count = _status.pic_urls.count;
    if (count) {
        CGFloat photosX = WBStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_originalTextFrame) + WBStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        _originalPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        originH = CGRectGetMaxY(_originalPhotosFrame) + WBStatusCellMargin;
    }
    
    //原创微博Frame
    CGFloat originX = 0;
    CGFloat originY = 10;
    CGFloat originW = WBScreenWidth;
    _originalViewFrame = CGRectMake(originX, originY, originW, originH);
    
}
-(CGSize)photosSizeWithCount:(NSUInteger)count
{
    int colu = count ==4 ? 2 : 3;
    int row = (count - 1) / colu + 1;
    CGFloat photoWH = 70;
    CGFloat w = colu * photoWH + (colu - 1)*WBStatusCellMargin;
    CGFloat h = row *photoWH + (row - 1 )*WBStatusCellMargin;
    return CGSizeMake(w, h);
    
}
#pragma mark - 计算转发微博
-(void)setUpRetweetViewFrame{
    //计算昵称
    CGFloat nameX = WBStatusCellMargin;
    CGFloat nameY = nameX;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = WBNameFont;
    CGSize nameSize = [_status.retweetName sizeWithAttributes:dict];
    _retweetNameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    //正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(_retweetNameFrame) + WBStatusCellMargin;
    NSMutableDictionary *textDict = [NSMutableDictionary dictionary];
    textDict[NSFontAttributeName] = WBTextFont;
    CGFloat textW = WBScreenWidth - 2*WBStatusCellMargin;
    CGRect rect = [_status.retweeted_status.text boundingRectWithSize:CGSizeMake(textW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDict context:nil];
    CGFloat textH = rect.size.height;
    _retweetTextFrame = CGRectMake(textX, textY, textW, textH);
    
    CGFloat retweetH = CGRectGetMaxY(_retweetTextFrame) + WBStatusCellMargin;
    //配图区
    NSUInteger count = _status.retweeted_status.pic_urls.count;
    if (count) {
        CGFloat photosX = WBStatusCellMargin;
        CGFloat photosY = CGRectGetMaxY(_retweetTextFrame) + WBStatusCellMargin;
        CGSize photosSize = [self photosSizeWithCount:count];
        _retweetPhotosFrame = (CGRect){{photosX,photosY},photosSize};
        retweetH = CGRectGetMaxY(_retweetPhotosFrame) + WBStatusCellMargin;
    }
    
    //转发微博Frame
    CGFloat retweetX = 0;
    CGFloat retweetY = CGRectGetMaxY(_originalViewFrame);
    CGFloat retweetW = WBScreenWidth;
    _retweetViewFrame = CGRectMake(retweetX, retweetY, retweetW, retweetH);
}
#pragma mark - 计算原创微博
-(void)setUpToolBarFrame{
    
}



@end

