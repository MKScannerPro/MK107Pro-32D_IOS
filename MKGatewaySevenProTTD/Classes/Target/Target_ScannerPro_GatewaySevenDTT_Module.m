//
//  Target_ScannerPro_GatewaySevenDTT_Module.m
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "Target_ScannerPro_GatewaySevenDTT_Module.h"

#import "MKCUDeviceListController.h"

@implementation Target_ScannerPro_GatewaySevenDTT_Module

- (UIViewController *)Action_MKScannerPro_GatewaySevenDTT_DeviceListPage:(NSDictionary *)params {
    MKCUDeviceListController *vc = [[MKCUDeviceListController alloc] init];
    vc.connectServer = YES;
    return vc;
}

@end
