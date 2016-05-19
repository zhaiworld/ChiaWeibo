//
//  WBNewFeatureCell.m
//  Sina
//
//  Created by Chia on 16/3/3.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBNewFeatureCell.h"
#import "UIView+Frame.h"
#import "WBTabBarController.h"

@interface WBNewFeatureCell()//来个类扩展

@property(nonatomic, weak) UIImageView *imageView;
@property(nonatomic, weak) UIButton    *sharedButton;
@property(nonatomic, weak) UIButton    *startButton;


@end

@implementation WBNewFeatureCell

-(UIButton *)sharedButton{
    
    if (_sharedButton == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"分享给大家" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn sizeToFit];
        [self.contentView addSubview:btn];
        
        _sharedButton = btn;
    }
    
    return _sharedButton;
}

-(UIButton *)startButton{
    
    if (_startButton == nil) {
        UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
        [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
        [startBtn sizeToFit];
        [startBtn addTarget:self action:@selector(startUp) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:startBtn];
        _startButton = startBtn;
    }
    
    return _startButton;
}
-(UIImageView *)imageView{
    if (_imageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        _imageView = imageV;
        
        //注意：tableView 和collectionView一定在加到contentView上
        [self.contentView addSubview:imageV];
        
    }
    return _imageView;
}
//布局子控件的位置
-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    //分享按钮
    self.sharedButton.center = CGPointMake(self.width * 0.5, self.height * 0.8);
    //开始按钮
    self.startButton.center = CGPointMake(self.width * 0.5, self.height * 0.9);
}

-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
}

-(void)setIndexPath:(NSIndexPath *)indexPath count:(int)count{
    if (indexPath.row == count -1) {//说明是最后一页
        self.sharedButton.hidden = NO;
        self.startButton.hidden = NO;
    }else{
        self.sharedButton.hidden = YES;
        self.startButton.hidden = YES;
    }
    
}
-(void)startUp{
    //进入tabbarvc
    
    WBTabBarController * vc = [[WBTabBarController alloc] init];
    
    //切换根控制器
    WBKeyWindow.rootViewController = vc;
}
@end








