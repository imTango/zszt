//
//  HTTPToolsPost.m
//  众商智推
//
//  Created by VINCENT on 16/8/10.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "HTTPToolsPost.h"

@implementation HTTPToolsPost
//存储数据到后台
+(void)StoragePostRequestWithUrl:(NSString *)urlStr parameters:(id)parameters imageData:(NSData*)image QRCode:(NSData*)QRCode success:(HttpBlock)success fail:(void(^)())fail{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];

    [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            if (image != nil) {
                NSDate * date = [NSDate date];
                NSString * dateStr = [formatter stringFromDate:date];
                [formData appendPartWithFileData:image name:@"image" fileName:dateStr mimeType:@"image/jpeg"];
            }
        
            if (QRCode != nil) {
                NSDate * date = [NSDate date];
                NSString * dateStr = [formatter stringFromDate:date];
                [formData appendPartWithFileData:QRCode name:@"twoDimensionCode" fileName:dateStr mimeType:@"image/jpeg"];
            }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString * AdId = dic[@"id"];
        [MBProgressHUD showSuccess:@"上传成功"];
        success(AdId);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"当前网络状况较差"];
    }];
}

//删除后台的广告条数据
+(void)DeletePostRequestWithUrl:(NSString *)urlStr parameters:(id)parameters  completion:(void(^)())completion{
    [AFNetworkUtil postDictWithUrl:urlStr parameters:parameters success:^(id responseObject) {
        [MBProgressHUD showSuccess:@"删除成功"];
        completion();
    } fail:^{
        [MBProgressHUD showError:@"当前网络状况较差"];
        completion();
    }];
}

//编辑后台的广告条数据
+(void)EditPostRequestWithUrl:(NSString *)urlStr parameters:(id)parameters imageData:(NSData*)image QRCode:(NSData*)QRCode completion:(void (^)())completion{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
     [manager POST:urlStr parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        if (image != nil) {
            NSDate * date = [NSDate date];
            NSString * dateStr = [formatter stringFromDate:date];
            [formData appendPartWithFileData:image name:@"image" fileName:dateStr mimeType:@"image/jpeg"];
        }
        
        if (QRCode != nil) {
            NSDate * date = [NSDate date];
            NSString * dateStr = [formatter stringFromDate:date];
            [formData appendPartWithFileData:QRCode name:@"twoDimensionCode" fileName:dateStr mimeType:@"image/jpeg"];
        }
         completion();
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD showSuccess:@"编辑成功"];
         completion();
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"当前网络状况较差"];
        completion();
    }];

}
@end
