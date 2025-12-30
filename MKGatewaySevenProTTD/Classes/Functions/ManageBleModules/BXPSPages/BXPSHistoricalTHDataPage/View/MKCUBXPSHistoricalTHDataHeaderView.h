//
//  MKCUBXPSHistoricalTHDataHeaderView.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2025/2/11.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCUBXPSHistoricalTHDataHeaderViewDelegate <NSObject>

- (void)cu_BXPSHistoricalHTDataHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)cu_BXPSHistoricalHTDataHeaderView_deleteButtonPressed;

- (void)cu_BXPSHistoricalHTDataHeaderView_exportButtonPressed;

@end

@interface MKCUBXPSHistoricalTHDataHeaderView : UIView

@property (nonatomic, weak)id <MKCUBXPSHistoricalTHDataHeaderViewDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
