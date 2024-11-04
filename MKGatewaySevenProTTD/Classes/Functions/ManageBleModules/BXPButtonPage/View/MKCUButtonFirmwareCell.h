//
//  MKCUButtonFirmwareCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUButtonFirmwareCellModel : NSObject

/// cell唯一识别号
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *leftMsg;

@property (nonatomic, copy)NSString *rightMsg;

@property (nonatomic, copy)NSString *rightButtonTitle;

@end

@protocol MKCUButtonFirmwareCellDelegate <NSObject>

- (void)cu_buttonFirmwareCell_buttonAction:(NSInteger)index;

@end

@interface MKCUButtonFirmwareCell : MKBaseCell

@property (nonatomic, strong)MKCUButtonFirmwareCellModel *dataModel;

@property (nonatomic, weak)id <MKCUButtonFirmwareCellDelegate>delegate;

+ (MKCUButtonFirmwareCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
