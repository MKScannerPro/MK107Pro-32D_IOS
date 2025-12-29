//
//  MKCUBXPButtonAccHeaderView.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCUBXPButtonAccHeaderViewDelegate <NSObject>

- (void)cu_bxpButtonAccHeaderView_syncButtonPressed:(BOOL)isOn;

- (void)cu_bxpButtonAccHeaderView_exportButtonPressed;

@end

@interface MKCUBXPButtonAccHeaderView : UIView

/// 是否显示底部的Timestamp和3-axis data标签，默认显示
@property (nonatomic, assign)BOOL showTimeLabel;

@property (nonatomic, weak)id <MKCUBXPButtonAccHeaderViewDelegate>delegate;

- (void)updateSyncStatus:(BOOL)isOn;

@end

NS_ASSUME_NONNULL_END
