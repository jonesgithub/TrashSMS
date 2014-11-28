//
//  SMS.h
//  BanTrashSMS_iOS
//
//  Created by BlueCocoa on 14/11/28.
//
//

#import <Foundation/Foundation.h>

/*!
 *  @brief  阀值, 在import SMS.h 前宏定义`TrashSMSThreshold`以覆盖
 */

#ifndef TrashSMSThreshold
#define TrashSMSThreshold 0.44
#endif

@interface SMS : NSObject

/*!
 *  @brief  返回单例
 */
+ (instancetype)sharedInstance;

/*!
 *  @brief  加载垃圾短信的训练库
 *
 *  @param path 垃圾短信的训练库的文件路径
 */
- (void)loadTrashData:(NSString *)path;

/*!
 *  @brief  判断是否为垃圾短信
 *
 *  @param sms 短信内容
 *
 *  @return key    -   value    -    说明
 *          Trash      布尔型         是否为垃圾短信
 *          Score      得分(float)    得分越高, 说明可疑词越多
 *          Threshold  阀值(float)    将得分除以短信长度后, 与阀值对比, 大于阀值则为垃圾短信
 */
- (NSDictionary *)isTrashSMS:(NSString *)sms;

#ifdef DEVELOPMENT

/*!
 *  @brief  训练识别垃圾短信
 *
 *  @param path 垃圾短信样本的文件夹路径
 *
 *  @discussion  需要在import SMS.h 前设定`DEVELOPMENT`宏
 *               下方的`TrashDataFile`宏所指的路径仅在训练时使用, Release中直接向loadTrashData:中传参
 */

#define TrashDataFile @"/usr/bin/TrashData.plist"

- (void)trainWithTextsPath:(NSString *)path;

#endif

@end
