//
//  MD5.m
//  众商智推
//
//  Created by VINCENT on 16/8/12.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "MD5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation MD5
+ (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), digest);
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}




@end
