//
//  MKCUUserCredentialsView.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUUserCredentialsViewModel : NSObject

@property (nonatomic, copy)NSString *userName;

@property (nonatomic, copy)NSString *password;

@end

@protocol MKCUUserCredentialsViewDelegate <NSObject>

- (void)cu_mqtt_userCredentials_userNameChanged:(NSString *)userName;

- (void)cu_mqtt_userCredentials_passwordChanged:(NSString *)password;

@end

@interface MKCUUserCredentialsView : UIView

@property (nonatomic, strong)MKCUUserCredentialsViewModel *dataModel;

@property (nonatomic, weak)id <MKCUUserCredentialsViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
