//
//  MKCUDeviceListCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCUDeviceListCellDelegate <NSObject>

/**
 删除
 
 @param index 所在index
 */
- (void)cu_cellDeleteButtonPressed:(NSInteger)index;

@end

@class MKCUDeviceListModel;
@interface MKCUDeviceListCell : MKBaseCell

@property (nonatomic, weak)id <MKCUDeviceListCellDelegate>delegate;

@property (nonatomic, strong)MKCUDeviceListModel *dataModel;

+ (MKCUDeviceListCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
