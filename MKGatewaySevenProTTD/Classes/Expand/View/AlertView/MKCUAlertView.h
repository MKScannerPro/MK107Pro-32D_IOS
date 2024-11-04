//
//  MKCUAlertView.h
//  MKGatewaySevenProTTD
//
//  Created by aa on 2024/11/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUAlertViewModel : NSObject

/// Title
@property (nonatomic, copy)NSString *title;

/// Message
@property (nonatomic, copy)NSString *message;

/// Cancel按钮Title
@property (nonatomic, copy)NSString *cancelTitle;

/// Confirm按钮Title
@property (nonatomic, copy)NSString *confirmTitle;

/// 当收到该通知的时候，如果alert被弹出，则自动消失
@property (nonatomic, copy)NSString *notificationName;

@end

@interface MKCUAlertView : UIView

- (void)showWithModel:(MKCUAlertViewModel *)dataModel
         cancelAction:(void (^)(void))cancelBlock
        confirmAction:(void (^)(void))confirmBlock;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
