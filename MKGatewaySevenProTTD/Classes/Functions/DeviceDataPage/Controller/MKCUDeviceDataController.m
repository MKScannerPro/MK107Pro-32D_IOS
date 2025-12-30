//
//  MKCUDeviceDataController.m
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import "MKCUDeviceDataController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"
#import "NSDictionary+MKAdd.h"

#import "MKHudManager.h"

#import "MKCUMQTTDataManager.h"
#import "MKCUMQTTInterface.h"

#import "MKCUDeviceModeManager.h"
#import "MKCUDeviceModel.h"

#import "MKCUDeviceDataPageHeaderView.h"
#import "MKCUDeviceDataPageCell.h"

#import "MKCUSettingController.h"
#import "MKCUSettingForV2Controller.h"
#import "MKCUUploadOptionController.h"
#import "MKCUUploadOptionV2Controller.h"
#import "MKCUManageBleDevicesController.h"
#import "MKCUManageBleDevicesV2Controller.h"
#import "MKCUNormalConnectedController.h"
#import "MKCUBXPButtonController.h"
#import "MKCUBXPButtonV2Controller.h"
#import "MKCUBXPButtonCRController.h"
#import "MKCUBXPCController.h"
#import "MKCUBXPDController.h"
#import "MKCUBXPTController.h"
#import "MKCUBXPSController.h"
#import "MKCUPirController.h"
#import "MKCUTofController.h"

static NSTimeInterval const kRefreshInterval = 0.5f;

@interface MKCUDeviceDataController ()<UITableViewDelegate,
UITableViewDataSource,
MKCUDeviceDataPageHeaderViewDelegate,
MKCUReceiveDeviceDatasDelegate>

@property (nonatomic, strong)MKCUDeviceDataPageHeaderView *headerView;

@property (nonatomic, strong)MKCUDeviceDataPageHeaderViewModel *headerModel;

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

/// 定时刷新
@property (nonatomic, assign)CFRunLoopObserverRef observerRef;
//不能立即刷新列表，降低刷新频率
@property (nonatomic, assign)BOOL isNeedRefresh;

@end

@implementation MKCUDeviceDataController

- (void)dealloc {
    NSLog(@"MKCUDeviceDataController销毁");
    [MKCUDeviceModeManager sharedDealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //移除runloop的监听
    CFRunLoopRemoveObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MKCUMQTTDataManager shared].dataDelegate = nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
    if (self.headerModel.isOn) {
        [MKCUMQTTDataManager shared].dataDelegate = self;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDataFromServer];
    [self runloopObserver];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDeviceNameChanged:)
                                                 name:@"mk_cu_deviceNameChangedNotification"
                                               object:nil];
}

