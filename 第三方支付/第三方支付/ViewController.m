//
//  ViewController.m
//  第三方支付
//
//  Created by zyy on 2017/12/20.
//  Copyright © 2017年 zyy. All rights reserved.
//

#import "ViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

        
    // Do any additional setup after loading the view, typically from a nib.
}

///支付宝支付
-(void)alipay{
    
    
    //将商品信息赋予AlixPayOrder的成员变量
    //    Order* order = [Order new];
    //
    //    // NOTE: app_id设置
    //    order.app_id = appID;
    //
    //    // NOTE: 支付接口名称
    //    order.method = @"alipay.trade.app.pay";
    //
    //    // NOTE: 参数编码格式
    //    order.charset = @"utf-8";
    //
    //    // NOTE: 当前时间点
    //    NSDateFormatter* formatter = [NSDateFormatter new];
    //    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    order.timestamp = [formatter stringFromDate:[NSDate date]];
    //
    //    // NOTE: 支付版本
    //    order.version = @"1.0";
    //
    //    // NOTE: sign_type设置
    //    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    //    order.biz_content = [BizContent new];
    //    order.biz_content.body = @"我是测试数据";
    //    order.biz_content.subject = @"1";
    //    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    //    order.biz_content.timeout_express = @"30m"; //超时时间设置
    //    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    //
    //    //将商品信息拼接成字符串
    //    NSString *orderInfo = [order orderInfoEncoded:NO];
    //    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    //    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    //    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    //    NSString *signedString = [signer signString:orderInfo];
    
    // NOTE: 如果加签成功，则继续执行支付
    //    if (signedString != nil) {
    
    //NSString* scheme    商户程序注册的URL protocol，供支付完成后回调商户程序使用。
    //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
    NSString *appScheme = @"alisdkdemo";
    
    // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
    //        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
    //                                 orderInfoEncoded, signedString];
    
    NSString * orderString = @"orderString";//这一步应在商户服务端完成，商户服务端直接将组装和签名后的请求串orderString传给客户端，客户端直接传给SDK发起请求。文档和Demo是为了示例效果在客户端实现。
    
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        NSLog(@"%@",resultDic);
        
    }];
}

//微信支付
-(void)wxpay{
    /*
     1、项目设置APPID
     商户在微信开放平台申请开发APP应用后，微信开放平台会生成APP的唯一标识APPID。在Xcode中打开项目，设置项目属性中的URL Schemes为您的APPID。
     2、注册APPID
     商户APP工程中引入微信lib库和头文件，调用API前，需要先向微信注册您的APPID
     3、调起支付
     商户服务器生成支付订单，先调用【统一下单API】生成预付单，获取到prepay_id后将参数再次签名传输给APP发起支付。
     4、支付结果回调
     照微信SDK Sample，在类实现onResp函数，支付完成后，微信APP会返回到商户APP并回调onResp函数，开发者需要在该函数中接收通知，判断返回错误码，如
     果支付成功则去后台查询支付结果再展示用户实际支付结果。注意    一定不能以客户端返回作为用户支付的结果，应以服务器端的接收的支付通知或查询API返回
     的结果为准。
     */
    PayReq *request = [[PayReq alloc] init];
    request.partnerId = @"10000100";
    request.prepayId= @"1101000000140415649af9fc314aa427";
    request.package = @"Sign=WXPay";
    request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
    request.timeStamp= [NSString stringWithFormat:@"%@",@"1397527777"].intValue;
    request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
    [WXApi sendReq:request];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
