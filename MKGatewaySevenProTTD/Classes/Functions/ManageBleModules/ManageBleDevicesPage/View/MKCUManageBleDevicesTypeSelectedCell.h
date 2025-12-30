//
//  MKCUManageBleDevicesTypeSelectedCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2025/1/18.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUManageBleDevicesTypeSelectedCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *msg;

@end

@protocol MKCUManageBleDevicesTypeSelectedCellDelegate <NSObject>

- (void)cu_manageBleDevicesTypeSelectedCell_selected:(BOOL)selected index:(NSInteger)index;

@end

@interface MKCUManageBleDevicesTypeSelectedCell : UITableViewCell

@property (nonatomic, weak)id <MKCUManageBleDevicesTypeSelectedCellDelegate>delegate;

@property (nonatomic, strong)MKCUManageBleDevicesTypeSelectedCellModel *dataModel;

+ (MKCUManageBleDevicesTypeSelectedCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
