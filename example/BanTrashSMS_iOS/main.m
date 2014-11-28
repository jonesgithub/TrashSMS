//
//  main.m
//  BanTrashSMS_iOS
//
//  Created by BlueCocoa on 14/11/28.
//  Copyright (c) 2014年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMS.h"

int main (int argc, const char * argv[])
{
    @autoreleasepool
    {	
        [[SMS sharedInstance] loadTrashData:@"/usr/bin/TrashData.plist"];
        NSLog(@"%@",[[SMS sharedInstance] isTrashSMS:@"没有最好的开发工具，只有最合适的开发工具。对于程序员来说，由于偏好的不同，会出现潜在的无休止的争论。幸运的是，这个群体更喜欢默默开发出优秀的产品来说服和打动别人。正是由于这一点点的执念，互联网才通过海量的优秀产品让世界逐渐变得美好。在开发过程中，如何平衡效率和稳定性的关系？在众多的产品需求和功能之间，开发者应该如何进行抉择和取舍？云端开发的过程中应该注意哪些问题？在分布式系统的的架构中，服务器端会遇到哪些问题，解决方法是什么？开发者最佳实践日·第6期－开发工具北京专场，专注于一站式数据管理平台的七牛云存储邀请了业界知名内测分发工具FIR.im创始人王猛、全网惟一的全栈工程师的培训基地优才网CEO伍星、LeanCloud联合创始人兼CTO丰俊文、思必驰信息科技有限公司技术总监苗顺平、七牛首席架构师李道兵一起为您带来一场技术盛宴。我们准备了各类干货及各种礼品，欢迎杭州的小伙伴踊跃前来～！"]);
        NSLog(@"%@",[[SMS sharedInstance] isTrashSMS:@"【澳门银河赌场直营】嫌去澳门赌场太麻烦，网上开户就能玩，持有澳门、菲律宾政府颁发博彩执照。提供真人百家乐，龙虎斗，体育赛事，彩票，游戏机，投注网址:www.yinhe83.com存取1000万3分钟实时到账； 已向澳门政府缴纳100亿押金.所以大额更安全(输赢几千万绝对不是问题)(以后再也不用跑去澳门赌博了，在家里轻轻松松的玩)注册网址：www.yinhe83.com【官方直营，信誉第一、玩家首选】"]);
    }
	return 0;
}

