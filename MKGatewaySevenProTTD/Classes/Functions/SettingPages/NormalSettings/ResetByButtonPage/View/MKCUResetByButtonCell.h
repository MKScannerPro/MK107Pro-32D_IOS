//
//  MKCUResetByButtonCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUResetByButtonCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)BOOL selected;

@end

@protocol MKCUResetByButtonCellDelegate <NSObject>

- (void)cu_resetByButtonCellAction:(NSInteger)index;

@end

@interface MKCUResetByButtonCell : MKBaseCell

@property (nonatomic, weak)id <MKCUResetByButtonCellDelegate>delegate;

@property (nonatomic, strong)MKCUResetByButtonCellModel *dataModel;

+ (MKCUResetByButtonCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
