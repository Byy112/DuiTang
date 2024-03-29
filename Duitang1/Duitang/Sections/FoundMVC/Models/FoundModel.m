//
//  FoundModel.m
//  Duitang
//
//  Created by lanouhn on 15/6/22.
//  Copyright (c) 2015年 lanouhn. All rights reserved.
//

#import "FoundModel.h"

@implementation FoundModel

+ (FoundModel *)createFoundModelWithDic:(NSDictionary *)dic {
    
    FoundModel * model = [[FoundModel alloc] init];
    if (dic[@"desc"] != nil) {
        
        model.title = dic[@"title"];
        model.desc = dic[@"desc"];
        model.photo_url = dic[@"photo_url"];
        model.source_link = dic[@"source_link"];
        model.price = dic[@"price"];
        model.promotion_price = dic[@"promotion_price"];
        
        
        return model;
        
    } else if (dic[@"group_name"] != nil) {
        
        if ([dic[@"content_type"] isEqualToString:@"entrance"]) {
            
            model.iconArr = [NSMutableArray new];
            model.target_idArr = [NSMutableArray new];
            for (int i = 0; i < 3; i++) {
                model.icon_url = dic[@"group_items"][i][@"icon_url"];
                model.name = dic[@"group_items"][i][@"name"];
                [model.nameArr addObject:model.name];
                [model.iconArr addObject:model.icon_url];
                [model.icon_url release];
                
                NSString * url = dic[@"group_items"][i][@"target"];
                if ([url containsString:@"guide"]) {
                    model.source_link = url;
                }
                if ([url containsString:@"topname="]) {
                    NSRange range1 = [url rangeOfString:@"topname="];
                    
                    NSUInteger index = range1.location + range1.length;
                    model.target_id = [url substringFromIndex:index];
                }
                if ([url containsString:@"theme_id="]) {
                    NSRange range1 = [url rangeOfString:@"theme_id="];
             
                    NSUInteger index1 = range1.location + range1.length;
                    NSRange range2 = [url rangeOfString:@"&app_layout"];
                    NSUInteger length = range2.location - range1.location - range1.length;
                    NSRange range = NSMakeRange(index1,length);
                    
                    model.target_id = [url substringWithRange:range];
                }
                [model.target_idArr addObject:model.target_id];
       
            }
            return model;
            
        } else if ([dic[@"content_type"] isEqualToString:@"banner"]) {
            model.iconArr = [NSMutableArray new];
            model.target_idArr = [NSMutableArray new];
            model.target_headArr = [NSMutableArray new];
            model.nameArr = [NSMutableArray new];
            for (int i = 0; i < 8; i++) {
                model.icon_url = dic[@"group_items"][i][@"icon_url"];
                [model.iconArr addObject:model.icon_url];
                [model.nameArr addObject:dic[@"group_items"][i][@"name"]];
                
                NSString * url = dic[@"group_items"][i][@"target"];
                if ([url containsString:@"guide"]) {
                    model.source_link = url;
                    model.target_id = url;
                    [model.target_headArr addObject:@""];
                }
                if ([url containsString:@"banner"]) {
                    NSRange range1 = [url rangeOfString:@"ad_id="];
                    
                    NSUInteger index1 = range1.location + range1.length;
                    NSRange range2 = [url rangeOfString:@"&group_by"];
                    NSUInteger length = range2.location - range1.location - range1.length;
                    NSRange range = NSMakeRange(index1,length);
                    
                    NSString * URL = [url substringWithRange:range];
                    URL = [NSString stringWithFormat:@"ad_id=%@&limit=12",URL];
                    model.target_id = [@"http://www.duitang.com/napi/ad/banner/list/?__dtac=%257B%2522_r%2522%253A%2520%2522378150%2522%257D&start=0&" stringByAppendingString:URL];
                    [model.target_headArr addObject:@""];

                }
                if ([url containsString:@"theme_id="]) {
                    NSRange range1 = [url rangeOfString:@"theme_id="];
                   
                    NSUInteger index1 = range1.location + range1.length;
                    NSRange range2 = [url rangeOfString:@"&theme_alias="];
                    NSUInteger length = range2.location - range1.location - range1.length;
                    NSRange range = NSMakeRange(index1,length);
                    
                    NSString * myURL = [url substringWithRange:range];
                    NSString * url1 = [NSString stringWithFormat:@"theme_id=%@",myURL];
                    NSString * headURL = [@"http://www.duitang.com/napi/theme/detail/?__dtac=%257B%2522_r%2522%253A%2520%2522597665%2522%257D&app_code=gandalf&app_version=4.6.2%20rv%3A461319&device_name=iPhone%205&device_platform=iPhone5%2C3&locale=zh_CN&platform_name=iPhone%20OS&platform_version=8.3&screen_height=568&screen_width=320&" stringByAppendingString:url1];
                    [model.target_headArr addObject:headURL];
                    
                    
                    NSUInteger index2 = range2.location + range2.length;
                    NSRange range4 = [url rangeOfString:@"&app_layout"];
                    NSUInteger length2 = range4.location - range2.location - range2.length;
                    NSRange range5 = NSMakeRange(index2,length2);
                    
                    NSString * indexURL = [url substringWithRange:range5];
//                    NSString * url2 = [NSString stringWithFormat:@"filter_id=%@",indexURL];
                    
                    model.target_id = [NSString stringWithFormat:@"filter_id=%@",indexURL];
                    
                    
//                    NSString * URL = [@"http://www.duitang.com/napi/blog/list/by_filter_id/?__dtac=%257B%2522_r%2522%253A%2520%2522597665%2522%257D&app_code=gandalf&app_version=4.6.2%20rv%3A461319&device_name=iPhone%205&device_platform=iPhone5%2C3&" stringByAppendingString:url2];
//                    model.target_id = [URL stringByAppendingString:@"&include_fields=album%2Csender%2Cicon_url%2Creply_count%2Clike_count&limit=0&locale=zh_CN&platform_name=iPhone%20OS&platform_version=8.3&screen_height=568&screen_width=320&start=0"];
                    
                    
                }
                [model.target_idArr addObject:model.target_id];
                
    
            }
            return model;
            
        } else if ([dic[@"content_type"] isEqualToString:@"shopping_entrance"]) {
            model.iconArr = [NSMutableArray new];
            model.target_idArr = [NSMutableArray new];
            for (int i = 0; i < 2; i ++) {
                
                NSString * url = dic[@"group_items"][i][@"target"];
                
                if ([url containsString:@"shopping"]) {
                    model.target_id = @"http://www.duitang.com/napi/shopping/preferential/list/?app_code=gandalf&from=app&app_version=4.6.2&limit=30&start=0";
                }
                if ([url containsString:@"blog"]) {
                    
                    model.target_id = @"5459e65e586df57518d70ff6";
                }
                [model.target_idArr addObject:model.target_id];
                
                
                
            }
            return model;
            
        } else if ([dic[@"content_type"] isEqualToString:@"category"]) {
            model.iconArr = [NSMutableArray arrayWithCapacity:0];
            model.target_idArr = [NSMutableArray new];
            for (int i = 0; i < 3; i ++) {
            
                NSString * url = dic[@"group_items"][i][@"target"];
                
                NSRange range1 = [url rangeOfString:@"id="];

                NSUInteger index = range1.location + range1.length;
//                url = [url substringFromIndex:index];
                model.target_id = [url substringFromIndex:index];
                
                
//                url = [NSString stringWithFormat:@"key=%@",url];
//                model.target_id = [@"http://www.duitang.com/napi/blog/list/by_category/?include_fields=sender%2Calbum%2Cicon_url%2Creply_count%2Clike_count&path=&__dtac=%257B%2522_r%2522%253A%2520%2522378150%2522%257D&start=0&limit=24&cate_key=%@" stringByAppendingString:url];

                [model.target_idArr addObject:model.target_id];
                
                
                
            }
            return model;
        }
        return model;
    } else if (dic[@"enabled_at_str"] != nil) {
        model.iconArr = [NSMutableArray new];
        model.target_idArr = [NSMutableArray new];
        model.target_headArr = [NSMutableArray new];
        model.nameArr = [NSMutableArray new];



        model.icon_url = dic[@"image_url"];
        model.name =  dic[@"description"];

        NSString * date = dic[@"enabled_at_str"];
        NSRange dateRange = [date rangeOfString:@" "];
        date = [date substringToIndex:dateRange.location];
        model.date = date;

        NSString * url = dic[@"target"];
        if ([url containsString:@"guide"]) {
            model.source_link = url;
            model.target_id = url;
            model.target_head = @"";
            [model.target_headArr addObject:@""];
        }
        if ([url containsString:@"banner"]) {
            NSRange range1 = [url rangeOfString:@"ad_id="];
            NSLog(@"798888%lu,%lu",(unsigned long)range1.location,(unsigned long)range1.length);
            NSUInteger index1 = range1.location + range1.length;
            NSRange range2 = [url rangeOfString:@"&group_by"];
            NSUInteger length = range2.location - range1.location - range1.length;
            NSRange range = NSMakeRange(index1,length);

            NSString * URL = [url substringWithRange:range];
            URL = [NSString stringWithFormat:@"ad_id=%@&limit=12",URL];
            model.target_id = [@"http://www.duitang.com/napi/ad/banner/list/?__dtac=%257B%2522_r%2522%253A%2520%2522378150%2522%257D&start=0&" stringByAppendingString:URL];
            model.target_head = @"";
            [model.target_headArr addObject:@""];


        }
        if ([url containsString:@"theme_id="]) {
            NSRange range1 = [url rangeOfString:@"theme_alias="];
            
            NSUInteger index1 = range1.location + range1.length;
            NSRange range2 = [url rangeOfString:@"&theme_id="];
          
            NSUInteger length = range2.location - range1.location - range1.length;
            NSRange range = NSMakeRange(index1,length);

            NSString * myURL = [url substringWithRange:range];
            


            NSUInteger index2 = range2.location + range2.length;
            NSRange range4 = [url rangeOfString:@"&app_layout"];
            NSUInteger length2 = range4.location - range2.location - range2.length;
            NSRange range5 = NSMakeRange(index2,length2);

            NSString * indexURL = [url substringWithRange:range5];
            
            NSString * url1 = [NSString stringWithFormat:@"theme_id=%@",indexURL];
            NSString * headURL = [@"http://www.duitang.com/napi/theme/detail/?__dtac=%257B%2522_r%2522%253A%2520%2522597665%2522%257D&app_code=gandalf&app_version=4.6.2%20rv%3A461319&device_name=iPhone%205&device_platform=iPhone5%2C3&locale=zh_CN&platform_name=iPhone%20OS&platform_version=8.3&screen_height=568&screen_width=320&" stringByAppendingString:url1];
            model.target_head = headURL;
            [model.target_headArr addObject:headURL];
            
//            NSString * url2 = [NSString stringWithFormat:@"filter_id=%@",myURL];
            
            model.target_id = [NSString stringWithFormat:@"filter_id=%@",myURL];
//            NSString * URL = [@"http://www.duitang.com/napi/blog/list/by_filter_id/?__dtac=%257B%2522_r%2522%253A%2520%2522597665%2522%257D&app_code=gandalf&app_version=4.6.2%20rv%3A461319&device_name=iPhone%205&device_platform=iPhone5%2C3&" stringByAppendingString:url2];
//            model.target_id = [URL stringByAppendingString:@"&include_fields=album%2Csender%2Cicon_url%2Creply_count%2Clike_count&limit=0&locale=zh_CN&platform_name=iPhone%20OS&platform_version=8.3&screen_height=568&screen_width=320&start=0"];
            
            
        }
        
        return model;
    }
    
    return model;
    
    
}
+ (FoundModel *)createFoundModelWithStr:(NSString *)str {
    FoundModel * model = [[FoundModel alloc] init];
    model.filter_id = str;
    model.filter_id = [NSString stringWithFormat:@"filter_id=%@",model.filter_id];
    return model;
    
    
}
@end
