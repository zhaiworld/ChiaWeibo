//
//  WBTwoViewController.m
//  Sina
//
//  Created by Chia on 16/3/2.
//  Copyright © 2016年 WB. All rights reserved.
//

#import "WBTwoViewController.h"

@interface WBTwoViewController ()

@end

@implementation WBTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIButton *tipsf = [UIButton buttonWithType:UIButtonTypeCustom];
    tipsf.frame = CGRectMake(30, 100, 200, 35);
    [tipsf setTitle:@"This is the second view" forState:UIControlStateNormal];
    
//    [tipsf addTarget:self action:@selector(pushTo2) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:tipsf];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
