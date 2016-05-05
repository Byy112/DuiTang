//
//  HotModel.m
//  ceshi
//
//  Created by lanouhn on 15/6/18.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel


+ (HotModel *)createModelWithDic:(NSDictionary *)dic {

    HotModel *model = [[HotModel alloc]init];
    model.album_id = dic[@"album"][@"id"];
    model.album_name = dic[@"album"][@"name"];
    model.photo_path = dic[@"photo"][@"path"];
    model.photo_height = dic[@"photo"][@"height"];
    model.photo_width = dic[@"photo"][@"width"];
    model.like_count = dic[@"like_count"];
    model.reply_count = dic[@"reply_count"];
    model.sender_username = dic[@"sender"][@"username"];
    model.sender_avatar = dic[@"sender"][@"avatar"];
    model.favorite_count = dic[@"favorite_count"];
    model.blog_id = dic[@"id"];
    model.msg = dic[@"msg"];
    model.add_datetime_pretty = dic[@"add_datetime_pretty"];
    
    //------------------taobao---------------------------
    model.source_title = dic[@"source_title"];
    model.source_link = dic[@"source_link"];
    model.price = dic[@"item"][@"price"];
    
    
    return [model autorelease];
}
@end
