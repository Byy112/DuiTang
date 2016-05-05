//
//  PreferentialViewCell.m
//  Duitang
//
//  Created by lanouhn on 15/6/20.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "PreferentialViewCell.h"
#import "TransformToTaoBaoViewController.h"
#import "Manager.h"
#import "FoundModel.h"
#import "UIImageView+WebCache.h"


@implementation PreferentialViewCell
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self.contentView addSubview:self.photo];
//        [self.contentView addSubview:self.title];
//        [self.contentView addSubview:self.desc];
// 
//        [self.contentView addSubview:self.promotion_price];
//        [self.contentView addSubview:self.price];
//        //[self.contentView addSubview:self.click_count];
//
//        [self.contentView addSubview:self.coupon_title];//放了”¥“
//        [self.contentView addSubview:self.button];
//    }
//    return self;
//    
//}
//创建图片对象
- (UIImageView *)photo {
    if (_photo == nil) {
        self.photo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 110, 130)];
        _photo.backgroundColor = [UIColor cyanColor];
        _photo.layer.borderWidth = 1;
        _photo.layer.borderColor = [UIColor colorWithRed:212 / 255.0 green:212 / 255.0 blue:212 / 255.0 alpha:1.0].CGColor;
        
        [self.contentView addSubview:self.photo];
    }
    
    return _photo;
}
//创建显示文字的内容
- (UILabel *)desc {
    if (_desc == nil) {
        self.desc = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width / 3 + 20, 45, self.contentView.bounds.size.width * 2 / 3 - 30, 50)];
        ;
        _desc.numberOfLines = 0;
    
        _desc.textColor = [UIColor grayColor];
        _desc.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.desc];
    }
    
    return _desc;
}
//创建显示文字的内容
- (UILabel *)coupon_title {
    if (_coupon_title == nil) {
        self.coupon_title = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width / 3 + 20, 130, self.contentView.bounds.size.width / 32, 10)];
        _coupon_title.font = [UIFont systemFontOfSize:16];
        _coupon_title.textColor = [UIColor redColor];
        
        [self.contentView addSubview:self.coupon_title];

    }
        return _coupon_title;
}
//创建显示文字的内容
- (UILabel *)promotion_price {
    if (_promotion_price == nil) {
        self.promotion_price = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width / 3 + 30, 120, self.contentView.bounds.size.width / 5 + 6, 30)];
        _promotion_price.font = [UIFont systemFontOfSize:19];
        
        _promotion_price.text = @"75";
        _promotion_price.textColor = [UIColor redColor];
        [self.contentView addSubview:self.promotion_price];
    }
   
    return _promotion_price;
}
//创建显示文字的内容
- (UILabel *)price {
    if (_price == nil) {
        self.price = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width / 3 + 20, 90, self.contentView.bounds.size.width / 5 + 9, 39)];
        _price.font = [UIFont systemFontOfSize:15];
        _price.text = @"86";
        
        UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"oneline.png"]];
        _price.backgroundColor = color;
        [self.contentView addSubview:self.price];
    }
    
    return _price;
}
//创建显示文字的内容
- (UILabel *)click_count {
    
    self.click_count = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width / 4, 0, self.contentView.bounds.size.width - 30, self.contentView.bounds.size.height / 3 - 5)];
    _click_count.font = [UIFont systemFontOfSize:15];
    return _click_count;
}
//创建显示文字的内容
- (UILabel *)title {
    if (_title == nil) {
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width / 3 + 20, 15, self.contentView.bounds.size.width * 2 / 3 - 32, 40)];
        _title.text = @"划分为跟俄方唱歌";
        _title.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.title];
    }
   
    return _title;
}
- (UIButton *)button {
    if (_button == nil) {
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake(self.contentView.bounds.size.width - 95, 115, self.contentView.bounds.size.width / 5 + 16, 37);
        _button.backgroundColor = [UIColor redColor];
        _button.layer.cornerRadius = 5;
        [_button setTitle:@"去抢购" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button];

    }
       return _button;
}
//重写foundModel的setter方法
- (void)setFoundModel:(FoundModel *)foundModel {
    if (_foundModel != foundModel) {
        [_foundModel release];
        _foundModel = [foundModel retain];
    }
    self.contentView.frame = [UIScreen mainScreen].bounds;
    NSURL * imageURL = [NSURL URLWithString:foundModel.photo_url];
    [self.photo sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    
    self.title.text = foundModel.title;
    self.title.lineBreakMode = NSLineBreakByClipping;
    self.desc.lineBreakMode = NSLineBreakByClipping;
    
    self.desc.text = foundModel.desc;
    self.source_link = foundModel.source_link;
    self.price.text = [NSString stringWithFormat:@"市场价:%@",foundModel.price];
    self.promotion_price.text = [NSString stringWithFormat:@"%@",foundModel.promotion_price];

    self.coupon_title.text = @"¥";
    self.button.backgroundColor = [UIColor redColor];
}


- (void)click:(UIButton *)btn {
    
    TransformToTaoBaoViewController * taobaoVC = [[TransformToTaoBaoViewController alloc] init];
    taobaoVC.source_link = self.source_link;
    
    [[Manager sharedManager].navigationController pushViewController:taobaoVC animated:YES];
    
}

- (void)dealloc {
    self.photo = nil;
    self.title = nil;
    self.price = nil;
    self.promotion_price = nil;
    //self.click_count = nil;
    self.coupon_title = nil;
    self.desc = nil;
    [super dealloc];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
