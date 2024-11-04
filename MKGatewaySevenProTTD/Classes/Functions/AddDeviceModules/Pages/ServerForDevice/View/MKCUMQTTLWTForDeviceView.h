//
//  MKCUMQTTLWTForDeviceView.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUMQTTLWTForDeviceViewModel : NSObject

@property (nonatomic, assign)BOOL lwtStatus;

@property (nonatomic, assign)BOOL lwtRetain;

@property (nonatomic, assign)NSInteger lwtQos;

@property (nonatomic, copy)NSString *lwtTopic;

@property (nonatomic, copy)NSString *lwtPayload;

@end

@protocol MKCUMQTTLWTForDeviceViewDelegate <NSObject>

- (void)cu_lwt_statusChanged:(BOOL)isOn;

- (void)cu_lwt_retainChanged:(BOOL)isOn;

- (void)cu_lwt_qosChanged:(NSInteger)qos;

- (void)cu_lwt_topicChanged:(NSString *)text;

- (void)cu_lwt_payloadChanged:(NSString *)text;

@end

@interface MKCUMQTTLWTForDeviceView : UIView

@property (nonatomic, strong)MKCUMQTTLWTForDeviceViewModel *dataModel;

@property (nonatomic, weak)id <MKCUMQTTLWTForDeviceViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
