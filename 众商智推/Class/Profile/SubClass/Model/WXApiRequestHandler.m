//
//  WXApiRequestHandler.m
//  众商智推
//
//  Created by 杨 on 16/7/26.
//  Copyright © 2016年 bjywkj. All rights reserved.
//

#import "WXApiRequestHandler.h"
#import "WXApi.h"

@implementation WXApiRequestHandler



+ (NSString *)jumpToBizPay {
    
    //============================================================
    // V3&V4支付流程实现
    // 注意:参数配置请查看服务器端Demo
    // 更新时间：2015年11月20日
    //============================================================
    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        ZSLog(@"url:%@",urlString);
        ZSLog(@"%@",dict);
        
        
        NSDictionary *dictionary = @{
                                     @"appid":@"wx9c560386596469e2",
                                 @"partnerid":@"1369142802",
                                  @"prepayid":@"wx20160812172150fc696ab68f0200087373",
                                  @"noncestr":@"99fb655c1e2840ae8fd1e0fc2489c871",
                                 @"timestamp":@"1470993620",
                                   @"package":@"Sign=WXPay",
                                      @"sign":@"391316FD1D9D8083A88E89F9D162BEA0",
                          @"spbill_create_ip":@"192.168.112.112",
                                 @"total_fee":@"123",
                                      @"body":@"VIP"
                                     };
        
        /*
         [{"timestamp":"1470993620","partnerid":"1369142802","noncestr":"99fb655c1e2840ae8fd1e0fc2489c871","prepayid":"wx20160812172150fc696ab68f0200087373","sing":"391316FD1D9D8083A88E89F9D162BEA0","package":"Sign=WXPay","appid":"wx9c560386596469e2"}]
         */
        
        
        
        if(dict != nil){
            NSMutableString *retcode = [dictionary objectForKey:@"retcode"];
            ZSLog(@"%@",retcode);
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dictionary objectForKey:@"timestamp"];
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dictionary objectForKey:@"partnerid"];
                req.prepayId            = [dictionary objectForKey:@"prepayid"];
                req.nonceStr            = [dictionary objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dictionary objectForKey:@"package"];
                req.sign                = [dictionary objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dictionary objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
            }else{
                return [dictionary objectForKey:@"retmsg"];
            }
        }else{
            return @"服务器返回错误，未获取到json对象";
        }
    }else{
        return @"服务器返回错误";
    }
}


@end
