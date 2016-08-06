//
//  AdtypeTwoModel.h
//  众商智推
//
//  Created by VINCENT on 16/8/1.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdtypeTwoModel : NSObject

@property (nonatomic,strong) NSData * iconImg;
@property (nonatomic,strong) NSString * adTitle;
@property (nonatomic,strong) NSString * adDescrible;
@property (nonatomic,strong) NSString * url;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end


