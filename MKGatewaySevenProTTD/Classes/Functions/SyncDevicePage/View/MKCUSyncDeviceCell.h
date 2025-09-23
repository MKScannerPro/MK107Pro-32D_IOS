//
//  MKCUSyncDeviceCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2025/3/7.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

#import "MKCUDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCUSyncDeviceCellModel : MKCUDeviceModel

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)BOOL selected;

@end

@protocol MKCUSyncDeviceCellDelegate <NSObject>

- (void)cu_syncDeviceCell_selected:(BOOL)selected index:(NSInteger)index;

@end

@interface MKCUSyncDeviceCell : MKBaseCell

@property (nonatomic, strong)MKCUSyncDeviceCellModel *dataModel;

@property (nonatomic, weak)id <MKCUSyncDeviceCellDelegate>delegate;

+ (MKCUSyncDeviceCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
