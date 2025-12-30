//
//  MKCUManageBleDevicesTypeSelectedView.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2025/1/18.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, MKCUManageBleDevicesTypeSelectedViewType) {
    MKCUManageBleDevicesTypeSelectedViewTypeBXPBD,
    MKCUManageBleDevicesTypeSelectedViewTypeBXPBCR,
    MKCUManageBleDevicesTypeSelectedViewTypeBXPC,
    MKCUManageBleDevicesTypeSelectedViewTypeBXPD,
    MKCUManageBleDevicesTypeSelectedViewTypeBXPT,
    MKCUManageBleDevicesTypeSelectedViewTypeBXPS,
    MKCUManageBleDevicesTypeSelectedViewTypePIR,
    MKCUManageBleDevicesTypeSelectedViewTypeTOF,
    MKCUManageBleDevicesTypeSelectedViewTypeOther,
};

@interface MKCUManageBleDevicesTypeSelectedView : UIView

+ (void)showWithType:(MKCUManageBleDevicesTypeSelectedViewType)type
        selecteBlock:(void (^)(MKCUManageBleDevicesTypeSelectedViewType selectedType))selecteBlock;

@end

NS_ASSUME_NONNULL_END
