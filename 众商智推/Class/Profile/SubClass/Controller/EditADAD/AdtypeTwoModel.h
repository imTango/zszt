//
//  AdtypeTwoModel.h
//  众商智推
//
//  Created by VINCENT on 16/8/1.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdtypeTwoModel : NSObject

@property (nonatomic,strong) NSData * image;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * content;
@property (nonatomic,strong) NSString * adurl;
@property (nonatomic,strong) NSString * adId;

-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end


