//
//  AdtypeThreeModel.m
//  众商智推
//
//  Created by VINCENT on 16/8/1.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "AdtypeThreeModel.h"

@implementation AdtypeThreeModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        if (![dic[@"image"] isKindOfClass:[NSNull class]]) {
            self.image = dic[@"image"];
        }
        if (![dic[@"title"] isKindOfClass:[NSNull class]]) {
            self.title = dic[@"title"];
        }
        if (![dic[@"twoDimensionCode"] isKindOfClass:[NSNull class]]) {
            self.twoDimensionCode = dic[@"twoDimensionCode"];
        }
        if (![dic[@"adurl"] isKindOfClass:[NSNull class]]) {
            self.adurl = dic[@"adurl"];
        }
        if (![dic[@"adId"] isKindOfClass:[NSNull class]]) {
            self.adId = dic[@"adId"];
        }
    }
    return self;
}

@end
