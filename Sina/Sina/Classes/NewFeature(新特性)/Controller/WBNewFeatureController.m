//
//  WBNewFeatureController.m
//  Sina
//
//  Created by Chia on 16/3/3.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBNewFeatureController.h"
#import "WBNewFeatureCell.h"


@interface WBNewFeatureController ()
@property(nonatomic, weak) UIPageControl *control;

@end

@implementation WBNewFeatureController

static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置cell的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[WBNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor blueColor];
    
    //设置分页
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self setUpPageControl];
    
    // Do any additional setup after loading the view.
}

-(void)setUpPageControl{
    
    UIPageControl *controlTemp = [[UIPageControl alloc]init];
    controlTemp.numberOfPages = 4;
    controlTemp.pageIndicatorTintColor = [UIColor blackColor];
    controlTemp.currentPageIndicatorTintColor = [UIColor redColor];
    
    //设置位置，然后添加
    controlTemp.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height* 0.97);
    _control = controlTemp;
    [self.view addSubview:controlTemp];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //计算当前是第几页
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width +0.5;
    
    _control.currentPage = page;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    WBNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell

    //拼接图片名称
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%ld", indexPath.row +1];
    cell.image = [UIImage imageNamed:imageName];
    
    [cell setIndexPath:indexPath count:4];
    return cell;
}

#pragma mark <UICollectionViewDelegate>



@end
