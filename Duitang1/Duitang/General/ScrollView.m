//
//  ScrollView.m
//  Duitang
//
//  Created by lanouhn on 15/6/18.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "ScrollView.h"
#import "UIImageView+WebCache.h"
#import "Manager.h"
#import "FoundModel.h"
#import "TransformToTaoBaoViewController.h"
#import "MoreTableViewController.h"
#import "ClassificationViewController.h"
@implementation ScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createScrollView];
        //[self createPanGestureRecognzer];
    }
    return self;
}
//- (void)createPanGestureRecognzer {
//    //轻拍手势
//    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterAnotherView:)];
//    [self addGestureRecognizer:tapGesture];
//    
// 
//
//}
- (void)enterAnotherView:(UITapGestureRecognizer *)tap {
    
//    NSInteger index = tap.view.tag - 100;
    
    UISearchBar * searchBar = (UISearchBar *)[[Manager sharedManager].navigationController.navigationBar viewWithTag:122];
    //    [searchBar removeFromSuperview];
    searchBar.alpha = 0;
     
    if ([self.target_idArr[tap.view.tag - 100] containsString:@"guide"]) {
        TransformToTaoBaoViewController * transformToWebVC = [[TransformToTaoBaoViewController alloc] init];
        transformToWebVC.source_link = self.target_idArr[tap.view.tag - 100];
        [[Manager sharedManager].navigationController pushViewController:transformToWebVC animated:YES];
    
    }else if ([self.target_idArr[tap.view.tag - 100] containsString:@"ad"]) {
        MoreTableViewController * moreVC = [[MoreTableViewController alloc] init];
//        moreVC.source_link = self.target_idArr[tap.view.tag - 100];
        [[Manager sharedManager].navigationController pushViewController:moreVC animated:YES];
        
    } else if ([self.target_idArr[tap.view.tag - 100] containsString:@"filter_id"]) {
   
        ClassificationViewController * classVC = [[ClassificationViewController alloc] init];
        classVC.title = self.titleArray[tap.view.tag - 100];
//        classVC.target_id = self.target_idArr[tap.view.tag - 100];
        classVC.target_idHeader = self.target_idHeaderArr[tap.view.tag - 100];
        [[Manager sharedManager].navigationController pushViewController:classVC animated:YES];
        
    }
    
}
- (NSMutableArray *)icon_urlArr {
    
    if (_icon_urlArr == nil) {
        self.icon_urlArr = [NSMutableArray new];
    }
    return _icon_urlArr;
    
}
- (NSMutableArray *)titleArray {
    if (_titleArray == nil) {
        self.titleArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _titleArray;
    
}
- (void)createScrollView {
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height)];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(115 * 8, 0);
//    scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
//    
//    NSArray * imageName = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg",@"5.jpg",@"3.jpg",@"1.jpg",@"2.jpg"];
//    NSArray * name = @[@"门卫",@"大学",@"你是我女法官",@"个人股",@"额外革命",@"fewf",@"法国",@"更改"];
    for (int i = 0; i < self.titleArray.count; i ++) {
        UIImageView * imageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 100, 90)];
        
        self.imageView = imageview;
        [self.imageView sd_setImageWithURL:self.icon_urlArr[i] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
        self.imageView.tag = 100 + i;
        self.imageView.userInteractionEnabled = YES;
        //轻拍手势
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enterAnotherView:)];
        [self.imageView addGestureRecognizer:tapGesture];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 110, 20)];
        
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        self.label = label;
        self.label.text = self.titleArray[i];
        UIView * content = [[UIView alloc] initWithFrame:CGRectMake(115 * i, 0, 120, self.bounds.size.height)];
        
        [content addSubview:imageview];
        [content addSubview:label];
        [scrollView addSubview:content];
        [imageview release];
        [label release];
        
        [content release];
        
    }
    //
    scrollView.contentOffset = CGPointMake(0, 0);
    scrollView.pagingEnabled = NO;
    
    //4.边界是否回弹
    scrollView.bounces = NO;//默认为YES
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    
    scrollView.delegate = self;
    self.scrollView = scrollView;
    [self addSubview:scrollView];
    [scrollView release];
    
}

- (void)configureSrollWithFoundModel:(FoundModel *)model {
//    for (int i = 0; i < 8; i++) {
//        self.target_idArr[i] = model.target_idArr[i];
//        
////        self.target_idHeaderArr[i] = model.target_headArr[i];
//        self.icon_urlArr[i] = model.iconArr[i];
//        self.titleArray[i] = model.nameArr[i];
//    }
    self.imageView.backgroundColor = [UIColor cyanColor];
    
    self.titleArray = [NSMutableArray arrayWithArray:model.nameArr];
    self.icon_urlArr = [NSMutableArray arrayWithArray:model.iconArr];
    self.target_idHeaderArr = [NSMutableArray arrayWithArray:model.target_headArr];
    self.target_idArr = [NSMutableArray arrayWithArray:model.target_idArr];
    
    [self createScrollView];
}


@end
