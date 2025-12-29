//
//  MKCUNearbyWifiController.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/9/5.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCUNearbyWifiControllerDelegate <NSObject>

- (void)cu_nearbyWifiController_selectedWifi:(NSString *)ssid;

@end

@interface MKCUNearbyWifiController : MKBaseViewController

@property (nonatomic, weak)id <MKCUNearbyWifiControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
