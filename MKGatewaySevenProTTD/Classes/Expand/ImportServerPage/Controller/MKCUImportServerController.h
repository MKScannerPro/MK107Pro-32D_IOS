//
//  MKCUImportServerController.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseViewController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCUImportServerControllerDelegate <NSObject>

- (void)cu_selectedServerParams:(NSString *)fileName;

@end

@interface MKCUImportServerController : MKBaseViewController

@property (nonatomic, weak)id <MKCUImportServerControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
