//
//  HTTPToolsPost.h
//  众商智推
//
//  Created by VINCENT on 16/8/10.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HttpBlock)(NSString * ADId);

@interface HTTPToolsPost : NSObject

+(void)StoragePostRequestWithUrl:(NSString *)urlStr parameters:(id)parameters imageData:(NSData*)image QRCode:(NSData*)QRCode success:(HttpBlock)success fail:(void(^)())fail;

+(void)EditPostRequestWithUrl:(NSString *)urlStr parameters:(id)parameters imageData:(NSData*)image QRCode:(NSData*)QRCode completion:(void(^)())completion;

+(void)DeletePostRequestWithUrl:(NSString *)urlStr parameters:(id)parameters completion:(void(^)())completion;


@end