#pragma mark - super method
- (void)rightButtonMethod {
    if ([MKCUDeviceModeManager shared].isV2) {
        MKCUSettingForV2Controller *vc = [[MKCUSettingForV2Controller alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    MKCUSettingController *vc = [[MKCUSettingController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKCUDeviceDataPageCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel fetchCellHeight];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKCUDeviceDataPageCell *cell = [MKCUDeviceDataPageCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - MKCUDeviceDataPageHeaderViewDelegate

- (void)cu_updateLoadButtonAction {
    if ([MKCUDeviceModeManager shared].isV2) {
        MKCUUploadOptionV2Controller *vc = [[MKCUUploadOptionV2Controller alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    MKCUUploadOptionController *vc = [[MKCUUploadOptionController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cu_scannerStatusChanged:(BOOL)isOn {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    [MKCUMQTTInterface cu_configScanSwitchStatus:isOn
                                      macAddress:[MKCUDeviceModeManager shared].macAddress
                                           topic:[MKCUDeviceModeManager shared].subscribedTopic
                                        sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.headerModel.isOn = isOn;
        [self updateStatus];
    }
                                     failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)cu_manageBleDeviceAction {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKCUMQTTInterface cu_readGatewayBleConnectStatusWithMacAddress:[MKCUDeviceModeManager shared].macAddress
                                                              topic:[MKCUDeviceModeManager shared].subscribedTopic
                                                           sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        NSArray *deviceList = returnData[@"data"][@"ble_conn_list"];
        if (ValidArray(deviceList)) {
            //网关已经连接设备
            NSDictionary *connectDevice = deviceList[0];
            [self readConnectedDeviceInfoWithBleMac:connectDevice[@"mac"] type:[connectDevice[@"type"] integerValue]];
            return;
        }
        //网关没有连接设备
        if ([MKCUDeviceModeManager shared].isV2) {
            MKCUManageBleDevicesV2Controller *vc = [[MKCUManageBleDevicesV2Controller alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            return;
        }
        MKCUManageBleDevicesController *vc = [[MKCUManageBleDevicesController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
                                                        failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - MKCUReceiveDeviceDatasDelegate
- (void)mk_cu_receiveDeviceDatas:(NSDictionary *)data {
    if (!ValidDict(data) || !ValidStr(data[@"device_info"][@"mac"]) || ![[MKCUDeviceModeManager shared].macAddress isEqualToString:data[@"device_info"][@"mac"]]) {
        return;
    }
    NSArray *tempList = data[@"data"];
    if (!ValidArray(tempList)) {
        return;
    }
    for (NSDictionary *dic in tempList) {
        NSString *jsonString = [self convertToJsonData:dic];
        if (ValidStr(jsonString)) {
            MKCUDeviceDataPageCellModel *cellModel = [[MKCUDeviceDataPageCellModel alloc] init];
            cellModel.msg = jsonString;
            if (self.dataList.count == 0) {
                [self.dataList addObject:cellModel];
            }else {
                [self.dataList insertObject:cellModel atIndex:0];
            }
        }
    }
    [self needRefreshList];
}

- (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error = nil;
    NSData *policyData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&error];
    if(!policyData && error){
        return @"";
    }
    //NSJSONSerialization converts a URL string from http://... to http:\/\/... remove the extra escapes
    NSString *policyStr = [[NSString alloc] initWithData:policyData encoding:NSUTF8StringEncoding];
    policyStr = [policyStr stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    return policyStr;
}


- (void)receiveDeviceNameChanged:(NSNotification *)note {
    NSDictionary *user = note.userInfo;
    if (!ValidDict(user) || !ValidStr(user[@"macAddress"]) || ![[MKCUDeviceModeManager shared].macAddress isEqualToString:user[@"macAddress"]]) {
        return;
    }
    self.defaultTitle = user[@"deviceName"];
}

#pragma mark - interface
- (void)readDataFromServer {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKCUMQTTInterface cu_readScanSwitchStatusWithMacAddress:[MKCUDeviceModeManager shared].macAddress
                                                       topic:[MKCUDeviceModeManager shared].subscribedTopic
                                                    sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.headerModel.isOn = ([returnData[@"data"][@"scan_switch"] integerValue] == 1);
        self.headerView.dataModel = self.headerModel;
        [self updateStatus];
    }
                                                 failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)readConnectedDeviceInfoWithBleMac:(NSString *)bleMac type:(NSInteger)type {
    if (type == 0) {
        //通用链接
        [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
        [MKCUMQTTInterface cu_readNormalConnectedDeviceInfoWithBleMacAddress:bleMac macAddress:[MKCUDeviceModeManager shared].macAddress topic:[MKCUDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            [[MKHudManager share] hide];
            MKCUNormalConnectedController *vc = [[MKCUNormalConnectedController alloc] init];
            vc.deviceBleInfo = returnData;
            [self.navigationController pushViewController:vc animated:YES];
        } failedBlock:^(NSError * _Nonnull error) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        }];
        return;
    }
    if (type == 1) {
        //BXP-B-D
        [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
        [MKCUMQTTInterface cu_readBXPButtonConnectedDeviceInfoWithBleMacAddress:bleMac macAddress:[MKCUDeviceModeManager shared].macAddress topic:[MKCUDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            [[MKHudManager share] hide];
            
            if ([MKCUDeviceModeManager shared].isV2) {
                //V2
                MKCUBXPButtonV2Controller *vc = [[MKCUBXPButtonV2Controller alloc] init];
                vc.deviceBleInfo = returnData;
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
            
            MKCUBXPButtonController *vc = [[MKCUBXPButtonController alloc] init];
            vc.deviceBleInfo = returnData;
            [self.navigationController pushViewController:vc animated:YES];
        } failedBlock:^(NSError * _Nonnull error) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        }];
        return;
    }
    if (type == 2) {
        //BXP-B-CR
        [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
        [MKCUMQTTInterface cu_readBXPButtonCRConnectedDeviceInfoWithBleMacAddress:bleMac macAddress:[MKCUDeviceModeManager shared].macAddress topic:[MKCUDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            [[MKHudManager share] hide];
            MKCUBXPButtonCRController *vc = [[MKCUBXPButtonCRController alloc] init];
            vc.deviceBleInfo = returnData;
            [self.navigationController pushViewController:vc animated:YES];
        } failedBlock:^(NSError * _Nonnull error) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        }];
        return;
    }
    if (type == 3) {
        //BXP-C
        [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
        [MKCUMQTTInterface cu_readBXPCConnectedDeviceInfoWithBleMacAddress:bleMac macAddress:[MKCUDeviceModeManager shared].macAddress topic:[MKCUDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            [[MKHudManager share] hide];
            MKCUBXPCController *vc = [[MKCUBXPCController alloc] init];
            vc.deviceBleInfo = returnData;
            [self.navigationController pushViewController:vc animated:YES];
        } failedBlock:^(NSError * _Nonnull error) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        }];
        return;
    }
    if (type == 4) {
        //BXP-D
        [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
        [MKCUMQTTInterface cu_readBXPDConnectedDeviceInfoWithBleMacAddress:bleMac macAddress:[MKCUDeviceModeManager shared].macAddress topic:[MKCUDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            [[MKHudManager share] hide];
            MKCUBXPDController *vc = [[MKCUBXPDController alloc] init];
            vc.deviceBleInfo = returnData;
            [self.navigationController pushViewController:vc animated:YES];
        } failedBlock:^(NSError * _Nonnull error) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        }];
        return;
    }
    if (type == 5) {
        //BXP-T
        [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
        [MKCUMQTTInterface cu_readBXPTConnectedDeviceInfoWithBleMacAddress:bleMac macAddress:[MKCUDeviceModeManager shared].macAddress topic:[MKCUDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            [[MKHudManager share] hide];
            MKCUBXPTController *vc = [[MKCUBXPTController alloc] init];
            vc.deviceBleInfo = returnData;
            [self.navigationController pushViewController:vc animated:YES];
        } failedBlock:^(NSError * _Nonnull error) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        }];
        return;
    }
    if (type == 6) {
        //BXP-S
        [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
        [MKCUMQTTInterface cu_readBXPSConnectedDeviceInfoWithBleMacAddress:bleMac macAddress:[MKCUDeviceModeManager shared].macAddress topic:[MKCUDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            [[MKHudManager share] hide];
            MKCUBXPSController *vc = [[MKCUBXPSController alloc] init];
            vc.deviceBleInfo = returnData;
            [self.navigationController pushViewController:vc animated:YES];
        } failedBlock:^(NSError * _Nonnull error) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        }];
        return;
    }
    if (type == 7) {
        //MK Pir
        [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
        [MKCUMQTTInterface cu_readMKPirConnectedDeviceInfoWithBleMacAddress:bleMac macAddress:[MKCUDeviceModeManager shared].macAddress topic:[MKCUDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            [[MKHudManager share] hide];
            MKCUPirController *vc = [[MKCUPirController alloc] init];
            vc.deviceBleInfo = returnData;
            [self.navigationController pushViewController:vc animated:YES];
        } failedBlock:^(NSError * _Nonnull error) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        }];
        return;
    }
    if (type == 8) {
        //MK Tof
        [[MKHudManager share] showHUDWithTitle:@"Connecting..." inView:self.view isPenetration:NO];
        [MKCUMQTTInterface cu_readMKTofConnectedDeviceInfoWithBleMacAddress:bleMac macAddress:[MKCUDeviceModeManager shared].macAddress topic:[MKCUDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
            [[MKHudManager share] hide];
            MKCUTofController *vc = [[MKCUTofController alloc] init];
            vc.deviceBleInfo = returnData;
            [self.navigationController pushViewController:vc animated:YES];
        } failedBlock:^(NSError * _Nonnull error) {
            [[MKHudManager share] hide];
            [self.view showCentralToast:error.userInfo[@"errorInfo"]];
        }];
        return;
    }
}

#pragma mark - private method

/// 当扫描状态发生改变的时候，需要动态刷新UI，如果打开则添加扫描数据监听，如果关闭，则移除扫描数据监听
- (void)updateStatus {
    [self.dataList removeAllObjects];
    [self.headerView setDataModel:self.headerModel];
    [self.headerView updateTotalNumbers:0];
    [self.tableView reloadData];
    if (self.headerModel.isOn) {
        //打开
        [MKCUMQTTDataManager shared].dataDelegate = self;
        return;
    }
    //关闭状态
    [MKCUMQTTDataManager shared].dataDelegate = nil;
}

#pragma mark - 定时刷新

- (void)needRefreshList {
    //标记需要刷新
    self.isNeedRefresh = YES;
    //唤醒runloop
    CFRunLoopWakeUp(CFRunLoopGetMain());
}

- (void)runloopObserver {
    @weakify(self);
    __block NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    self.observerRef = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        @strongify(self);
        if (activity == kCFRunLoopBeforeWaiting) {
            //runloop空闲的时候刷新需要处理的列表,但是需要控制刷新频率
            NSTimeInterval currentInterval = [[NSDate date] timeIntervalSince1970];
            if (currentInterval - timeInterval < kRefreshInterval) {
                return;
            }
            timeInterval = currentInterval;
            if (self.isNeedRefresh) {
                [self.tableView reloadData];
                self.headerView.dataModel = self.headerModel;
                [self.headerView updateTotalNumbers:self.dataList.count];
                self.isNeedRefresh = NO;
            }
        }
    });
    //添加监听，模式为kCFRunLoopCommonModes
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), self.observerRef, kCFRunLoopCommonModes);
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = [MKCUDeviceModeManager shared].deviceName;
    [self.rightButton setImage:LOADICON(@"MKGatewaySevenProTTD", @"MKCUDeviceDataController", @"cu_moreIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (MKCUDeviceDataPageHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MKCUDeviceDataPageHeaderView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 175.f)];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (MKCUDeviceDataPageHeaderViewModel *)headerModel {
    if (!_headerModel) {
        _headerModel = [[MKCUDeviceDataPageHeaderViewModel alloc] init];
    }
    return _headerModel;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
