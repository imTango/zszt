//
//  AdtypeOneModel.m
//  众商智推
//
//  Created by VINCENT on 16/8/1.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "AdtypeOneModel.h"

@implementation AdtypeOneModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        if (![dic[@"bgImg"] isKindOfClass:[NSNull class]]) {
            self.bgImg = dic[@"bgImg"];
        }
        if (![dic[@"adTitle"] isKindOfClass:[NSNull class]]) {
            self.adTitle = dic[@"adTitle"];
        }
        if (![dic[@"url"] isKindOfClass:[NSNull class]]) {
            self.url = dic[@"url"];
        }
    }
    return self;
}


@end

