//
//  MKCUBXPTMotionEventController.m
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2025/2/12.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKCUBXPTMotionEventController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "NSString+MKAdd.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"

#import "MKBLEBaseSDKAdopter.h"

#import "MKCUMQTTDataManager.h"
#import "MKCUMQTTInterface.h"

#import "MKCUDeviceModeManager.h"
#import "MKCUDeviceModel.h"

#import "MKCUPressEventCountCell.h"

@interface MKCUBXPTMotionEventController ()<UITableViewDelegate,
UITableViewDataSource,
MKCUPressEventCountCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@end

@implementation MKCUBXPTMotionEventController

- (void)dealloc {
    NSLog(@"MKCUBXPTMotionEventController销毁");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadSectionDatas];
    [self readDatasFromDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKCUPressEventCountCell *cell = [MKCUPressEventCountCell initCellWithTableView:tableView];
    cell.dataModel =  self.dataList[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKCUPressEventCountCellDelegate
- (void)cu_pressEventCountCell_clearButtonPressed:(NSInteger)index {
    [[MKHudManager share] showHUDWithTitle:@"Waiting..." inView:self.view isPenetration:NO];
    [MKCUMQTTInterface cu_clearBXPTMotioEventCountWithBleMacAddress:self.bleMac macAddress:[MKCUDeviceModeManager shared].macAddress topic:[MKCUDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        MKCUPressEventCountCellModel *cellModel = self.dataList[0];
        cellModel.count = @"0";
        [self.tableView reloadData];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKCUMQTTInterface cu_readBXPTMotioEventCountWithBleMacAddress:self.bleMac macAddress:[MKCUDeviceModeManager shared].macAddress topic:[MKCUDeviceModeManager shared].subscribedTopic sucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        if ([returnData[@"data"][@"result_code"] integerValue] != 0) {
            [self.view showCentralToast:@"Read Failed"];
            return;
        }
        MKCUPressEventCountCellModel *cellModel = self.dataList[0];
        cellModel.count = [NSString stringWithFormat:@"%@",returnData[@"data"][@"count"]];
        
        [self.tableView reloadData];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    MKCUPressEventCountCellModel *cellModel = [[MKCUPressEventCountCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Motion event count";
    [self.dataList addObject:cellModel];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Motion event data";
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
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
