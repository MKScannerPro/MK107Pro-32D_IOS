//
//  MKCURemoteReminderCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2025/1/20.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCURemoteReminderCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger index;

@end

@protocol MKCURemoteReminderCellDelegate <NSObject>

- (void)bxd_remindButtonPressed:(NSInteger)index;

@end

@interface MKCURemoteReminderCell : MKBaseCell

@property (nonatomic, strong)MKCURemoteReminderCellModel *dataModel;

@property (nonatomic, weak)id <MKCURemoteReminderCellDelegate>delegate;

+ (MKCURemoteReminderCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
