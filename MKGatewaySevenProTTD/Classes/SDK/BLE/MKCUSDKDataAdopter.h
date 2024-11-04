//
//  MKCUSDKDataAdopter.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCUSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCUSDKDataAdopter : NSObject

+ (NSString *)fetchWifiSecurity:(mk_cu_wifiSecurity)security;

+ (NSString *)fetchWifiEapType:(mk_cu_eapType)eapType;

+ (NSString *)fetchConnectModeString:(mk_cu_connectMode)mode;

+ (NSString *)fetchMqttServerQosMode:(mk_cu_mqttServerQosMode)mode;

+ (NSString *)fetchAsciiCode:(NSString *)value;

/// 4字节16进制转换成47.104.81.55
/// @param value 4字节16进制数据
+ (NSString *)parseIpAddress:(NSString *)value;

+ (BOOL)isIpAddress:(NSString *)ip;

/// 将ip地址转换成对应的4个字节的16进制命令
/// @param ip @"47.104.81.55"
+ (NSString *)ipAddressToHex:(NSString *)ip;

+ (NSArray <NSString *>*)parseFilterMacList:(NSString *)content;

+ (NSArray <NSString *>*)parseFilterAdvNameList:(NSArray <NSData *>*)contentList;

@end

NS_ASSUME_NONNULL_END
