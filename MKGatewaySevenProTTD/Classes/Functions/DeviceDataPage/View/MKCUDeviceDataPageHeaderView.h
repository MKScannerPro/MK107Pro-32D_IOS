//
//  MKCUDeviceDataPageHeaderView.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUDeviceDataPageHeaderViewModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@end

@protocol MKCUDeviceDataPageHeaderViewDelegate <NSObject>

- (void)cu_updateLoadButtonAction;

- (void)cu_powerButtonAction;

- (void)cu_scannerStatusChanged:(BOOL)isOn;

- (void)cu_manageBleDeviceAction;

@end

@interface MKCUDeviceDataPageHeaderView : UIView

@property (nonatomic, strong)MKCUDeviceDataPageHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKCUDeviceDataPageHeaderViewDelegate>delegate;

- (void)updateTotalNumbers:(NSInteger)numbers;

@end

NS_ASSUME_NONNULL_END
