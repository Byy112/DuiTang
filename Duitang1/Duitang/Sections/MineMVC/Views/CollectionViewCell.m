//
//  CollectionViewCell.m
//  shiyan
//
//  Created by lanouhn on 15/6/28.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "CollectionViewCell.h"
#import "UIImageView+WebCache.h"

#import "User.h"

#define MSG_HEIGHT self.bounds.size.height - 5 - self.rect.size.height

@interface CollectionViewCell ()
@property (nonatomic, assign)CGRect rect;
@end

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        //添加子控件
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.msgLabel];
    }
    return self;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        
        self.imageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height - self.rect.size.height - 70)] autorelease];
        
         _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.contentMode = UIViewContentModeScaleToFill;
        
    }
    return [[_imageView retain] autorelease];
}
- (UILabel *)msgLabel {
    
    if (!_msgLabel) {
        
        self.msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,MSG_HEIGHT - 5,self.bounds.size.width - 10,self.rect.size.height )];
        
         _msgLabel.backgroundColor = [UIColor whiteColor];
        _msgLabel.numberOfLines = 0;
        _msgLabel.font = [UIFont systemFontOfSize:11];
    }
    return [[_msgLabel retain] autorelease];
}



//重写setter方法，为label赋值
- (void)setUser:(User *)user {
    if (_user != user) {
        [_user release];
        _user = [user retain];
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:_user.image]];
    
    self.msgLabel.text = _user.title;
    
    self.rect = [user.title boundingRectWithSize:CGSizeMake(self.bounds.size.width - 10, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    CGRect fram = self.msgLabel.frame;
    fram.size.height = self.rect.size.height;
    self.msgLabel.frame = fram;

    self.comment = user.comment_count;
    
}

- (void)dealloc {
    
    self.imageView = nil;
    self.msgLabel = nil;
    self.user = nil;
    [super dealloc];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width , self.bounds.size.height - self.rect.size.height - 10);
    
    self.msgLabel.frame = CGRectMake(5,MSG_HEIGHT - 5,self.bounds.size.width - 10,self.rect.size.height);
}


@end
