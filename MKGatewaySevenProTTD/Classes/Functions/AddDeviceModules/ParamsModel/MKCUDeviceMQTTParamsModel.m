//
//  MKCUDeviceMQTTParamsModel.m
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKCUDeviceMQTTParamsModel.h"

#import "MKCUDeviceModel.h"

static MKCUDeviceMQTTParamsModel *paramsModel = nil;
static dispatch_once_t onceToken;

@implementation MKCUDeviceMQTTParamsModel

+ (MKCUDeviceMQTTParamsModel *)shared {
    dispatch_once(&onceToken, ^{
        if (!paramsModel) {
            paramsModel = [MKCUDeviceMQTTParamsModel new];
        }
    });
    return paramsModel;
}

+ (void)sharedDealloc {
    paramsModel = nil;
    onceToken = 0;
}

#pragma mark - getter
- (MKCUDeviceModel *)deviceModel {
    if (!_deviceModel) {
        _deviceModel = [[MKCUDeviceModel alloc] init];
    }
    return _deviceModel;
}

@end
