//
//  MKCUPressEventCountCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2025/1/19.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUPressEventCountCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *count;

@end

@protocol MKCUPressEventCountCellDelegate <NSObject>

- (void)cu_pressEventCountCell_clearButtonPressed:(NSInteger)index;

@end

@interface MKCUPressEventCountCell : MKBaseCell

@property (nonatomic, weak)id <MKCUPressEventCountCellDelegate>delegate;

@property (nonatomic, strong)MKCUPressEventCountCellModel *dataModel;

+ (MKCUPressEventCountCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
