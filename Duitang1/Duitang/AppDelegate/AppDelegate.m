//
//  AppDelegate.m
//  Duitang
//
//  Created by lanouhn on 15/6/17.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <Parse/Parse.h>


//#import "BACKViewController.h"
#import "UMSocial.h"
@interface AppDelegate ()
@property (nonatomic, retain)UIButton *likeButton;
@property (nonatomic, retain)CAEmitterLayer *heartsEmitter;


@end

@implementation AppDelegate

@synthesize likeButton;
@synthesize heartsEmitter;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSLog(@"%@",[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject]);
    
    
    UIColor * color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"12.jpeg"]];
    self.window.backgroundColor = color;
    
    
    [UMSocialData setAppKey:@"5587f7e067e58e97ab001e31"];
    
    
    
    [ShareSDK registerApp:@"783bac2495"];
    [ShareSDK connectSinaWeiboWithAppKey:@"568898243"
                               appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                             redirectUri:@"http://www.sharesdk.cn"];
    
    [Parse setApplicationId:@"pSr2dNiZUqcgxrINsyrgJa3vwLcKyATkubNfZ0iX" clientKey:@"aiK1CTRUKjDukAyyKXHJ7ScTfnsLw5IupC8bg1vu"];
  
    self.likeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.window.bounds.size.width / 4, self.window.bounds.size.height / 3, self.window.bounds.size.width / 2, self.window.bounds.size.height / 18)];
    [self.likeButton setTitle:@"点击进入 " forState:(UIControlStateNormal)];
    [self.likeButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    self.likeButton.titleLabel.font = [UIFont systemFontOfSize:25];
    self.likeButton.backgroundColor = [UIColor whiteColor];
    self.likeButton.alpha = 0.4;
    [self.likeButton addTarget:self action:@selector(tap:) forControlEvents:(UIControlEventTouchUpInside)];
    

    [self.window addSubview:self.likeButton];
    
    self.heartsEmitter = [CAEmitterLayer layer];
    self.heartsEmitter.emitterPosition = CGPointMake(likeButton.frame.origin.x + likeButton.frame.size.width/2.0,
                                                     likeButton.frame.origin.y + likeButton.frame.size.height/2.0);
    
    self.heartsEmitter.emitterSize = likeButton.bounds.size;
    self.heartsEmitter.emitterMode = kCAEmitterLayerVolume;
    self.heartsEmitter.emitterShape = kCAEmitterLayerRectangle;
    self.heartsEmitter.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell *heart = [CAEmitterCell emitterCell];
    heart.name = @"heart";
    heart.emissionLongitude = M_PI/2.0;
    heart.emissionRange = 0.55 * M_PI;
    heart.birthRate		= 0.0;
    heart.lifetime		= 10.0;
    heart.velocity		= -120;
    heart.velocityRange = 100;
    heart.yAcceleration = 20;
    heart.contents		= (id) [[UIImage imageNamed:@"PooHeart"] CGImage];
    heart.color			= [[UIColor colorWithRed:0.8 green:0.0 blue:0.5 alpha:0.3] CGColor];
    heart.redRange		= 0.3;
    heart.blueRange		= 0.3;
    heart.alphaSpeed	= -0.5 / heart.lifetime;
    heart.scale			= 0.15;
    heart.scaleSpeed	= 0.5;
    heart.spinRange		= 4.0 * M_PI;
    
    self.heartsEmitter.emitterCells = [NSArray arrayWithObject:heart];
    [self.window.layer addSublayer:heartsEmitter];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        RootViewController * rootVC = [[RootViewController alloc] init];
        self.window.rootViewController = rootVC;
        [rootVC release];
    });
 
    
    
    return YES;
}

- (void)tap:(UIButton *)button {
    {
        self.likeButton.alpha = 0;
        self.window.backgroundColor = [UIColor whiteColor];
        CABasicAnimation *heartsBurst = [CABasicAnimation animationWithKeyPath:@"emitterCells.heart.birthRate"];
        heartsBurst.fromValue		= [NSNumber numberWithFloat:130.0];
        heartsBurst.toValue			= [NSNumber numberWithFloat:  0.0];
        heartsBurst.duration		= 10.0;
        heartsBurst.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
        
        [self.heartsEmitter addAnimation:heartsBurst forKey:@"heartsBurst"];
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
