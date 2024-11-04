//
//  MKCUSystemTimeCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUSystemTimeCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *buttonTitle;

@end

@protocol MKCUSystemTimeCellDelegate <NSObject>

- (void)cu_systemTimeButtonPressed:(NSInteger)index;

@end

@interface MKCUSystemTimeCell : MKBaseCell

@property (nonatomic, strong)MKCUSystemTimeCellModel *dataModel;

@property (nonatomic, weak)id <MKCUSystemTimeCellDelegate>delegate;

+ (MKCUSystemTimeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
