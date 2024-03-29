//
//  MsgCell.m
//  shiyan
//
//  Created by lanouhn on 15/6/19.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "MsgCell.h"

@interface MsgCell ()
@property (nonatomic)CGRect rect;
@end

@implementation MsgCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //添加子控件
        [self.contentView addSubview:self.msgLabel];
    }
    return self;
    
}
- (UILabel *)msgLabel {
    
    if (!_msgLabel) {
        
        self.msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 10, self.frame.size.width - 20, self.rect.size.height)];
        _msgLabel.numberOfLines = 0;
        _msgLabel.font = [UIFont systemFontOfSize:15];
    }
    return [[_msgLabel retain] autorelease];
}
//重写setter方法，为label赋值
- (void)setModel:(HotModel *)model {
    
    if (_model != model) {
        [_model release];
        _model = [model retain];
    }
    self.msgLabel.text = _model.msg;
   //计算文本的高度
    self.rect = [model.msg boundingRectWithSize:CGSizeMake(self.bounds.size.width - 10, 1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGRect fram = self.msgLabel.frame;
    fram.size.height = self.rect.size.height;
    self.msgLabel.frame = fram;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
