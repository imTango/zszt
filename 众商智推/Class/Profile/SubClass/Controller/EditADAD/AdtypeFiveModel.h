//
//  AdtypeFiveModel.h
//  众商智推
//
//  Created by VINCENT on 16/8/1.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdtypeFiveModel : NSObject

@property (nonatomic,strong) NSData * image;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) NSString * adurl;
@property (nonatomic,strong) NSString * adId;


-(instancetype)initWithDictionary:(NSDictionary *)dic;

@end



/*
 [{"content":"1","title":"1","adId":"1","remark":"1","adurl":"1","userId":"123","image":"1","type":"1","pub":"1","twoDimensionCode":"1"},{"content":"2","title":"2","adId":"2","remark":"2","adurl":"2","userId":"123","image":"2","type":"2","pub":"2","twoDimensionCode":"2"}]
 */