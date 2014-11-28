//
//  main.m
//  BanTrashSMS
//
//  Created by BlueCocoa on 14/11/28.
//  Copyright (c) 2014年 0xBBC. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DEVELOPMENT
#import "SMS.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        [[SMS sharedInstance] trainWithTextsPath:@"PATH TO TrashSMS/BanTrashSMS/Train/"];
        [[SMS sharedInstance] loadTrashData:[@"~/Desktop/TrashSMS/BanTrashSMS/BanTrashSMS/TrashData.plist" stringByStandardizingPath]];
        NSLog(@"%@",[[SMS sharedInstance] isTrashSMS:@"为了感谢您对新浪SAE产品的信任，我们为您赠送\"新浪企业邮箱-商务版 10用户/半年免费使用期\"（市场价值1000元！）使用企业邮箱可提升您公司的企业形象。相对于个人邮箱，企业邮箱具有安全，稳定，快速，便于管理等优势。目前，企业邮箱已经成为公司对外宣传和从事业务的不可缺少的工具。新浪企业邮箱支持自有域名绑定、企业微博绑定、单用户2G网盘、邮箱无限空间......更多精彩等您来发现！详情>>（还有个秘密：日后您若使用云豆为企业邮箱续费，终身享受5折优惠）还不快快行动，即刻领取开通！"]);
    }
    return 0;
}
