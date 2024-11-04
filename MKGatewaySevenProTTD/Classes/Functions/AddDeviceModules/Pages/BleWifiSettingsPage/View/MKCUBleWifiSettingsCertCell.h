//
//  MKCUBleWifiSettingsCertCell.h
//  MKGatewaySevenProTTD_Example
//
//  Created by aa on 2024/11/1.
//  Copyright © 2024 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCUBleWifiSettingsCertCellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *fileName;

@end

@protocol MKCUBleWifiSettingsCertCellDelegate <NSObject>

- (void)cu_bleWifiSettingsCertPressed:(NSInteger)index;

@end

@interface MKCUBleWifiSettingsCertCell : MKBaseCell

@property (nonatomic, strong)MKCUBleWifiSettingsCertCellModel *dataModel;

@property (nonatomic, weak)id <MKCUBleWifiSettingsCertCellDelegate>delegate;

+ (MKCUBleWifiSettingsCertCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
