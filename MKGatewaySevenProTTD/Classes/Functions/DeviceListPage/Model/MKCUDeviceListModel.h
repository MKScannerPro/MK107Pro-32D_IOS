//
//  MKCUDeviceListModel.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKCUDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCUDeviceListModel : MKCUDeviceModel

/// 0:Good 1:Medium 2:Poor
@property (nonatomic, assign)NSInteger wifiLevel;

@end

NS_ASSUME_NONNULL_END
