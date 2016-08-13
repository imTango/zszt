//
//  AdtypeTwoModel.m
//  众商智推
//
//  Created by VINCENT on 16/8/1.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "AdtypeTwoModel.h"

@implementation AdtypeTwoModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        if (![dic[@"image"] isKindOfClass:[NSNull class]]) {
            self.image = dic[@"image"];
        }
        if (![dic[@"title"] isKindOfClass:[NSNull class]]) {
            self.title = dic[@"title"];
        }
        if (![dic[@"content"] isKindOfClass:[NSNull class]]) {
            self.content = dic[@"content"];
        }
        if (![dic[@"image"] isKindOfClass:[NSNull class]]) {
            self.adurl = dic[@"adurl"];
        }
        if (![dic[@"adId"] isKindOfClass:[NSNull class]]) {
            self.adId = dic[@"adId"];
        }
    }
    return self;
}

@end
