//
//  MKCUMQTTDataManager.m
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKCUMQTTDataManager.h"

#import "MKMacroDefines.h"

#import "MKCUMQTTServerManager.h"

#import "MKCUMQTTOperation.h"

NSString *const MKCUMQTTSessionManagerStateChangedNotification = @"MKCUMQTTSessionManagerStateChangedNotification";

NSString *const MKCUReceiveDeviceOnlineNotification = @"MKCUReceiveDeviceOnlineNotification";
NSString *const MKCUReceiveDeviceNetStateNotification = @"MKCUReceiveDeviceNetStateNotification";
NSString *const MKCUReceiveDeviceOTAResultNotification = @"MKCUReceiveDeviceOTAResultNotification";
NSString *const MKCUReceiveDeviceNpcOTAResultNotification = @"MKCUReceiveDeviceNpcOTAResultNotification";
NSString *const MKCUReceiveDeviceUpdateEapCertsResultNotification = @"MKCUReceiveDeviceUpdateEapCertsResultNotification";
NSString *const MKCUReceiveDeviceResetByButtonNotification = @"MKCUReceiveDeviceResetByButtonNotification";
NSString *const MKCUReceiveDeviceUpdateMqttCertsResultNotification = @"MKCUReceiveDeviceUpdateMqttCertsResultNotification";

NSString *const MKCUReceiveDeviceDatasNotification = @"MKCUReceiveDeviceDatasNotification";
NSString *const MKCUReceiveGatewayDisconnectBXPButtonNotification = @"MKCUReceiveGatewayDisconnectBXPButtonNotification";
NSString *const MKCUReceiveGatewayDisconnectDeviceNotification = @"MKCUReceiveGatewayDisconnectDeviceNotification";
NSString *const MKCUReceiveGatewayConnectedDeviceDatasNotification = @"MKCUReceiveGatewayConnectedDeviceDatasNotification";

NSString *const MKCUReceiveBxpButtonDfuProgressNotification = @"MKCUReceiveBxpButtonDfuProgressNotification";
NSString *const MKCUReceiveBxpButtonDfuResultNotification = @"MKCUReceiveBxpButtonDfuResultNotification";

NSString *const MKCUReceiveBxpDfuFailedNotification = @"MKCUReceiveBxpDfuFailedNotification";

NSString *const MKCUReceiveDeviceOfflineNotification = @"MKCUReceiveDeviceOfflineNotification";


NSString *const MKCUReceiveBXPBtnAccDataNotification = @"MKCUReceiveBXPBtnAccDataNotification";

NSString *const MKCUReceiveBXPBtnCRAccDataNotification = @"MKCUReceiveBXPBtnCRAccDataNotification";
NSString *const MKCUReceiveBXPBtnCRAlarmEventDataNotification = @"MKCUReceiveBXPBtnCRAlarmEventDataNotification";

NSString *const MKCUReceiveBXPCRealTimeHTDataNotification = @"MKCUReceiveBXPCRealTimeHTDataNotification";
NSString *const MKCUReceiveBXPCAccDataNotification = @"MKCUReceiveBXPCAccDataNotification";
NSString *const MKCUReceiveBXPCHistoricalHTDataNotification = @"MKCUReceiveBXPCHistoricalHTDataNotification";

NSString *const MKCUReceiveBXPDAccDataNotification = @"MKCUReceiveBXPDAccDataNotification";

NSString *const MKCUReceiveBXPTAccDataNotification = @"MKCUReceiveBXPTAccDataNotification";

NSString *const MKCUReceiveBXPSRealTimeHTDataNotification = @"MKCUReceiveBXPSRealTimeHTDataNotification";
NSString *const MKCUReceiveBXPSAccDataNotification = @"MKCUReceiveBXPSAccDataNotification";
NSString *const MKCUReceiveBXPSHistoricalHTDataNotification = @"MKCUReceiveBXPSHistoricalHTDataNotification";

NSString *const MKCUReceiveMKPirSensorDataNotification = @"MKCUReceiveMKPirSensorDataNotification";

NSString *const MKCUReceiveMKTofAccDataNotification = @"MKCUReceiveMKTofAccDataNotification";
NSString *const MKCUReceiveMKTofDistanceDataNotification = @"MKCUReceiveMKTofDistanceDataNotification";

static MKCUMQTTDataManager *manager = nil;
static dispatch_once_t onceToken;

@interface MKCUMQTTDataManager ()

