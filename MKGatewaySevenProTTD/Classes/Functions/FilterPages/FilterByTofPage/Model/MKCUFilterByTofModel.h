//
//  MKCUFilterByTofModel.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUFilterByTofModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, strong)NSArray *codeList;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithCodeList:(NSArray <NSString *>*)codeList
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
