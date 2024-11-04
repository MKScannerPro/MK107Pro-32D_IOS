//
//  MKCUScanPageCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/4.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@class MKCUScanPageModel;
@interface MKCUScanPageCell : MKBaseCell

@property (nonatomic, strong)MKCUScanPageModel *dataModel;

+ (MKCUScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
