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
        if (![dic[@"iconImg"] isKindOfClass:[NSNull class]]) {
            self.iconImg = dic[@"iconImg"];
        }
        if (![dic[@"adTitle"] isKindOfClass:[NSNull class]]) {
            self.adTitle = dic[@"adTitle"];
        }
        if (![dic[@"adDescrible"] isKindOfClass:[NSNull class]]) {
            self.adDescrible = dic[@"adDescrible"];
        }
        if (![dic[@"url"] isKindOfClass:[NSNull class]]) {
            self.url = dic[@"url"];
        }
    }
    return self;
}

@end
