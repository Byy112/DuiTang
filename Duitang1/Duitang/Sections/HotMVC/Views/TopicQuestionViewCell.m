//
//  TopicQuestionViewCell.m
//  shiyan
//
//  Created by lanouhn on 15/6/27.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "TopicQuestionViewCell.h"
#import "UIImageView+WebCache.h"
#import "TopicModel.h"
@interface TopicQuestionViewCell ()
@property (nonatomic, assign)CGRect rect;
@end

@implementation TopicQuestionViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加子控件
        [self.contentView addSubview:self.sender_username];
        [self.contentView addSubview:self.sender_avatar];
        [self.contentView addSubview:self.content];
        [self.contentView addSubview:self.clubName];
    }
    return self;
}

- (UIImageView *)sender_avatar {

    if (!_sender_avatar) {
        self.sender_avatar = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];

        _sender_avatar.layer.cornerRadius = 20;
        _sender_avatar.clipsToBounds = YES;
    }
    return [[_sender_avatar retain] autorelease];
}
- (UILabel *)sender_username {

    if (!_sender_username) {
        self.sender_username = [[UILabel alloc]initWithFrame:CGRectMake(60, 20, 100 , 20)];
        _sender_username.font = [UIFont systemFontOfSize:15];
        _sender_username.textColor = [UIColor blueColor];

    }
    return [[_sender_username retain] autorelease];
}
- (UILabel *)content {

    if (!_content) {
    self.content = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, self.bounds.size.width - 20 , 20)];
    _content.font = [UIFont systemFontOfSize:15];
    _content.numberOfLines = 0;

    }
    return [[_content retain] autorelease];
}
- (UILabel *)clubName {

    if (!_clubName) {
        self.clubName = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100 , 20)];
        _clubName.font = [UIFont systemFontOfSize:15];
      
    }
    return [[_clubName retain] autorelease];
}

//重写setter方法，为label赋值
- (void)setModel:(TopicModel*)model {
    
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    
    [self.sender_avatar sd_setImageWithURL:[NSURL URLWithString:_model.sender_avatar] placeholderImage:nil];
    
    self.sender_username.text = _model.sender_username;
    self.content.text = _model.content;
    self.rect = [_model.content boundingRectWithSize:CGSizeMake(self.bounds.size.width - 20, 100000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGRect fram = self.content.frame;
    fram.size = self.rect.size;
    self.content.frame = fram;
    
    self.clubName.frame = CGRectMake( 10, self.rect.size.height + 70, 150, 20);
    self.clubName.text = [NSString stringWithFormat:@"来自 %@",_model.clubName];
    
}
- (void)dealloc {
    
    self.sender_avatar = nil;
    self.sender_username = nil;
    self.clubName = nil;
    self.content = nil;
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
