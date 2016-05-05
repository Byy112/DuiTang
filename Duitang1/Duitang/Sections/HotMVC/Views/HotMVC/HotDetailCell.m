//
//  HotDetailCell.m
//  shiyan
//
//  Created by lanouhn on 15/6/19.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "HotDetailCell.h"
#import "UIImageView+WebCache.h"

@interface HotDetailCell ()
@property (nonatomic, assign)CGRect rect;
@property (nonatomic)float photo_width;
@property (nonatomic)float photo_height;
@end

@implementation HotDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加子控件
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.customView];
       
    }
    return self;
}


- (UIImageView *)imgView {
    
    if (!_imgView) {
        
        self.imgView = [[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, 100)] autorelease];
        _imgView.backgroundColor = [UIColor blueColor];
        
    }
    return [[_imgView retain] autorelease];
}

- (UIView *)customView {
    
    if (!_customView) {
        self.customView = [[UIView alloc]initWithFrame:CGRectMake(10, 230, self.bounds.size.width - 20, 75)];
       
        self.sender_avatar = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, 40, 40)];
        self.sender_avatar.backgroundColor = [UIColor brownColor];
        self.sender_avatar.layer.cornerRadius = 20;
         self.sender_avatar.clipsToBounds = YES;
        
        self.sender_username = [[UILabel alloc]initWithFrame:CGRectMake(55, 10, 100 , 20)];
        self.sender_username.font = [UIFont systemFontOfSize:13];
        self.sender_username.textColor = [UIColor blueColor];
        
        
        self.add_datetime_prettyLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.rect.size.width + 60 , 10, 50, 50)];
        
        self.add_datetime_prettyLabel.font = [UIFont systemFontOfSize:11];
        self.add_datetime_prettyLabel.textColor = [UIColor lightGrayColor];
        
        self.album_name = [[UILabel alloc]initWithFrame:CGRectMake(55, 30, self.frame.size.width - 20 - 60, 20)];
        self.album_name.font = [UIFont systemFontOfSize:13];
        
        [_customView addSubview:self.sender_avatar];
        [_customView addSubview:self.sender_username];
        [_customView addSubview:self.album_name];
        [_customView addSubview:self.add_datetime_prettyLabel];
        [self.sender_avatar release];
        [self.sender_username release];
        [self.album_name release];
    }
    return [[_customView retain] autorelease];
}

//重写setter方法，为label赋值
- (void)setModel:(HotModel *)model {
    
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
   
    self.photo_height = [_model.photo_height floatValue];
    self.photo_width = [_model.photo_width floatValue];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.photo_path] placeholderImage:[UIImage imageNamed:@"12.jpeg"]];
    
    [self.sender_avatar sd_setImageWithURL:[NSURL URLWithString:_model.sender_avatar] placeholderImage:nil];
    
    NSString *add_datetime_pretty = [NSString stringWithFormat:@"· %@", _model.add_datetime_pretty ];
    self.add_datetime_prettyLabel.text = add_datetime_pretty;
    
    self.sender_username.text = _model.sender_username;
    self.rect = [_model.sender_username boundingRectWithSize:CGSizeMake(300, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    CGRect fram = self.sender_username.frame;
    fram.size.width = self.rect.size.width;
    self.sender_username.frame = fram;
    self.add_datetime_prettyLabel.frame = CGRectMake(self.rect.size.width + 60 , 10, 60, 20);
    self.album_name.text = [NSString stringWithFormat:@"收集到 %@",_model.album_name];
    
}
- (void)dealloc {
    
    self.imgView = nil;
    self.sender_avatar = nil;
    self.sender_username = nil;
    self.album_name = nil;
    self.customView = nil;
    self.model = nil;
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
