//
//  CBPeripheral+MKCUAdd.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKCUAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *cu_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *cu_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *cu_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *cu_software;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *cu_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *cu_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *cu_disconnectType;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *cu_custom;

- (void)cu_updateCharacterWithService:(CBService *)service;

- (void)cu_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)cu_connectSuccess;

- (void)cu_setNil;

@end

NS_ASSUME_NONNULL_END
