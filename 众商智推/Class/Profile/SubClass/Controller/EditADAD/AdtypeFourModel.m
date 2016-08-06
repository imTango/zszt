//
//  AdtypeFourModel.m
//  众商智推
//
//  Created by VINCENT on 16/8/1.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "AdtypeFourModel.h"

@implementation AdtypeFourModel

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
        if (![dic[@"adTitle"] isKindOfClass:[NSNull class]]) {
            self.adTitle = dic[@"adTitle"];
        }
        if (![dic[@"iconImg"] isKindOfClass:[NSNull class]]) {
            self.iconImg = dic[@"iconImg"];
        }
        if (![dic[@"focusBtnImg"] isKindOfClass:[NSNull class]]) {
            self.focusBtnImg = dic[@"focusBtnImg"];
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
