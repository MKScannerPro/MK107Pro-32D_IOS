//
//  MKCUBXPButtonCRAlarmEventHeader.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2025/3/27.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCUBXPButtonCRAlarmEventHeaderDelegate <NSObject>

- (void)cu_bxpButtonCRAlarmEventHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)cu_bxpButtonCRAlarmEventHeaderView_exportButtonPressed;

@end

@interface MKCUBXPButtonCRAlarmEventHeader : UIView

@property (nonatomic, weak)id <MKCUBXPButtonCRAlarmEventHeaderDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
