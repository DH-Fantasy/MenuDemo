//
//  ActivityViewController.m
//  MenuDemo
//
//  Created by Job on 2017/10/29.
//  Copyright © 2017年 DaDiMedia. All rights reserved.
//

#import "ActivityViewController.h"
#import "NewViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.navigationItem.title = @"活动";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [btn setTitle:@"Push" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(pushAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

- (void)pushAction:(UIButton *)sender{
    NewViewController *newVC = [[NewViewController alloc] init];
    newVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:newVC animated:YES];
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
