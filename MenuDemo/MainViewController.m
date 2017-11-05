//
//  MainViewController.m
//  MenuDemo
//
//  Created by Job on 2017/10/29.
//  Copyright © 2017年 DaDiMedia. All rights reserved.
//

#import "MainViewController.h"
#import "FilmViewController.h"
#import "ActivityViewController.h"
#import "LeftViewController.h"
#import "UIView+Extension.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()

@property (nonatomic, strong) UITabBarController *rootController;
@property (nonatomic, strong) UIViewController *leftController;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) UIView *alphaView;
@property (nonatomic, assign) CGFloat panStartPointX;
@property (nonatomic, assign) CGFloat space;
@property (nonatomic, assign) CGFloat alpha;

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.panStartPointX = 0;
    self.space = 90;
    self.alpha = 0.5;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleHindNotification:) name:@"HideNotification" object:nil];
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    self.rootController = tabBar;
    
    UINavigationController *filmNC = [[UINavigationController alloc] initWithRootViewController:[[FilmViewController alloc] init]];
    filmNC.title = @"影片";
    UINavigationController *activityNC = [[UINavigationController alloc] initWithRootViewController:[[ActivityViewController alloc] init]];
    activityNC.title = @"活动";
    
    tabBar.viewControllers = @[filmNC,activityNC];
    tabBar.view.frame = self.view.bounds;
    [tabBar.view addObserver:self forKeyPath:@"frame" options:(NSKeyValueObservingOptionNew) context:nil];
    
    LeftViewController *leftVC = [[LeftViewController alloc] init];
    leftVC.view.frame = CGRectMake((self.space - screenWidth) / 2.0, 0, screenWidth, screenHeight);
    self.leftController = leftVC;
    
    [self addChildViewController:self.leftController];
    [self.view addSubview:self.leftController.view];
    
    [self addChildViewController:tabBar];
    [self.view addSubview:tabBar.view];
    
    self.alphaView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    self.alphaView.hidden = YES;
    [self.view addSubview:self.alphaView];
    
    UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideTap:)];
    [self.alphaView addGestureRecognizer:hideTap];
    
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)];
    [self.view addGestureRecognizer:self.pan];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"frame"]) {
        self.alphaView.frame = self.rootController.view.frame;
        self.alphaView.hidden = self.alphaView.frame.origin.x == 0;
    }
}

#pragma mark - GestureRecognizer
- (void)hideTap:(UITapGestureRecognizer *)gesture{
    [self hideMenu:YES];
}

- (void)edgePanGesture:(UIPanGestureRecognizer *)gesture{
    UIView *rootView = self.rootController.view;
    UIView *leftView = self.leftController.view;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.panStartPointX = [gesture locationInView:self.view].x;
    }
    if (self.panStartPointX >= 40 && rootView.frame.origin.x == 0) {
        return;
    }
    
    CGFloat translationX = [gesture translationInView:rootView].x;
    CGFloat rootViewX = rootView.frame.origin.x;
    CGFloat leftViewX = leftView.frame.origin.x;
    
    // 边界控制
    rootViewX = MIN(rootViewX + translationX, screenWidth - self.space);
    rootViewX = MAX(rootViewX, 0);
    rootView.x = rootViewX;
    
    // 边界控制
    leftViewX = MIN(leftView.frame.origin.x + translationX / 2.0, 0);
    leftViewX = MAX(leftViewX, (self.space - screenWidth) / 2.0);
    leftView.x = leftViewX;
    
    self.alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:self.alpha * (rootView.frame.origin.x) / (screenWidth - self.space)];
    [gesture setTranslation:CGPointZero inView:rootView];
    
    if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        if (rootViewX >= (screenWidth - self.space) / 2.0) {
            [self showMenu:YES];
        }else{
            [self hideMenu:YES];
        }
    }
}

#pragma mark - Notification
- (void)handleHindNotification:(NSNotification *)notification{
    [self hideMenu:YES];
}

#pragma mark - Other
- (void)showMenu:(BOOL)animated{
    UIView *rootView = self.rootController.view;
    UIView *leftView = self.leftController.view;
    if (animated) {
        CGFloat duration = 0.2;
        [UIView animateWithDuration:duration animations:^{
            leftView.x = 0;
            rootView.x = screenWidth - self.space;
            self.alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:self.alpha];
        }];
    }else{
        leftView.x = 0;
        rootView.x = screenWidth - self.space;
        self.alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:self.alpha];
    }
}

- (void)hideMenu:(BOOL)animated{
    UIView *rootView = self.rootController.view;
    UIView *leftView = self.leftController.view;
    if (animated) {
        CGFloat duration = 0.2;
        [UIView animateWithDuration:duration animations:^{
            leftView.x = self.space - screenWidth;
            rootView.x = 0;
            self.alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        }];
    }else{
        leftView.x = self.space - screenWidth;
        rootView.x = 0;
        self.alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    }
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
