//
//  APPStrodeViewController.m
//  MINE
//
//  Created by lanouhn on 15/6/24.
//  Copyright (c) 2015年 李加奇. All rights reserved.
//

#import "APPStrodeViewController.h"
//屏幕宽度
#define MainWidth [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define MainHeight [UIScreen mainScreen].bounds.size.height

@interface APPStrodeViewController ()

@end

@implementation APPStrodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, MainWidth, MainHeight)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    
    [self.view addSubview:web];
    
    [web release];
    
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
