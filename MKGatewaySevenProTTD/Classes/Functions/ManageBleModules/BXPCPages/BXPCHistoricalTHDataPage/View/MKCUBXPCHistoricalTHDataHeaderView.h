//
//  MKCUBXPCHistoricalTHDataHeaderView.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2025/2/11.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCUBXPCHistoricalTHDataHeaderViewDelegate <NSObject>

- (void)cu_bxpcHistoricalHTDataHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)cu_bxpcHistoricalHTDataHeaderView_deleteButtonPressed;

- (void)cu_bxpcHistoricalHTDataHeaderView_exportButtonPressed;

@end

@interface MKCUBXPCHistoricalTHDataHeaderView : UIView

@property (nonatomic, weak)id <MKCUBXPCHistoricalTHDataHeaderViewDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