@property (nonatomic, strong)NSOperationQueue *operationQueue;

@end

@implementation MKCUMQTTDataManager

- (instancetype)init {
    if (self = [super init]) {
        [[MKCUMQTTServerManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKCUMQTTDataManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKCUMQTTDataManager new];
        }
    });
    return manager;
}

+ (void)singleDealloc {
    [[MKCUMQTTServerManager shared] removeDataManager:manager];
    onceToken = 0;
    manager = nil;
}

#pragma mark - MKCUServerManagerProtocol
- (void)cu_didReceiveMessage:(NSDictionary *)data onTopic:(NSString *)topic {
    if (!ValidDict(data) || !ValidNum(data[@"msg_id"]) || !ValidStr(data[@"device_info"][@"mac"])) {
        return;
    }
    NSInteger msgID = [data[@"msg_id"] integerValue];
    NSString *macAddress = data[@"device_info"][@"mac"];
    //无论是什么消息，都抛出该通知，证明设备在线
    [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveDeviceOnlineNotification
                                                        object:nil
                                                      userInfo:@{@"macAddress":macAddress}];
    if (msgID == 3004) {
        //上报的网络状态
        NSDictionary *resultDic = @{
            @"macAddress":macAddress,
            @"data":data[@"data"]
        };
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveDeviceNetStateNotification
                                                            object:nil
                                                          userInfo:resultDic];
        return;
    }
    if (msgID == 3007) {
        //固件升级结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveDeviceOTAResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3014) {
        //设备通过按键恢复出厂设置
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveDeviceResetByButtonNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3018) {
        //NCP固件升级结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveDeviceNpcOTAResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3022) {
        //EAP证书更新结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveDeviceUpdateEapCertsResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3032) {
        //MQTT证书更新结果
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveDeviceUpdateMqttCertsResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3070) {
        //扫描到的数据
        if ([self.dataDelegate respondsToSelector:@selector(mk_cu_receiveDeviceDatas:)]) {
            [self.dataDelegate mk_cu_receiveDeviceDatas:data];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveDeviceDatasNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3108) {
        //网关与已连接的BXP-Button设备断开了链接，非主动断开
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveGatewayDisconnectBXPButtonNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3117) {
        //BXP-B-D 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBXPBtnAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3166) {
        //BXP-B-CR 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBXPBtnCRAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3173) {
        //BXP-B-CR 触发记录数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBXPBtnCRAlarmEventDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3203 || msgID == 3206) {
        //BXP-Button升级进度    3206是MKCU3 V2
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBxpButtonDfuProgressNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3204 || msgID == 3207) {
        //BXP-Button升级结果 3207是MKCU3 V2
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBxpButtonDfuResultNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3208) {
        //MKCU3 V2 dfu升级完成
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBxpDfuFailedNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3302) {
        //网关与已连接的蓝牙设备断开了链接，非主动断开
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveGatewayDisconnectDeviceNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3311) {
        //网关接收到已连接的蓝牙设备的数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveGatewayConnectedDeviceDatasNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3358) {
        //BXP-C 实时温湿度数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBXPCRealTimeHTDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3361) {
        //BXP-C 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBXPCAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    
    if (msgID == 3364) {
        //BXP-C 历史温湿度数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBXPCHistoricalHTDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    
    if (msgID == 3416) {
        //BXP-D 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBXPDAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3468) {
        //BXP-T 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBXPTAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3508) {
        //BXP-S 实时温湿度数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBXPSRealTimeHTDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3511) {
        //BXP-S 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBXPSAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    
    if (msgID == 3514) {
        //BXP-S 历史温湿度数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveBXPSHistoricalHTDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    
    if (msgID == 3558) {
        //MK Pir传感器数据
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveMKPirSensorDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3608) {
        //MK Tof 三轴数据通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveMKTofAccDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3625) {
        //MK Tof 距离通知
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveMKTofDistanceDataNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    if (msgID == 3999) {
        //遗嘱，设备离线
        [[NSNotificationCenter defaultCenter] postNotificationName:MKCUReceiveDeviceOfflineNotification
                                                            object:nil
                                                          userInfo:data];
        return;
    }
    @synchronized(self.operationQueue) {
        NSArray *operations = [self.operationQueue.operations copy];
        for (NSOperation <MKCUMQTTOperationProtocol>*operation in operations) {
            if (operation.executing) {
                [operation didReceiveMessage:data onTopic:topic];
                break;
            }
        }
    }
}

- (void)cu_didChangeState:(MKCUMQTTSessionManagerState)newState {
    [[NSNotificationCenter defaultCenter] postNotificationName:MKCUMQTTSessionManagerStateChangedNotification object:nil];
}

#pragma mark - public method
- (NSString *)currentSubscribeTopic {
    return [MKCUMQTTServerManager shared].serverParams.subscribeTopic;
}

- (NSString *)currentPublishedTopic {
    return [MKCUMQTTServerManager shared].serverParams.publishTopic;
}

- (id<MKCUServerParamsProtocol>)currentServerParams {
    return [MKCUMQTTServerManager shared].currentServerParams;
}

- (BOOL)saveServerParams:(id <MKCUServerParamsProtocol>)protocol {
    return [[MKCUMQTTServerManager shared] saveServerParams:protocol];
}

- (BOOL)clearLocalData {
    return [[MKCUMQTTServerManager shared] clearLocalData];
}

- (BOOL)connect {
    return [[MKCUMQTTServerManager shared] connect];
}

- (void)disconnect {
    if (self.operationQueue.operations.count > 0) {
        [self.operationQueue cancelAllOperations];
    }
    [[MKCUMQTTServerManager shared] disconnect];
}

- (void)subscriptions:(NSArray <NSString *>*)topicList {
    [[MKCUMQTTServerManager shared] subscriptions:topicList];
}

- (void)unsubscriptions:(NSArray <NSString *>*)topicList {
    [[MKCUMQTTServerManager shared] unsubscriptions:topicList];
}

- (void)clearAllSubscriptions {
    [[MKCUMQTTServerManager shared] clearAllSubscriptions];
}

- (MKCUMQTTSessionManagerState)state {
    return [MKCUMQTTServerManager shared].state;
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_cu_serverOperationID)taskID
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    MKCUMQTTOperation *operation = [self generateOperationWithTaskID:taskID
                                                               topic:topic
                                                          macAddress:macAddress
                                                                data:data
                                                            sucBlock:sucBlock
                                                         failedBlock:failedBlock];
    if (!operation) {
        return;
    }
    [self.operationQueue addOperation:operation];
}

- (void)sendData:(NSDictionary *)data
           topic:(NSString *)topic
      macAddress:(NSString *)macAddress
          taskID:(mk_cu_serverOperationID)taskID
         timeout:(NSInteger)timeout
        sucBlock:(void (^)(id returnData))sucBlock
     failedBlock:(void (^)(NSError *error))failedBlock {
    MKCUMQTTOperation *operation = [self generateOperationWithTaskID:taskID
                                                               topic:topic
                                                          macAddress:macAddress
                                                                data:data
                                                            sucBlock:sucBlock
                                                         failedBlock:failedBlock];
    if (!operation) {
        return;
    }
    operation.operationTimeout = timeout;
    [self.operationQueue addOperation:operation];
}

#pragma mark - private method

- (MKCUMQTTOperation *)generateOperationWithTaskID:(mk_cu_serverOperationID)taskID
                                              topic:(NSString *)topic
                                        macAddress:(NSString *)macAddress
                                               data:(NSDictionary *)data
                                           sucBlock:(void (^)(id returnData))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidDict(data)) {
        [self operationFailedBlockWithMsg:@"The data sent to the device cannot be empty" failedBlock:failedBlock];
        return nil;
    }
    if (!ValidStr(topic) || topic.length > 128) {
        [self operationFailedBlockWithMsg:@"Topic error" failedBlock:failedBlock];
        return nil;
    }
    if ([MKMQTTServerManager shared].managerState != MKMQTTSessionManagerStateConnected) {
        [self operationFailedBlockWithMsg:@"MTQQ Server disconnect" failedBlock:failedBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKCUMQTTOperation *operation = [[MKCUMQTTOperation alloc] initOperationWithID:taskID macAddress:macAddress commandBlock:^{
        [[MKCUMQTTServerManager shared] sendData:data topic:topic sucBlock:nil failedBlock:nil];
    } completeBlock:^(NSError * _Nonnull error, id  _Nonnull returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            moko_dispatch_main_safe(^{
                if (failedBlock) {
                    failedBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failedBlock];
            return ;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock(returnData);
            }
        });
    }];
    return operation;
}

- (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.RGMQTTDataManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    moko_dispatch_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

#pragma mark - getter
- (NSOperationQueue *)operationQueue{
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 1;
    }
    return _operationQueue;
}

@end
