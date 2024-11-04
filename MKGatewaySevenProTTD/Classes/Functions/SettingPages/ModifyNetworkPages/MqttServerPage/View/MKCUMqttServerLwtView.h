//
//  MKCUMqttServerLwtView.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUMqttServerLwtViewModel : NSObject

@property (nonatomic, assign)BOOL lwtStatus;

@property (nonatomic, assign)BOOL lwtRetain;

@property (nonatomic, assign)NSInteger lwtQos;

@property (nonatomic, copy)NSString *lwtTopic;

@property (nonatomic, copy)NSString *lwtPayload;

@end

@protocol MKCUMqttServerLwtViewDelegate <NSObject>

- (void)cu_lwt_statusChanged:(BOOL)isOn;

- (void)cu_lwt_retainChanged:(BOOL)isOn;

- (void)cu_lwt_qosChanged:(NSInteger)qos;

- (void)cu_lwt_topicChanged:(NSString *)text;

- (void)cu_lwt_payloadChanged:(NSString *)text;

@end

@interface MKCUMqttServerLwtView : UIView

@property (nonatomic, strong)MKCUMqttServerLwtViewModel *dataModel;

@property (nonatomic, weak)id <MKCUMqttServerLwtViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
