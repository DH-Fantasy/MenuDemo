//
//  FilmViewController.m
//  MenuDemo
//
//  Created by Job on 2017/10/29.
//  Copyright © 2017年 DaDiMedia. All rights reserved.
//

#import "FilmViewController.h"
#import "NewViewController.h"
#import "CustomScrollView.h"

@interface FilmViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) CustomScrollView *bottomScrollView;

@end

@implementation FilmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"影片";
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.bottomScrollView];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    redView.backgroundColor = [UIColor redColor];
    [self.bottomScrollView addSubview:redView];
    
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    blueView.backgroundColor = [UIColor blueColor];
    [self.bottomScrollView addSubview:blueView];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [btn setTitle:@"Push" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(pushAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

- (CustomScrollView *)bottomScrollView{
    if (_bottomScrollView == nil) {
        CustomScrollView *bottomScrollView = [[CustomScrollView alloc]initWithFrame:self.view.bounds];
        bottomScrollView.delegate = self;
        bottomScrollView.contentSize = CGSizeMake(2*self.view.frame.size.width, 0);
        bottomScrollView.pagingEnabled = YES;
        bottomScrollView.alwaysBounceVertical = NO;
        bottomScrollView.bounces = NO;
        bottomScrollView.backgroundColor = [UIColor whiteColor];
        _bottomScrollView = bottomScrollView;
    }
    return _bottomScrollView;
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
