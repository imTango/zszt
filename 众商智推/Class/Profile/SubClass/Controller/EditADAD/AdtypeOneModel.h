//
//  AdtypeOneModel.h
//  众商智推
//
//  Created by VINCENT on 16/8/1.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdtypeOneModel : NSObject

@property (nonatomic,strong) NSData * bgImg;
@property (nonatomic,strong) NSString * adTitle;
@property (nonatomic,strong) NSString * url;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end
