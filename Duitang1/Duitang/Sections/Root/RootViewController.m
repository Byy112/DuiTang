//
//  RootViewController.m
//  Duitang
//
//  Created by lanouhn on 15/6/17.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "RootViewController.h"
#import "HotViewController.h"
#import "FoundViewController.h"

#import "MainViewController.h"
#import "ViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createView];
    
}
- (void)createView {
    self.tabBar.translucent = NO;
    
    
    HotViewController * hotVC = [[HotViewController alloc] init];
    UINavigationController * hotNavC = [[UINavigationController alloc] initWithRootViewController:hotVC];
    FoundViewController * foundVC = [[FoundViewController alloc] init];
    UINavigationController * foundNavC = [[UINavigationController alloc] initWithRootViewController:foundVC];
    
    MainViewController * mineVC = [[MainViewController alloc] init];
    UINavigationController * mineNavC = [[UINavigationController alloc] initWithRootViewController:mineVC];
    
    self.viewControllers = @[hotNavC,foundNavC,mineNavC];
    //self.tabBar.barTintColor = [UIColor yellowColor];
    self.tabBar.tintColor = [UIColor redColor];
    
    self.selectedIndex = 0;
    hotNavC.tabBarItem.title = @"首页";
    foundNavC.title = @"发现";
    
    mineNavC.tabBarItem.title = @"我";
    //设置每一个标签的图片
    //首页
    hotNavC.tabBarItem.image = [UIImage imageWithCGImage:[UIImage imageNamed:@"icon_home@2x"].CGImage scale:2.5 orientation:UIImageOrientationDown];

    //设置图片被选中时的图片
    hotNavC.tabBarItem.selectedImage = [[UIImage imageWithCGImage:[UIImage imageNamed:@"icon_home_highlight@2x"].CGImage scale:2.5 orientation:UIImageOrientationUp] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    foundNavC.tabBarItem.image = [UIImage imageWithCGImage:[UIImage imageNamed:@"icon_search@2x"].CGImage scale:2.5 orientation:UIImageOrientationDown];
    foundNavC.tabBarItem.selectedImage = [[UIImage imageWithCGImage:[UIImage imageNamed:@"icon_search_highlight@2x"].CGImage scale:2.5 orientation:UIImageOrientationUp] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    //我的
    mineNavC.tabBarItem.image = [UIImage imageWithCGImage:[UIImage imageNamed:@"icon_me@2x"].CGImage scale:2.5 orientation:UIImageOrientationDown];
    mineNavC.tabBarItem.selectedImage = [[UIImage imageWithCGImage:[UIImage imageNamed:@"icon_me_highlight@2x"].CGImage scale:2.5 orientation:UIImageOrientationUp] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];


    
    [hotVC release];
    [hotNavC release];
    [foundVC release];
    [foundNavC release];

    [mineVC release];
    [mineNavC release];

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
