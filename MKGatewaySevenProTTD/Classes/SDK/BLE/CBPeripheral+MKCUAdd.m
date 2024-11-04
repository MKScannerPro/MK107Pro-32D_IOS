//
//  CBPeripheral+MKCUAdd.m
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKCUAdd.h"

#import <objc/runtime.h>

static const char *cu_manufacturerKey = "cu_manufacturerKey";
static const char *cu_deviceModelKey = "cu_deviceModelKey";
static const char *cu_hardwareKey = "cu_hardwareKey";
static const char *cu_softwareKey = "cu_softwareKey";
static const char *cu_firmwareKey = "cu_firmwareKey";

static const char *cu_passwordKey = "cu_passwordKey";
static const char *cu_disconnectTypeKey = "cu_disconnectTypeKey";
static const char *cu_customKey = "cu_customKey";

static const char *cu_passwordNotifySuccessKey = "cu_passwordNotifySuccessKey";
static const char *cu_disconnectTypeNotifySuccessKey = "cu_disconnectTypeNotifySuccessKey";
static const char *cu_customNotifySuccessKey = "cu_customNotifySuccessKey";

@implementation CBPeripheral (MKCUAdd)

- (void)cu_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &cu_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &cu_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &cu_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &cu_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &cu_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &cu_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &cu_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &cu_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            [self setNotifyValue:YES forCharacteristic:characteristic];
        }
        return;
    }
}

- (void)cu_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &cu_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &cu_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        objc_setAssociatedObject(self, &cu_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)cu_connectSuccess {
    if (![objc_getAssociatedObject(self, &cu_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &cu_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &cu_disconnectTypeNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.cu_hardware || !self.cu_firmware) {
        return NO;
    }
    if (!self.cu_password || !self.cu_disconnectType || !self.cu_custom) {
        return NO;
    }
    return YES;
}

- (void)cu_setNil {
    objc_setAssociatedObject(self, &cu_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cu_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cu_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cu_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cu_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &cu_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cu_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cu_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &cu_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cu_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cu_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)cu_manufacturer {
    return objc_getAssociatedObject(self, &cu_manufacturerKey);
}

- (CBCharacteristic *)cu_deviceModel {
    return objc_getAssociatedObject(self, &cu_deviceModelKey);
}

- (CBCharacteristic *)cu_hardware {
    return objc_getAssociatedObject(self, &cu_hardwareKey);
}

- (CBCharacteristic *)cu_software {
    return objc_getAssociatedObject(self, &cu_softwareKey);
}

- (CBCharacteristic *)cu_firmware {
    return objc_getAssociatedObject(self, &cu_firmwareKey);
}

- (CBCharacteristic *)cu_password {
    return objc_getAssociatedObject(self, &cu_passwordKey);
}

- (CBCharacteristic *)cu_disconnectType {
    return objc_getAssociatedObject(self, &cu_disconnectTypeKey);
}

- (CBCharacteristic *)cu_custom {
    return objc_getAssociatedObject(self, &cu_customKey);
}

@end
